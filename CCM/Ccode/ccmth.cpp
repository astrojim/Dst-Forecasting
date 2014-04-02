#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <thread>
#include <future>
#include <chrono>
#include "ccmsrc.h"

using namespace std;

// Create a struct to pass to the threads
struct CCM_asyncData{

	int iEmbeddingDimension,
	    iLagTimeStep,
	    iLibraryLength;

	double *dX,*dY;

};

// Simple functions to help stay organized
void CmdLineHelp();
bool ReadCmdLineArgs(int,char**);
double CCMcorr_async(CCM_asyncData);

// Globals read from command line
int iEmbeddingDimension = -1,
    iLagTimeStep = -1,
    iLibraryLength = -1,
    iNumOfTimeSeries = -1,
    iNumThreads = -1;

char *cOutputname,
     *cFilename; //this data file is assumed to be in the proper format (see "usage")

bool bVerboseFlag = false,
     bOptThreading = false;

// Main
int main(int argc, char **argv){

    bool bCmdLineOK = ReadCmdLineArgs(argc,argv);
    if( !bCmdLineOK ){
        return(-1);
    }

    char cBuffer[1024]; //read in buffer
    char *cColValue, //used for read in
         *cRowValues; //used for read in
    int iter = 0;
    double dX[iLibraryLength],
           dY[iLibraryLength];

    //Declare things needed for threading
    double dCCMcorrs[iNumThreads][2];
    future<double> WorkerThreads[iNumThreads][2];
    future_status WorkerStatus[2];
    CCM_asyncData sThreadData;
    sThreadData.iEmbeddingDimension = iEmbeddingDimension;
    sThreadData.iLagTimeStep = iLagTimeStep;
    sThreadData.iLibraryLength = iLibraryLength;

    if( bVerboseFlag ){
            printf("Input data file: %s\nOutput file: %s\nNumber of time series in input file: %i\nLibrary length: %i\nEmbedding dimension: %i\nLag time step: %i\n",cFilename,cOutputname,iNumOfTimeSeries,iLibraryLength,iEmbeddingDimension,iLagTimeStep);
    }

    //open data input faile
    FILE *ifstream = fopen(cFilename,"r");
    if(ifstream == NULL){
        fprintf(stderr, "Error: Cannot open %s\n",cFilename);
            return(-1);
    }

    //open output file
    FILE *ofstream = fopen(cOutputname,"w");
    if(ofstream == NULL){
        fprintf(stderr, "Error: Cannot open %s\n",cFilename);
        return(-1);
    }

    if( bVerboseFlag ){ printf("Processing %s...\n",cFilename); }
    int iCurrentThreadsUsed = 0,
        iCheckThread = 0;
    bool bFoundOpenThread;
    for(int iTSiter = 0;iTSiter < iNumOfTimeSeries;iTSiter++ ){

	if( bVerboseFlag ){ printf("TS %i:",iTSiter); }
	if( bVerboseFlag ){ printf("Reading TS..."); }
	bFoundOpenThread = false;

        //read in dX and dY
        for( iter=0;iter < iLibraryLength;iter++ ){
		cRowValues = fgets(cBuffer,sizeof(cBuffer),ifstream);
		cColValue = strtok(cRowValues,",");
		if( cColValue != NULL ){
		   dX[iter] = atof(cColValue);
		}else{
		   fprintf(stderr, "Error: %s is not formatted correctly\n",cFilename);
		}

		cColValue = strtok(NULL,";");
		if( cColValue != NULL ){
		   dY[iter] = atof(cColValue);
		}else{
		   fprintf(stderr, "Error: %s is not formatted correctly\n",cFilename);
		}
        }

        if( bVerboseFlag ){ printf("Writing CCMs..."); }

        if( iNumThreads == 0 ){

            //fprintf(ofstream,"%.20f,",CCMcorr(dX,iLibraryLength,dY,iLibraryLength,iEmbeddingDimension,iLagTimeStep));
            //fprintf(ofstream,"%.20f\n",CCMcorr(dY,iLibraryLength,dX,iLibraryLength,iEmbeddingDimension,iLagTimeStep));
	      
	      sThreadData.dX = dX;
	      sThreadData.dY = dY;
              fprintf(ofstream,"%.20f,",CCMcorr_async(sThreadData));
	      //printf("%.20f,",CCMcorr_async(sThreadData));
	      sThreadData.dX = dY;
	      sThreadData.dY = dX;
              fprintf(ofstream,"%.20f\n",CCMcorr_async(sThreadData));
	      //printf("%.20f\n",CCMcorr_async(sThreadData));

        }else{
            if( iCurrentThreadsUsed < iNumThreads ){

               	sThreadData.dX = dX;
		sThreadData.dY = dY;
                WorkerThreads[iCurrentThreadsUsed][0] = async(launch::async,CCMcorr_async,sThreadData);

		sThreadData.dX = dY;
		sThreadData.dY = dX;
		WorkerThreads[iCurrentThreadsUsed][1] = async(launch::async,CCMcorr_async,sThreadData);

		iCurrentThreadsUsed++;

            }else{

		if( bOptThreading ){

                    while( !bFoundOpenThread ){
                        if( WorkerThreads[iCheckThread][0].valid() && WorkerThreads[iCheckThread][1].valid() ){
                            
			    WorkerStatus[0] = WorkerThreads[iCheckThread][0].wait_for(chrono::seconds(0));
                            WorkerStatus[1] = WorkerThreads[iCheckThread][1].wait_for(chrono::seconds(0));
                            
			    if( (WorkerStatus[0] == future_status::ready) && (WorkerStatus[1] == future_status::ready) ){


				fprintf(ofstream,"%.20f,",WorkerThreads[iCheckThread][0].get());
				fprintf(ofstream,"%.20f\n",WorkerThreads[iCheckThread][1].get());
				//printf("%.20f,",WorkerThreads[iCheckThread][0].get());
				//printf("%.20f\n",WorkerThreads[iCheckThread][1].get());
                                sThreadData.dX = dX;
                                sThreadData.dY = dY;
                                WorkerThreads[iCheckThread][0] = async(launch::async,CCMcorr_async,sThreadData);

                                sThreadData.dX = dY;
                                sThreadData.dY = dX;
                                WorkerThreads[iCheckThread][1] = async(launch::async,CCMcorr_async,sThreadData);

                                bFoundOpenThread = true;

                            }

                        }else if(!WorkerThreads[iCheckThread][0].valid() && !WorkerThreads[iCheckThread][1].valid() ){

                            sThreadData.dX = dX;
                            sThreadData.dY = dY;
                            WorkerThreads[iCheckThread][0] = async(launch::async,CCMcorr_async,sThreadData);

                            sThreadData.dX = dY;
                            sThreadData.dY = dX;
                            WorkerThreads[iCheckThread][1] = async(launch::async,CCMcorr_async,sThreadData);

                            bFoundOpenThread = true;

                        }else{

                            iCheckThread++;
                            if( iCheckThread > iNumThreads ){
                                iCheckThread = 0;
                            }

                        }

                    }

                }else{

                    for(int iThreadIter = 0;iThreadIter < iNumThreads;iThreadIter++ ){
                        
			if( WorkerThreads[iThreadIter][0].valid() && WorkerThreads[iThreadIter][1].valid() ){
                            dCCMcorrs[iThreadIter][0] = WorkerThreads[iThreadIter][0].get();
                            dCCMcorrs[iThreadIter][1] = WorkerThreads[iThreadIter][1].get();

                        }

                    }

                    iCurrentThreadsUsed = 0;

                    sThreadData.dX = dX;
                    sThreadData.dY = dY;
                    WorkerThreads[iCurrentThreadsUsed][0] = async(launch::async,CCMcorr_async,sThreadData);

                    sThreadData.dX = dY;
                    sThreadData.dY = dX;
                    WorkerThreads[iCurrentThreadsUsed][1] = async(launch::async,CCMcorr_async,sThreadData);

                    for(int iThreadIter = 0;iThreadIter < iNumThreads;iThreadIter++ ){
                        fprintf(ofstream,"%.20f,",dCCMcorrs[iThreadIter][0]);
                        fprintf(ofstream,"%.20f\n",dCCMcorrs[iThreadIter][1]);
			//printf("%.20f,",dCCMcorrs[iThreadIter][0]);
                        //printf("%.20f\n",dCCMcorrs[iThreadIter][1]);
                        dCCMcorrs[iThreadIter][0] = nan("");
                        dCCMcorrs[iThreadIter][1] = nan("");
                    }

                }
            }
        }

        if( bVerboseFlag ){ printf(" done.\n"); }

    }
    fclose(ifstream);
    fclose(ofstream);

    if( bVerboseFlag ){ printf(" Finished.\n"); }

    return(0);
}

