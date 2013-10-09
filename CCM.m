function [OutputVector] = CCM(X,Y,ParamDim)

% Set time step ("tau")
% [These are just Matlab indicies; conversion to appropriate 
% time values need to be done before reporting.]
tau = 1;

% Set the parameter space dimension (must be >= 2)
%ParamDim = 25;

% Create shadow manifold for X
ShadowStopX = length(X)-(ParamDim-1)*tau;
Xshadow = zeros(ShadowStopX,ParamDim);
for ShadowStep = 1:1:ShadowStopX;
	tstart = ShadowStep+(ParamDim-1)*tau;    
	for ParamIndex = 1:1:ParamDim,
    	Xshadow(ShadowStep,ParamIndex) = X(tstart-(ParamIndex-1)*tau);
    end
end

% Create shadow manifold for Y
ShadowStopY = length(Y)-(ParamDim-1)*tau;
Yshadow = zeros(ShadowStopY,ParamDim);
for ShadowStep = 1:1:ShadowStopY;
	tstart = ShadowStep+(ParamDim-1)*tau;    
	for ParamIndex = 1:1:ParamDim,
    	Yshadow(ShadowStep,ParamIndex) = Y(tstart-(ParamIndex-1)*tau);
    end
end

% Find the unnormalized weights for X
Xuweights = zeros(length(Xshadow),length(ParamDim));
for tstep = 1:length(Xshadow),
	for pstep = 1:ParamDim,
    	Xuweights(tstep,pstep) = exp(-sqrt((Xshadow(tstep,1)-Xshadow(tstep,pstep))^2)/sqrt((Xshadow(tstep,1)-Xshadow(tstep,2))^2));
    end
end

% Find the unnormalized weights for Y
Yuweights = zeros(length(Yshadow),length(ParamDim));
for tstep = 1:length(Yshadow),
	for pstep = 1:ParamDim,
    	Yuweights(tstep,pstep) = exp(-sqrt((Yshadow(tstep,1)-Yshadow(tstep,pstep))^2)/sqrt((Yshadow(tstep,1)-Yshadow(tstep,2))^2));
    end
end

% Find normalized weights for X
XuweightsSum = sum(Xuweights,2);
Xweights = zeros(size(Xuweights));
for pstep = 1:ParamDim,
	Xweights(:,pstep) = Xuweights(:,pstep)./XuweightsSum;
end

% Find normalized weights for Y
YuweightsSum = sum(Yuweights,2);
Yweights = zeros(size(Yuweights));
for pstep = 1:ParamDim,
	Yweights(:,pstep) = Yuweights(:,pstep)./YuweightsSum;
end

% Find Y given X shadow weights
XshadowWeightedByYshadow = Xshadow.*Yweights;
XEstimatedByYshadow = sum(XshadowWeightedByYshadow,2);

% Find X given Y shadow weights
YshadowWeightedByXshadow = Yshadow.*Xweights;
YEstimatedByXshadow = sum(YshadowWeightedByXshadow,2);

% Find and return correlation
XCorrMat = nancorr(X(ParamDim:end),XEstimatedByYshadow);
YCorrMat = nancorr(Y(ParamDim:end),YEstimatedByXshadow);
OutputVector = [XCorrMat,YCorrMat];