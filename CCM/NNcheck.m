function [OutputVector1,OutputVector2,OutputVector3] = NNcheck(X,ParamDim,tau)

% Create shadow manifold for X
ShadowStopX = length(X)-(ParamDim-1)*tau;
Xshadow_temp = zeros(ShadowStopX,ParamDim);
for ShadowStep = 1:1:ShadowStopX,
    tstart = ShadowStep+(ParamDim-1)*tau;            
    for ParamIndex = 1:1:ParamDim,
        Xshadow_temp(ShadowStep,ParamIndex) = X(tstart-(ParamIndex-1)*tau);
    end;
end;
Xshadow = Xshadow_temp;

% Find nearest neighbors in X shadow
NormMatrix_Xshadow = zeros(length(Xshadow),length(Xshadow));
for t_of_interest = 1:length(Xshadow),        
    for tstep = 1:length(Xshadow),            
       NormMatrix_Xshadow(t_of_interest,tstep) = norm(Xshadow(t_of_interest,:)-Xshadow(tstep,:));    
    end;
end;
[SortedNormMatrix_Xshadow,SortedNormMatrix_Xshadow_index] = sort(NormMatrix_Xshadow,2);

% Find weights given X (E+1) neighbors
UnnormWeightsFromXshadow = zeros(length(Xshadow),ParamDim+1);
WeightsFromXshadow = zeros(length(Xshadow),ParamDim+1);
for tstep = 1:length(Xshadow),    
    DenomForNormX = SortedNormMatrix_Xshadow(tstep,2);
    if( DenomForNormX == 0 ),
    	DenomForNormX = 1E-20;
    end;
    for pstep = 1:(ParamDim+1),        
        NumForNormX = SortedNormMatrix_Xshadow(tstep,pstep+1);
        UnnormWeightsFromXshadow(tstep,pstep) = exp((-1*NumForNormX)/DenomForNormX);
    end;
end;
WeightsFromXSumForDenom = sum(UnnormWeightsFromXshadow,2);
for pstep = 1:(ParamDim+1),
	if( WeightsFromXSumForDenom == 0 ),
    	WeightsFromXshadow(:,pstep) = UnnormWeightsFromXshadow(:,pstep);
    else
    	WeightsFromXshadow(:,pstep) = UnnormWeightsFromXshadow(:,pstep)./WeightsFromXSumForDenom;
    end;
end;

OutputVector1 = SortedNormMatrix_Xshadow;
OutputVector2 = SortedNormMatrix_Xshadow_index;
OutputVector3 = WeightsFromXshadow;