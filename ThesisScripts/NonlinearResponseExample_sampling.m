
% Set B and C for the plots
A = 0.1;
B = 0.3;
C = 0.4;
D = 0.5;

% set signal length
liblength = 6*pi;

% set ampltide
a = 1;

% set frequency
b = 1;

% set phase 
c = 1;

% set stepsize
unit_step = (1/30)*pi;

% set the number of lags for the leaning and LCC
lags = 1:1:15;

% set number of samples
numsamp = 1E4;

% preallocate some storage
g_stored = nan(numsamp,5);
% TE_stored = struct();
% GC_stored = struct();
% PAI_stored = struct();
% L_stored = struct();
% LCC_stored = struct();

for iter = 1:1:numsamp,
        
    % notify the terminal
    fprintf('--- %i [%.4f] ---- running --- ',iter,iter/numsamp);
    tic;

    % build X and Y
    [x,y] = NonlinearResponse(liblength,unit_step,a,b,c,A,B,C,D);

    % set tolerances
    xtol = (max(x)-min(x))/4;
    ytol = (max(y)-min(y))/4;

    % call ECA script
    [TE,GC,PAI,L,LCC,g] = ECA(x,y,xtol,ytol,lags,true);

    % store everything
    TE_stored(iter) = TE;
    GC_stored(iter) = GC;
    PAI_stored(iter) = PAI;
    L_stored(iter) = L;
    LCC_stored(iter) = LCC;
    for siter = 1:1:5,
        g_stored(iter,siter) = g(siter);
    end;
    
    % notify the terminal
    fprintf('done (%.4f s) --- ',toc);
    
end;