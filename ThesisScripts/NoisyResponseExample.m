
%% build the signals

% set noise level
B = 0.5;
C = 0.1;

% set signal length
liblength = 1000;

% set spacing for impulses
hitspace = 5;

% set impulse peak
hitpeak = 2;

% build impulse signal
[x,y] = NoisyImpulseResponse(liblength,hitspace,hitpeak,C,B);

%% transfer entropy (using JIDT)

% add script path
addpath('./te_matlab_0.5');

% JIDT like column vectors, not row vectors
x_JIDT = x';
y_JIDT = y';

% locate the JAR
javaaddpath('./infodynamics-dist-1.2.1/infodynamics.jar');

% create the JIDT java object used for the TE calculations 
teCalc=javaObject('infodynamics.measures.continuous.kernel.TransferEntropyCalculatorKernel');

% set the normalizaion From JIDT scripts: "Normalise the individual
% variables. Schreiber doesn't explicitly say this is done for TE, but it 
% is done for the raw data plots in Figure 3 [of his original paper]."
teCalc.setProperty('NORMALISE', 'true'); 

% TE is calculated here with lag of 1 and a kernel width of 0.5 [normalized units]
teCalc.initialise(1, 0.5); 

% pass the signals to the JIDT object in X-Y order
teCalc.setObservations(x_JIDT,y_JIDT);

% calculate TE_{x->y}
TE_xy = teCalc.computeAverageLocalOfObservations();

% re-initialized JIDT object with the same parameters used before
teCalc.initialise();

% pass the signals to the JIDT object in Y-X order
teCalc.setObservations(y_JIDT,x_JIDT);

% calculate TE_{y->x}
TE_yx = teCalc.computeAverageLocalOfObservations();

% report TE
D_TE = TE_xy-TE_yx;
fprintf('[TE_xy,TE_yx,D_TE,X->Y?,Y->X?] = [%.5f,%.5f,%.5f,%i,%i]\n',...
    TE_xy,TE_yx,D_TE,(D_TE > 0),(D_TE < 0));

%% granger causality (using MVGC)

% run the start-up script
addpath('mvgc_v1.0');
startup;

% set some toolbox parameters
regmode   = '';  % VAR model estimation regression mode ('OLS', 'LWR' or empty for default)
icregmode = '';  % information criteria regression mode ('OLS', 'LWR' or empty for default)
morder    = 20;  % model order to use ('actual', 'AIC', 'BIC' or supplied numerical value)
momax     = 20;     % maximum model order for model order estimation
acmaxlags = [];   % maximum autocovariance lags (empty for automatic calculation)
fres      = [];     % frequency resolution (empty for automatic calculation)

% pack data 
XY_ts = [x;y];

% Calculate information criteria up to specified maximum model order.
[AIC,BIC,moAIC,moBIC] = tsdata_to_infocrit(XY_ts,momax,icregmode,false);

% Estimate VAR model of selected order from data.
[A,SIG] = tsdata_to_var(XY_ts,moBIC,regmode);

% Calculate the autocovariance sequence 
[G,info] = var_to_autocov(A,SIG,acmaxlags);

% Calculate time-domain pairwise-conditional causalities 
F = autocov_to_pwcgc(G);

% Calculate spectral pairwise-conditional causalities 
f = autocov_to_spwcgc(G,fres);

% Check that spectral causalities average (integrate) to time-domain
Fint = smvgc_to_mvgc(f); % integrate spectral MVGCs
mad = maxabs(F-Fint);
madthreshold = 1e-5;
if mad < madthreshold
    %fprintf('maximum absolute difference OK: = %.2e (< %.2e)\n',mad,madthreshold);
else
    fprintf(2,'WARNING: high maximum absolute difference = %e.2 (> %.2e)\n',mad,madthreshold);
end

%% PAI

% set the embedding dimension
E = 3;

% set the delay vector lag time step
tau = 1;

% create the input file for the C code        
fprintf('Creating C input data files...');
tic;
CoutputfilenameXY = sprintf('XYoutPAI.dat');
CinputfilenameXY = sprintf('XYPAI_temp.dat');
fileID = fopen(CinputfilenameXY,'w');
for tstep = 1:1:length(x),
    fprintf(fileID,'%.20f,%.20f;\n',x(tstep),y(tstep));
end;
fclose(fileID);
fprintf('done. [%f]\n',toc);

% call the C code
fprintf('Calling C code...');
tic;
CCommandString = sprintf('./PAI -E %i -t %i -Ey 1 -ty 1 -L %i -f %s -n %i -o %s -eY tempeYout.dat -PAI',...
                              E,tau,library_length,CinputfilenameXY,tau,...
                              CoutputfilenameXY);
[status,cmdout] = system(CCommandString);
%fprintf('%s\n',cmdout);
RMCommandString = sprintf('rm %s',CinputfilenameXY);
system(RMCommandString);
fprintf('done. [%f]\n',toc);

%% leaning
%{
% set the lags to tested
lags = 1:1:(floor(0.1*length(x)));

% set the x tolerance
xtol = 0.1;

% set the y tolerance
ytol = 0.1;

% find the leanings
leanings = nan(1,length(x));
for lag_iter = 1:1:length(lags),
    leanings(1,lag_iter) = leans_lagged(x,y,xtol,ytol,lags(lag_iter));
end;
%}

%% lagged cross-correlations
%{
% set the lags (use the same as for the leaning calculation)
clags = lags;

% find the lagged cross-correlations
laggedcorrs = nan(1,length(clags))
for clag_iter = 1:1:length(clags),
    laggedcorr(1,clag_iter) = corr(x((l+1):end)',y(1:(end-l))');
end;
%}