void CmdLineHelp(char* cName){

    printf("usage: %s -E [integer1] -t [integer2] -L [integer3] -f [filename1] -n [integer4] -p [integer5] -o [filename2] -v\n",cName);
    printf("  [integer1]  = embedding dimension\n");
    printf("  [integer2]  = lag time step\n");
    printf("  [integer3]  = library length of the time series (assumed to be equal for X and Y)\n");
    printf("  [filename1] = filename of text file containing time series data for X and Y with\n");
    printf("                columns seperated by commas and rows seperated by semicolons (it is\n");
    printf("                assumed that there are only X and Y in the file, i.e. only two columns)\n");
    printf("  [integer4]  = number of time series in the file\n");
    printf("  [integer5]  = number of threads to use (default is zero)\n");
    printf("  [filename2] = filename of text file containing ouput CCM correlations\n");
    printf("  -v flag provides various bits of information sent to STDOUT\n");
    printf("input data file format:  X0,Y0;\n");
    printf("                         X1,Y1;\n");
    printf("                         X2,Y2;\n");
    printf("                         X3,Y3;\n");
    printf("                         X4,Y4;\n");
    printf("                          ...\n");
    printf("output data file format: CCM(X,Y),CCM(Y,X) [time series 1]\n");
    printf("                         CCM(X,Y),CCM(Y,X) [time series 2]\n");
    printf("                                ...\n");

}

