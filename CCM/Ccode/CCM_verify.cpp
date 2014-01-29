#include <stdio.h>
#include <math.h>
#include <algorithm>

double CCMcorr(double[],int,double[],int,int,int);
double eDist(double[],double[],int);
int FindAndCheckIndex(double[],int,double,int[],int);

int main(){
    double X[10] = {1.2,0.2,0.3,2,3,4,5,1,2,3};
    double Y[10] = {5.4,0.5,0.6,0.7,5,4,3,6,7,8};
    int E = 3;
    int tau = 1;

    printf("%f\n",CCMcorr(Y,10,X,10,E,1));
    return(0);
}

/*CCMcorr -- Convergent Cross Mapped Correlation
  This function returns the (square) Pearson correlation coefficent
  between Y and the convergent cross mapped Y given X, i.e. Y
  estimated with weights calculated from the shadow manifold
  of X or Y|X.
 
  References: http://en.wikipedia.org/wiki/Convergent_cross_mapping
              https://www.sciencemag.org/content/338/6106/496.figures-only
              https://www.sciencemag.org/content/338/6106/496/suppl/DC1
             
  Dependencies:   eDist (function call)
                  FindAndCheckIndex (function call)
                  math.h (header)
 
  Input Parameters:
      double dY[] - time series to compared to its convergent
                   cross mapped counterpart given X
      int iY_length - library length of Y
      double dX_UsedForShadow[] - time series used to create
                                 the shadow manifold for
                                 estimating Y
      int iX_UsedForShadow_length - library length of X
      int iEmbeddingDimension - dimension of the shadow manifold
                               (notice that this values should be at
                               least 3 (i.e. 2+1) because this is a
                               pariwise CCM correlation)
      int iLagTime - lag time step used to construct the delay vectors
                    that make up the n-dimensional points of the
                    shadow manifold
                   
  Output Parameters:
      double - square of the Pearson correlation coefficent
               between Y and Y|X
*/
double CCMcorr(double dY[],int iY_length, double dX_UsedForShadow[],int iX_UsedForShadow_length, int iEmbeddingDimension,int iLagTime){

//================================ ERROR CHECKING ===========

    //Check Min
    if( iEmbeddingDimension < 3){
        fprintf(stderr, "Error in CCMCorr(): embedding dimension is %i which is less than 3\n", iEmbeddingDimension);
        return(-1);
    }
   
    //Check Max
    //TODO: Figure out maximum for Embedding dimension (it depends on
    //      LagTime and the library length of X)
    //if( EmbeddingDimension > MAX_TBD){
    //    fprintf(stderr, "Error in CCMCorr(): embedding dimension is %i which is more than %i\n", EmbeddingDimension,MAX_TBD);
    //    return(-1);
    //}
   
    //Check library lengths
    //TODO: It is currently assumed that X and Y are the same length
   
//================================ SHADOW MANIFOLD CREATION =
   
    //Find calculated shadow manifold dimension
    int iCalShadManDim = iX_UsedForShadow_length-((iEmbeddingDimension-1)*iLagTime);

    //Populate shadow manifold be creating the delay vectors sequentially
    double dXShadow[iCalShadManDim][iEmbeddingDimension];
    int iTstep4delayvector;
    for(int iShadowStep = 1; iShadowStep <= iCalShadManDim; iShadowStep++ ){
        iTstep4delayvector = iShadowStep+((iEmbeddingDimension-1)*iLagTime);
        //printf("%i\n",iTstep4delayvector);
        for(int iDimStep = 1; iDimStep <= iEmbeddingDimension; iDimStep++ ){
            dXShadow[iShadowStep-1][iDimStep-1] = dX_UsedForShadow[(iTstep4delayvector-((iDimStep-1)*iLagTime))-1];
            //printf("%f, ",dXShadow[iShadowStep-1][iDimStep-1]);
        }
        //printf("\n");
    }

//================================ NEAREST NEIGHBOR FINDING =


    //Define matrix to store the norm distances
    double dXShadowNorms[iX_UsedForShadow_length][iX_UsedForShadow_length];
    double dXShadowNormsSortedValues[iX_UsedForShadow_length][iX_UsedForShadow_length];
    double dXShadowNormsSortedIndices[iX_UsedForShadow_length][iX_UsedForShadow_length];
   
    //Temporary storage for sorting, calculating, and organizing
    double dDelayVectorOfInterest[iEmbeddingDimension];
    double dDelayVector2Compare[iEmbeddingDimension];
    double dUnsortedNorms[iCalShadManDim];
    double dSortedNorms[iCalShadManDim];
    double dYEstimateGivenX[iCalShadManDim];
    double dWeights[(iEmbeddingDimension+1)];
    double dWeightDenominator;
    double dWeightNormalization;
    int iTstepOfNearestNeighbors[iCalShadManDim][iEmbeddingDimension+1];
    int iTstepOfNearestNeighborsTempRow[iEmbeddingDimension+1];
   
    //Find starting point in Y for the estimate
    int iYStart = (iEmbeddingDimension-1)*iLagTime;

    //Loop through all of the delay vectors to find it distance to every other one
    for(int iDelayVectorN = 1; iDelayVectorN <= iCalShadManDim; iDelayVectorN++ ){

        //Populate the temp delay vector
        for(int iCopyStep = 0; iCopyStep < iEmbeddingDimension; iCopyStep++ ){
            dDelayVectorOfInterest[iCopyStep] = dXShadow[iDelayVectorN-1][iCopyStep];
        }
       
        //Loop through all of the delay vector to compare to the temp delay vector
        for(int iTstep = 1; iTstep <= iCalShadManDim; iTstep++ ){
       
            //Populate the temp delay vector for comparison
            for(int iCopyStep = 0; iCopyStep < iEmbeddingDimension; iCopyStep++ ){
                dDelayVector2Compare[iCopyStep] = dXShadow[iTstep-1][iCopyStep];
            }
           
            //Find the distance between the two temp vectors and save it
            dXShadowNorms[iDelayVectorN-1][iTstep-1] = eDist(dDelayVectorOfInterest,dDelayVector2Compare,iEmbeddingDimension);

            //Save the norms to be sorted later
            dUnsortedNorms[iTstep-1] = dXShadowNorms[iDelayVectorN-1][iTstep-1];
            dSortedNorms[iTstep-1] = dXShadowNorms[iDelayVectorN-1][iTstep-1];
           
            //printf("%f,",dXShadowNorms[iDelayVectorN-1][iTstep-1]);
        }
        //printf("\n");
       
        //Sort the norms
        std::sort(dSortedNorms,dSortedNorms+iCalShadManDim);
        //for(int iPrintStep = 0; iPrintStep < iCalShadManDim; iPrintStep++ ){
        //    printf("%f,",dSortedNorms[iPrintStep]);
        //}
        //printf("\n");
        //for(int iPrintStep = 0; iPrintStep < iCalShadManDim; iPrintStep++ ){
        //    printf("%f,",dUnsortedNorms[iPrintStep]);
        //}
        //printf("\n");
       
        //Save the time step locations of the E+1 closest neighbors
        int iTempValue = 0;
        for(int iEDimStep = 0; iEDimStep < (iEmbeddingDimension+1); iEDimStep++ ){
            iTstepOfNearestNeighborsTempRow[iEDimStep] = 0;
        }
        for(int iEDimStep = 0; iEDimStep < (iEmbeddingDimension+1); iEDimStep++ ){
            iTempValue = FindAndCheckIndex(dUnsortedNorms,iCalShadManDim,dSortedNorms[iEDimStep+1],iTstepOfNearestNeighborsTempRow,(iEmbeddingDimension+1));
            iTstepOfNearestNeighborsTempRow[iEDimStep] = iTempValue;
            iTstepOfNearestNeighbors[iDelayVectorN-1][iEDimStep] = iTempValue;
        }
        //for(int iEDimStep = 0; iEDimStep < (iEmbeddingDimension+1); iEDimStep++ ){
        //    printf("%i,",iTstepOfNearestNeighborsTempRow[iEDimStep]);
        //}
        //printf("\n");
       
        //Find denominator for weight calculation
        if( dSortedNorms[1] == 0 ){
            dWeightDenominator = 0.00000000000000000001;
            fprintf(stderr, "Warning in CCMCorr(): division by zero; approximation made\n");
        }else{
            dWeightDenominator = dSortedNorms[1];
        }
               
        //Find weights
        dWeightNormalization = 0;
        for( int iWeightStep = 0;iWeightStep < (iEmbeddingDimension+1);iWeightStep++ ){
            dWeights[iWeightStep] = exp((-1*dSortedNorms[iWeightStep+1])/dWeightDenominator);
            dWeightNormalization += dWeights[iWeightStep];
            //printf("%f,",dWeights[iWeightStep]);
        }
        //printf("\n");
       
        //Find normalizaed weights
        for( int iWeightStep = 0;iWeightStep < (iEmbeddingDimension+1);iWeightStep++ ){
            dWeights[iWeightStep] = dWeights[iWeightStep]/dWeightNormalization;
            //printf("%f,",dWeights[iWeightStep]);
        }
        //printf("\n");
       
        //Find Y point estimates from X shadow manifold
        dYEstimateGivenX[iDelayVectorN-1] = 0;
        for( int iWeightStep = 0;iWeightStep < (iEmbeddingDimension+1);iWeightStep++ ){
            dYEstimateGivenX[iDelayVectorN-1] += dWeights[iWeightStep]*dY[(iYStart+iTstepOfNearestNeighborsTempRow[iWeightStep])];
        //printf("%f,",dY[(iYStart+iTstepOfNearestNeighborsTempRow[iWeightStep])]);
        }
        //printf("\n");
        printf("%f\n",dYEstimateGivenX[iDelayVectorN-1]);
    }

    return(iCalShadManDim);
}

