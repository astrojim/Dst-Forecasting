#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ccm.h"

int main(int argc, char **argv){

    int iMaxAutoCorrToCheck,
	iLibraryLength,
	iNumOfTimeSeries;

    double dCompareTolerance;

    char *cOutputname,
	 *cFilename; //this data file is assumed to be in the proper format (see "usage")

    bool bVerboseFlag = false;

    //================= READ COMMAND LINE ARGS
    if( (argc < 12) || (strcmp("-h",argv[1]) == 0) || (strcmp("-?",argv[1]) == 0) ){

	printf("usage: %s -M [integer1] -T [float1] -L [integer3] -f [filename1] -n [integer4] -o [filename2] -v\n",argv[0]);
	printf("  [integer1]  = max autocorrelation to check\n");
	printf("  [float1]  = comparison tolerance\n");
	printf("  [integer3]  = library length of the time series (assumed to be equal for X and Y)\n");
	printf("  [filename1] = filename of text file containing time series data for X and Y with\n");
	printf("                columns seperated by commas and rows seperated by semicolons (it is\n");
	printf("                assumed that there are only X and Y in the file, i.e. only two columns)\n");
	printf("  [integer4]  = number of time series in the file\n");
	printf("  [filename2] = filename of text file in which to write the ouput lag calculations\n");
	printf("  -v flag provides various bits of information sent to STDOUT\n");
	printf("input data file format:  X0,Y0;\n");
   	printf("	   	         X1,Y1;\n");
   	printf("		         X2,Y2;\n");
   	printf("		         X3,Y3;\n");
   	printf("		         X4,Y4;\n");
   	printf("		          ...\n");
	printf("output data file format: lag(X),lag(Y) [time series 1]\n");
	printf("                         lag(X),lag(Y) [time series 2]\n");
	printf("                                ...\n");

	return(-1);

    }else{

	if( strcmp("-M",argv[1]) == 0 ){
		iMaxAutoCorrToCheck = atoi(argv[2]);
	}else{
		fprintf(stderr, "Error: maximum autocorrelation to check is not defined\n");
		return(-1);
	}

	if( strcmp("-T",argv[3]) == 0 ){
		dCompareTolerance = atof(argv[4]);
	}else{
		fprintf(stderr, "Error: comparison tolerance is not defined\n");
		return(-1);
	}

	if( strcmp("-L",argv[5]) == 0 ){
		iLibraryLength = atoi(argv[6]);
	}else{
		fprintf(stderr, "Error: library length is not defined\n");
		return(-1);
	}

	if( strcmp("-f",argv[7]) == 0 ){
		cFilename = argv[8];
	}else{
		fprintf(stderr, "Error: input data file name is not defined\n");
		return(-1);
	}

	if( strcmp("-n",argv[9]) == 0 ){
		iNumOfTimeSeries = atoi(argv[10]);
	}else{
		fprintf(stderr, "Error: number of time series in input data file not defined\n");
		return(-1);
	}

	if( strcmp("-o",argv[11]) == 0 ){
		cOutputname = argv[12];
	}else{
		fprintf(stderr, "Error: output data file name is not defined\n");
		return(-1);
	}

	if( argc > 13 ){
		if( strcmp("-v",argv[13]) == 0 ){
			bVerboseFlag = true;
		}
	}
    }

    //================= READ DATA FILE
    char cBuffer[1024]; //read in buffer
    char *cColValue, 
         *cRowValues;
    int iter = 0;
    double dX[iLibraryLength],
	   dY[iLibraryLength];

    if( bVerboseFlag ){
	printf("Input data file: %s\nOutput file: %s\nNumber of time series in input file: %i\nLibrary length: %i\nMax autocorrelation to check: %i\nComparison tolerance: %f\n",cFilename,cOutputname,iNumOfTimeSeries,iLibraryLength,iMaxAutoCorrToCheck,dCompareTolerance);
    }

    FILE *ifstream = fopen(cFilename,"r");
    if(ifstream == NULL){
        fprintf(stderr, "Error: Cannot open %s\n",cFilename);
	return(-1);
    }

    FILE *ofstream = fopen(cOutputname,"w");
    if(ofstream == NULL){
        fprintf(stderr, "Error: Cannot open %s\n",cFilename);
	return(-1);
    }

    if( bVerboseFlag ){ printf("Processing %s...\n",cFilename); }
    for(int iTSiter = 0;iTSiter < iNumOfTimeSeries;iTSiter++ ){

	    if( bVerboseFlag ){ printf("TS %i:",iTSiter); }

	    if( bVerboseFlag ){ printf(" Reading TS..."); }
		
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

	    if( bVerboseFlag ){ printf("Writing Lags..."); }

	    //================= OUTPUT Lags
	    fprintf(ofstream,"%i,",FindLagTimeStep(dX,iLibraryLength,iMaxAutoCorrToCheck,dCompareTolerance,false));
	    fprintf(ofstream,"%i\n",FindLagTimeStep(dY,iLibraryLength,iMaxAutoCorrToCheck,dCompareTolerance,false));

	    if( bVerboseFlag ){ printf(" done.\n"); }
    }   
    fclose(ifstream);
    fclose(ofstream);

    if( bVerboseFlag ){ printf(" Finished.\n"); }

    return(0);
}


