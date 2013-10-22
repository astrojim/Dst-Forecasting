function OutputVector = CCM(X,Y,ParamDim)

% Set time step ("tau")
% [These are just Matlab indicies; conversion to appropriate 
% time values need to be done before reporting.]
tau = 1;

% Set the parameter space dimension (must be >= 2)
if( (ParamDim < 2) || (ParamDim > length(X)/2) ),
	OutputVector = 0;
    return;
end;

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
	for pstep = 1:(ParamDim+1),
        NumForNormX = SortedNormMatrix_Xshadow(tstep,pstep+1);
    	UnnormWeightsFromXshadow(tstep,pstep) = exp((-1*NumForNormX)/DenomForNormX);
    end;
end;
WeightsFromXSumForDenom = nansum(UnnormWeightsFromXshadow,2);
for pstep = 1:(ParamDim+1),
    	WeightsFromXshadow(:,pstep) = UnnormWeightsFromXshadow(:,pstep)./WeightsFromXSumForDenom;
end;

% Find cross mapped estimate of Y
CrossMappedYGivenX = zeros(length(Xshadow),1);
Yspace = zeros(length(Xshadow),length(Xshadow));
SortedYspace = zeros(length(Xshadow),length(Xshadow));
for tstep = 1:length(Xshadow),
    Yspace(tstep,:) = Y(ParamDim:end)';
end;
for row = 1:length(Xshadow),
    SortedYspace(row,:) = Yspace(row,SortedNormMatrix_Xshadow_index(row,:)); 
end;
for tstep = 1:length(Xshadow),
	for pstep = 1:(ParamDim+1),
    	CrossMappedYGivenX(tstep) = CrossMappedYGivenX(tstep) + WeightsFromXshadow(tstep,pstep)*SortedYspace(tstep,pstep+1);
    end;
end;

YGivenXCorr = nancorr(Y(ParamDim:end),CrossMappedYGivenX);

%figure();
%scatter(Y(ParamDim:end),CrossMappedYGivenX)

OutputVector = YGivenXCorr;
