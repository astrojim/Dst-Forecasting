#include <stdio.h>
#include <math.h>
#include <algorithm>

double CCMcorr(double[],int,double[],int,int,int);
double eDist(double[],double[],int);
int FindAndCheckIndex(double[],int,double,int[],int);
double Pcorr(double[], double[], int);

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
                  Pcorr (function call)
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

    //Check Min
    if( iEmbeddingDimension < 3){
        fprintf(stderr, "Error in CCMCorr(): embedding dimension is %i which is less than 3\n", iEmbeddingDimension);
        return(-1);
    }
   
    //Check Max
    //TODO: Figure out maximum for Embedding dimension (it depends on
    //      LagTime and the library length of X)
    //if( EmbeddingDimension  MAX_TBD){
    //    fprintf(stderr, "Error in CCMCorr(): embedding dimension is %i which is more than %i\n", EmbeddingDimension,MAX_TBD);
    //    return(-1);
    //}
   
    //Find calculated shadow manifold dimension
    int iCalShadManDim = iX_UsedForShadow_length-((iEmbeddingDimension-1)*iLagTime);
    
    //Populate shadow manifold be creating the delay vectors sequentially
    double dXShadow[iCalShadManDim][iEmbeddingDimension];
    int iTstep4delayvector;
    
    for(int iShadowStep = 1; iShadowStep <= iCalShadManDim; iShadowStep++ ){
        iTstep4delayvector = iShadowStep+((iEmbeddingDimension-1)*iLagTime);
        for(int iDimStep = 1; iDimStep <= iEmbeddingDimension; iDimStep++ ){
            dXShadow[iShadowStep-1][iDimStep-1] = dX_UsedForShadow[(iTstep4delayvector-((iDimStep-1)*iLagTime))-1];
        }
    }

    //Storage for sorting, calculating, and organizing
    double dDelayVectorOfInterest[iEmbeddingDimension],  //delay vector currently being compared
           dDelayVector2Compare[iEmbeddingDimension],  //iterated delay vector for comparison
           dXShadowNorm,  //eucleadian distance between delay vectors being compared
           dUnsortedNorms[iCalShadManDim],  //unsorted eucleadian distances between delay vectors
            dSortedNorms[iCalShadManDim],  //sorted eucleadian distances between delay vectors
           dYEstimateGivenX[iCalShadManDim],  //estimated Y used the shadow manifold of X
           dWeights[(iEmbeddingDimension+1)],  //weights to contruct Y estimate
           dWeightDenominator,  //denominator in weights calculation (used for zero check)
           dWeightNormalization;  //normalization factor for weights
    int iTstepOfNearestNeighborsTempRow[iEmbeddingDimension+1],  //time steps of nearest neighbor delay vectors
        iTempValue;  //temporary value for time step of nearest neightbor delay vector
   
    //Find starting point in Y for the estimate
    int iYStart = (iEmbeddingDimension-1)*iLagTime;

    //Loop through all of the delay vectors to find it distance to every other one
    for(int iDelayVectorN = 1; iDelayVectorN <= iCalShadManDim;iDelayVectorN++ ){
        
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
            dXShadowNorm = eDist(dDelayVectorOfInterest,dDelayVector2Compare,iEmbeddingDimension);
            
	    //Save the norms to be sorted later
            dUnsortedNorms[iTstep-1] = dXShadowNorm;
            dSortedNorms[iTstep-1] = dXShadowNorm;
        }
        
        //Sort the norms
        std::sort(dSortedNorms,dSortedNorms+iCalShadManDim);

        //Save the time step locations of the E+1 closest neighbors
        iTempValue = 0;
        for(int iEDimStep = 0; iEDimStep < (iEmbeddingDimension+1); iEDimStep++ ){
            iTstepOfNearestNeighborsTempRow[iEDimStep] = -1;
        }
        for(int iEDimStep = 0; iEDimStep < (iEmbeddingDimension+1); iEDimStep++ ){
            iTempValue = FindAndCheckIndex(dUnsortedNorms,iCalShadManDim,dSortedNorms[iEDimStep+1],iTstepOfNearestNeighborsTempRow,(iEmbeddingDimension+1));
            iTstepOfNearestNeighborsTempRow[iEDimStep] = iTempValue;
        }
       
        //Find denominator for weight calculation
        if( dSortedNorms[1] == 0 ){
            dWeightDenominator = 0.00000000000000000001;
            fprintf(stderr, "Warning in CCMcorr(): division by zero; approximation made\n");
        }else{
            dWeightDenominator = dSortedNorms[1];
        }
               
        //Find weights
        dWeightNormalization = 0;
        for( int iWeightStep = 0;iWeightStep < (iEmbeddingDimension+1);iWeightStep++ ){
            dWeights[iWeightStep] = exp((-1*dSortedNorms[iWeightStep+1])/dWeightDenominator);
            dWeightNormalization += dWeights[iWeightStep];
        }
       
        //Check normalization factor just to be safe
        if( dWeightNormalization == 0 ){
            dWeightNormalization = 0.00000000000000000001;
            fprintf(stderr, "Warning in CCMcorr(): division by zero; approximation made\n");
        }
       
        //Find normalizaed weights
        for( int iWeightStep = 0;iWeightStep < (iEmbeddingDimension+1);iWeightStep++ ){
            dWeights[iWeightStep] = dWeights[iWeightStep]/dWeightNormalization;
        }
       
        //Find Y point estimates from X shadow manifold
        dYEstimateGivenX[iDelayVectorN-1] = 0;
        for( int iWeightStep = 0;iWeightStep < (iEmbeddingDimension+1);iWeightStep++ ){
            dYEstimateGivenX[iDelayVectorN-1] += dWeights[iWeightStep]*dY[(iYStart+iTstepOfNearestNeighborsTempRow[iWeightStep])];
        }
    }

    //Clip Y to calculate correlation
    double dYclipped[iCalShadManDim];
    for(int iYstep = 0 ;iYstep < iY_length;iYstep++ ){
        dYclipped[iYstep] = dY[iYStart+iYstep];
    }
   
    //Find correlation of Y and its estimate
    double dPcorrYYX = Pcorr(dYclipped,dYEstimateGivenX,iCalShadManDim);
   
    //Return the squared correlation value
    return(dPcorrYYX*dPcorrYYX);
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
        dRunningSum += (dX[iter]-dY[iter])*(dX[iter]-dY[iter]);
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
   
    bool bUniqueIndex = true,
         bFoundMatch = false;
   
    for(int iter = 0;iter < iValues2BCompared_length;iter++ ){
        if( dValues2BCompared[iter] == dValue2Compare ){
            bFoundMatch = true;
        }
        if( bFoundMatch ){
            bUniqueIndex = true;
            for(int iIndexCheckStep = 0;iIndexCheckStep <
iIndices2Check_length;iIndexCheckStep++ ){
                bUniqueIndex &= (iter != iIndices2Check[iIndexCheckStep]);
            }
            if( bUniqueIndex ){
                return(iter);
            }
        }
        bFoundMatch = false;
    }
   
    fprintf(stderr, "Error in FindAndCheckIndex(): no match was found, so an index of -1 will be returned");
    return(-1);  
}

