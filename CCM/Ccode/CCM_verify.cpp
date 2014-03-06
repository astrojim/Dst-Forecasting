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

    printf("%.20f\n",CCMcorr(Y4,28,X4,28,3,1));
   
    int iCalLag = FindLagTimeStep(X4,28,10,0.001,false),
        iCalEdim =FindEmbeddingDimension(X4,28,10,0.001,1,false);
    if( iCalEdim != -1 ){
        printf("%i,%i -> %.20f\n",iCalLag,iCalEdim,CCMcorr(Y4,28,X4,28,iCalEdim,iCalLag));
    }else{
        printf("Failed to find embedding dimension.\n");
    }
       
    return(0);
}


