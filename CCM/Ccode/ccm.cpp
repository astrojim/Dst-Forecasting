#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "ccm.h"

int main(int argc, char **argv){

    int iEmbeddingDimension,
	iLagTimeStep,
	iLibraryLength;

    char *cFilename; //this data file is assumed to be in the proper format (see "usage")

    //================= READ COMMAND LINE ARGS
    if( (argc < 8) || (strcmp("-h",argv[1]) == 0) || (strcmp("-?",argv[1]) == 0) ){

	printf("usage: %s -E [integer1] -t [integer2] -L [integer3] -f [filename]\n",argv[0]);
	printf("  [integer1] = embedding dimension\n");
	printf("  [integer2] = lag time step\n");
	printf("  [integer3] = library length of the time series (assumed to be equal for X and Y)\n");
	printf("  [filename] = filename of text file containing time series data for X and Y with\n");
	printf("               columns seperated by commas and rows seperated by semicolons (it is\n");
	printf("               assumed that there are only X and Y in the file, i.e. only two columns)\n");
	printf("data file format:  X0,Y0;\n");
   	printf("		   X1,Y1;\n");
   	printf("		   X2,Y2;\n");
   	printf("		   X3,Y3;\n");
   	printf("		   X4,Y4;\n");
   	printf("		    ...\n");
	printf("output: \"CCM(X,Y),CCM(Y,X)\"\n");

	return(-1);

    }else{

	if( strcmp("-E",argv[1]) == 0 ){
		iEmbeddingDimension = atoi(argv[2]);
	}else{
		fprintf(stderr, "Error: embedding dimension is not defined\n");
		return(-1);
	}

	if( strcmp("-t",argv[3]) == 0 ){
		iLagTimeStep = atoi(argv[4]);
	}else{
		fprintf(stderr, "Error: lag time step is not defined\n");
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
		fprintf(stderr, "Error: data file name is not defined\n");
		return(-1);
	}
    }

    //================= READ DATA FILE
    char cBuffer[1024]; //read in buffer
    char *cColValue, 
         *cRowValues;
    int iter = 0;
    double dX[iLibraryLength],
	   dY[iLibraryLength];

    FILE *fstream = fopen(cFilename,"r");
    if(fstream == NULL){
        fprintf(stderr, "Error: Cannot open %s\n",cFilename);
	return(-1);
    }

    while( (cRowValues = fgets(cBuffer,sizeof(cBuffer),fstream)) != NULL ){

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
        iter++;
    }

    //================= OUTPUT CCMs
    printf("%.15f,",CCMcorr(dX,iLibraryLength,dY,iLibraryLength,iEmbeddingDimension,iLagTimeStep));
    printf("%.15f\n",CCMcorr(dY,iLibraryLength,dX,iLibraryLength,iEmbeddingDimension,iLagTimeStep));
   
    return(0);
}