/*Pcorr -- Pearson's Correlation Coefficent
  This function returns Pearson's correlation coefficent
  between X and Y.  It is assumed (i.e. not checked) that
  X and Y are the same length.
 
  References: http://mathworld.wolfram.com/CorrelationCoefficient.html
             
  Dependencies:   math.h (header)
 
  Input Parameters:
      double dX[] - vector of values
      double dY[] - vector of values
      int iXY_length - length of X and Y
                   
  Output Parameters:
      double - Pearson's correlation coefficent between X and Y
*/
double Pcorr(double dX[],double dY[],int iXY_length){
   
    double dEX = 0,  //expectation value of X
           dEY = 0,  //expectation value of Y
           dEXdelta,  //distance from mean for point in X
           dEYdelta,  //distance from mean for point in Y
           dSX = 0,  //variance of X
           dSY = 0,  //variance of Y
           dSXY = 0,  //covariance of X and Y
           dCovNorm;  //normalization factor for the covariance
         
    for(int iter = 0;iter < iXY_length;iter++ ){
        dEX += dX[iter];
        dEY += dY[iter];
    }
   
    dEX /= iXY_length;
    dEY /= iXY_length;
   
    for(int iter = 0;iter < iXY_length;iter++ ){
        dEXdelta = dX[iter]-dEX;
        dEYdelta = dY[iter]-dEY;
        dSX += dEXdelta*dEXdelta;
        dSY += dEYdelta*dEYdelta;
        dSXY += dEXdelta*dEYdelta;
    }
   
    dCovNorm = sqrt(dSX*dSY);
    if( dCovNorm == 0 ){
        dCovNorm = 0.00000000000000000001;
        fprintf(stderr, "Warning in Pcorr(): division by zero; approximation made\n");
    }
   
    return(dSXY/dCovNorm);
}