bool ReadCmdLineArgs(int argc, char **argv){

    bool bInputSet = false,
         bOutputSet = false;

    for(int iter=1;iter < argc;iter++ ){

        if( (strcmp("-h",argv[iter]) == 0) || (strcmp("-?",argv[iter]) == 0) ){
            CmdLineHelp(argv[0]);
            return( false );

        }else if( strcmp("-E",argv[iter]) == 0 ){

            iEmbeddingDimension = atoi(argv[iter+1]);

        }else if( strcmp("-t",argv[iter]) == 0 ){

            iLagTimeStep = atoi(argv[iter+1]);

        }else if( strcmp("-L",argv[iter]) == 0 ){

            iLibraryLength = atoi(argv[iter+1]);

        }else if( strcmp("-f",argv[iter]) == 0 ){

            cFilename = argv[iter+1];
            bInputSet = true;

        }else if( strcmp("-n",argv[iter]) == 0 ){

            iNumOfTimeSeries = atoi(argv[iter+1]);

        }else if( strcmp("-p",argv[iter]) == 0 ){

            iNumThreads = atoi(argv[iter+1]);

        }else if( strcmp("-o",argv[iter]) == 0 ){

            cOutputname = argv[iter+1];
            bOutputSet = true;

        }else if( strcmp("-v",argv[iter]) == 0 ){

            bVerboseFlag = true;

        }else if( strcmp("-Op",argv[iter]) == 0 ){

            bOptThreading = true;

        }
    }

    //Make sure the required things were defined
    if( iEmbeddingDimension == -1 ){
        fprintf(stderr, "Error: embedding dimension is not defined\n\n");
        CmdLineHelp(argv[0]);
        return( false );
    }
    if( iLagTimeStep == -1 ){
        fprintf(stderr, "Error: lag time step is not defined\n\n");
        CmdLineHelp(argv[0]);
        return( false );
    }
    if( iLibraryLength == -1 ){
        fprintf(stderr, "Error: library length is not defined\n\n");
        CmdLineHelp(argv[0]);
        return( false );
    }
    if( !bInputSet ){
        fprintf(stderr, "Error: input data filename is not defined\n\n");
        CmdLineHelp(argv[0]);
        return( false );
    }
    if( iNumOfTimeSeries == -1 ){
        fprintf(stderr, "Error: number of time series in input data file not defined\n\n");
        CmdLineHelp(argv[0]);
        return( false );
    }
    if( !bOutputSet ){
        fprintf(stderr, "Error: output data filename is not defined\n\n");
        CmdLineHelp(argv[0]);
        return( false );
    }

    //Issue any warnings
    if( iNumThreads == -1 ){
        fprintf(stderr, "Warning: number of threads not defined; using default\n");
        iNumThreads = 0;
    }
    if( bVerboseFlag && (iNumThreads != 0) ){
        fprintf(stderr, "Warning: verbose logging is not available with multiple threads; turning off verbose output\n");
        bVerboseFlag = false;
    }

    return( true );
}

double CCMcorr_async(CCM_asyncData sThreadData){

	double dResult = CCMcorr(sThreadData.dX,sThreadData.iLibraryLength,sThreadData.dY,sThreadData.iLibraryLength,sThreadData.iEmbeddingDimension,sThreadData.iLagTimeStep);
	return( dResult );

}
