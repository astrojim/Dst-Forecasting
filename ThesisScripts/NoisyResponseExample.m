
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
hititer = 0;
x = randn(1,liblength).*C;
x(2) = hitpeak;
for xiter = 2:1:liblength,
    if( hititer > hitspace ),
        x(xiter) = hitpeak;
        hititer = 0;
    end;
    hititer = hititer + 1;
end;

% build noisy response
y = zeros(1,length(x));
for iter = 2:1:length(y),
    y(iter) = x(iter-1) + B*randn();
end;

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
