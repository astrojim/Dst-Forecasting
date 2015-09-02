
% Loop over various impulse and response noise levels
B_vec = [0.05:0.05:1.0];
A_vec = [0.05:0.05:1.0];

% set signal length
liblength = 250;

% set ampltide
a = 1;

% set frequency
b = 1;

% set phase 
c = 1;

% set stepsize
unit_step = 1;

% set the number of lags for the leaning and LCC
lags = 1:1:20;

% preallocate some storage
g_stored = nan(length(B_vec),length(A_vec),5);
% TE_stored = struct();
% GC_stored = struct();
% PAI_stored = struct();
% L_stored = struct();
% LCC_stored = struct();

for Biter = 1:1:length(B_vec),
    for Citer = 1:1:length(A_vec),
        
        % set noise level
        B = B_vec(Biter);
        A = A_vec(Citer);

        % notify the terminal
        fprintf('\n\n--- (B,C) = (%.3f,%.3f) [%.4f B,%.4f C] ---------\n',...
            B,A,Biter/length(B_vec),Citer/length(A_vec));

        % build signals
        [x,y] = NoisyCyclicImpulseResponse(liblength,unit_step,a,b,c,A,B);

        % set tolerances
        xtol = (max(x)-min(x))/4;
        ytol = (max(y)-min(y))/4;

        % call ECA script
        [TE,GC,PAI,L,LCC,g] = ECA(x,y,xtol,ytol,lags,true);

        % store everything
        TE_stored(Biter,Citer) = TE;
        GC_stored(Biter,Citer) = GC;
        PAI_stored(Biter,Citer) = PAI;
        L_stored(Biter,Citer) = L;
        LCC_stored(Biter,Citer) = LCC;
        for siter = 1:1:5,
            g_stored(Biter,Citer,siter) = g(siter);
        end;
    
    end;
end;