/*eDist -- Euclidean Distance
  This function returns the Euclidean distance between two
  vectors X and Y.  It is assumed that X and Y are the same
  length.
 
  References: http://en.wikipedia.org/wiki/Euclidean_distance
              http://www.mathworks.com/help/matlab/ref/norm.html#bt0y64c-1
             
  Dependencies:   math.h (header)
 
  Input Parameters:
      double dX[] - vector of values
      double dY[] - vector of values
      int iXY_length - length of X and Y
                   
  Output Parameters:
      double - Euclidean distance between X and Y
*/
double eDist(double dX[],double dY[],int iXY_length){
   
    double dRunningSum = 0;
   
    for(int iter = 0; iter < iXY_length; iter++ ){
        dRunningSum += pow((dX[iter]-dY[iter]),2);
    }
   
    return(sqrt(dRunningSum));
}

/*FindAndCheckIndex -- Find index location in array
  This function returns the index location of the element
  of a 1D array that is equal to a specificed value as long as
  that index value is not present in a specified 1D array of
  values.  It is assumed that a match will be made and an
  error is reported if no match is found.
 
  References:
             
  Dependencies:  
 
  Input Parameters:
      double dValues2BCompared[] - 1D array of values in which the match
                                   is to be found
      int iValues2BCompared_length - length of Values2BCompared array
      double dValue2Compare - value used to define the match
      int iIndices2Check[] - 1D array of indices to check against
      int iIndices2Check_length - length of Indicies2Check array                 

  Output Parameters:
      int - index location for value in dValues2BCompared[] that is
            equal to dValue2Compare, as long as that index value is
            not in iIndices2Check[]
*/
int FindAndCheckIndex(double dValues2BCompared[],int iValues2BCompared_length,double dValue2Compare,int iIndices2Check[],int iIndices2Check_length){
   
    bool bUniqueIndex = false,
         bFoundMatch = false;
   
    for(int iter = 0;iter < iValues2BCompared_length;iter++ ){
        for(int iIndexCheckStep = 0;iIndexCheckStep < iIndices2Check_length;iIndexCheckStep++ ){
            if( iter == iIndices2Check[iIndexCheckStep] ){
                bUniqueIndex = false;
            }else{
                bUniqueIndex = true;
            }
        }
           
        if( dValues2BCompared[iter] == dValue2Compare ){
            bFoundMatch = true;
        }
        if( bFoundMatch && bUniqueIndex){
            return(iter);   
        }
    }
   
     fprintf(stderr, "Error in FindAndCheckIndex(): no match was found, so an index of -1 will be returned");
    return(-1);   
}



