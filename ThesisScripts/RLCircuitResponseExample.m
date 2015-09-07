
% set globals (used by ODE solver)
global tspan;
global Vv;
global RR;
global L;

% set signal parameters
endtime = 8*pi;
fsteps = [1/80,1/60,1/40,1/20,1/10,1/5];
% stepsize = (1/10)*pi;

% preallocate some storage
g_stored = nan(length(fsteps),5);
% TE_stored = struct();
% GC_stored = struct();
% PAI_stored = struct();
% L_stored = struct();
% LCC_stored = struct();

for fiter = 1:1:length(fsteps),
    
    % Set R and L for the plots
    R = 5;
    L = 10;

    % notify the terminal
    fprintf('\n\n--- (f) = (%.3f) [%.4f f] ---------\n',...
        fsteps(fiter),fiter/length(fsteps));

    % build signals
    [x,y_an,y_num] = RLCircuitResponse(endtime,fsteps(fiter)*pi,R,L);

    % find autocorr length to set lags
    alags = 1:1:floor(length(x)/2);
    autocorrX = nan(length(alags),1);
    for liter = 1:1:length(alags),
        autocorrX(liter,1) = abs(corr(x((alags(liter)+1):end)',x(1:(end-alags(liter)))'))^2;
    end;
    Llags = 1:1:(find(autocorrX == min(autocorrX)));    
    
    % set tolerances
    xtol = (max(x)-min(x))/4;
    ytol = (max(y_an)-min(y_an))/4;

    % call ECA script
    [TE,GC,PAI,L,LCC,g] = ECA(x,y_an,xtol,ytol,Llags,true);

    % store everything
    TE_stored(fiter) = TE;
    GC_stored(fiter) = GC;
    PAI_stored(fiter) = PAI;
    L_stored(fiter) = L;
    LCC_stored(fiter) = LCC;
    for siter = 1:1:5,
        g_stored(fiter,siter) = g(siter);
    end;

end;