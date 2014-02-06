#include <stdio.h>
#include "ccm.h"

int main(){
    double X1[10] = {1.2,0.2,0.3,2,3,4,5,1,2,3},
           Y1[10] = {5.4,0.5,0.6,0.7,5,4,3,6,7,8},
           X2[15] = {1.2,0.2,0.3,2,3,4,5,1,2,3,5,6,7,8,9},
           Y2[15] = {5.4,0.5,0.6,0.7,5,4,3,6,7,8,5,6,7,8,9},
           X3[24] = {1.2,0.2,0.3,2,3,4,5,1,2,3,5,6,7,8,9,.1,.2,.3,.4,.5,.6,.7,.8,.9},
           Y3[24] = {5.4,0.5,0.6,0.7,5,4,3,6,7,8,5,6,7,8,9,.1,.2,.3,.4,.5,.6,.7,.8,.9},
           X4[28] = {1.2,0.2,0.3,2,3,4,5,1,2,3,5,6,7,8,9,.1,.2,.3,.4,.5,.6,.7,.8,.9,23,100,34,50},
           Y4[28] = {5.4,0.5,0.6,0.7,5,4,3,6,7,8,5,6,7,8,9,.1,.2,.3,.4,.5,.6,.7,.8,.9,300,300,300,300};

    printf("%f\n",CCMcorr(Y1,10,X1,10,3,1));
    printf("%f\n",CCMcorr(Y2,15,X2,15,3,1));
    printf("%f\n",CCMcorr(Y3,24,X3,24,3,1));
    printf("%f\n",CCMcorr(Y4,28,X4,28,3,1));
    printf("%f\n",CCMcorr(Y2,15,X2,15,4,1));
    printf("%f\n",CCMcorr(Y3,24,X3,24,4,1));
    printf("%f\n",CCMcorr(Y4,28,X4,28,4,1));
    printf("%f\n",CCMcorr(Y2,15,X2,15,3,2));
    printf("%f\n",CCMcorr(Y3,24,X3,24,3,2));
    printf("%f\n",CCMcorr(Y4,28,X4,28,3,2));
    printf("%f\n",CCMcorr(Y2,15,X2,15,4,2));
    printf("%f\n",CCMcorr(Y3,24,X3,24,4,2));
    printf("%f\n",CCMcorr(Y4,28,X4,28,4,2));

    char buffer[1024] ;
    char *record,*line;
    int i=0,j=0;
    int mat[100][100];
    FILE *fstream = fopen("\myFile.csv","r");
    if(fstream == NULL)
    {
       printf("\n file opening failed ");
       return -1 ;
    }
    while((line=fgets(buffer,sizeof(buffer),fstream))!=NULL)
    {
      record = strtok(line,";");
      while(record != NULL)
      {
       printf("record : %s",record) ;    //here you can put the record into the array as per your requirement.
       mat[i][j++] = atoi(record) ;
       record = strtok(line,";");
      }
      ++i ;
    }
   
    return(0);
}


