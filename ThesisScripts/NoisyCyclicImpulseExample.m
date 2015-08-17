
% Loop over various impulse and response noise levels
D_vec = [0.05:0.05:1.0];
E_vec = [0.05:0.05:1.0];

% set constansts for impulse signal
liblength = 50*pi;
stepsize = pi/32;
a = 1;
b = 1;
c = 1;

% set the number of lags for the leaning and LCC
lags = 1:1:5;

% preallocate some storage
XcY_stored = nan(length(D_vec),length(E_vec),5);
YcX_stored = nan(length(D_vec),length(E_vec),5);
% TE_stored = struct();
% GC_stored = struct();
% PAI_stored = struct();
% L_stored = struct();
% LCC_stored = struct();

for Diter = 1:1:length(D_vec),
    for Eiter = 1:1:length(E_vec),
        
    % set noise level
    d = D_vec(Diter);
    e = E_vec(Eiter);

    % notify the terminal
    fprintf('\n\n--- (D,E) = (%.3f,%.3f) [%.4f D,%.4f E] ---------\n',...
        d,e,Diter/length(D_vec),Eiter/length(E_vec));

    % build signals
    [x,y] = NoisyCyclicImpulseResponse(liblength,stepsize,a,b,c,d,e);

    % set tolerances
    xtol = std(x-mean(x))/sqrt(length(x));
    ytol = std(y-mean(y))/sqrt(length(y));
    
    % call ECA script
    [TE,GC,PAI,L,LCC,XcY,YcX] = ECA(x,y,xtol,ytol,lags,true);
    
    % store everything
    TE_stored(Diter,Eiter) = TE;
    GC_stored(Diter,Eiter) = GC;
    PAI_stored(Diter,Eiter) = PAI;
    L_stored(Diter,Eiter) = L;
    LCC_stored(Diter,Eiter) = LCC;
    for siter = 1:1:5,
        XcY_stored(Diter,Eiter,siter) = XcY(siter);
        YcX_stored(Diter,Eiter,siter) = YcX(siter);
    end;
    
    end;
end;