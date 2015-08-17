
% Loop over various impulse and response noise levels
B_vec = [0.05:0.05:1.0];
C_vec = [0.05:0.05:1.0];

% set signal length
liblength = 1500;

% set spacing for impulses
hitspace = 5;

% set impulse peak
hitpeak = 2;

% set the number of lags for the leaning and LCC
lags = 1:1:5;

% preallocate some storage
g_stored = nan(length(B_vec),length(C_vec),5);
% TE_stored = struct();
% GC_stored = struct();
% PAI_stored = struct();
% L_stored = struct();
% LCC_stored = struct();

for Biter = 1:1:length(B_vec),
    for Citer = 1:1:length(C_vec),
        
        % set noise level
        B = B_vec(Biter);
        C = C_vec(Citer);

        % notify the terminal
        fprintf('\n\n--- (B,C) = (%.3f,%.3f) [%.4f B,%.4f C] ---------\n',...
            B,C,Biter/length(B_vec),Citer/length(C_vec));

        % build impulse signal
        [x,y] = NoisyImpulseResponse(liblength,hitspace,hitpeak,C,B);

        % set tolerances
        xtol = std(x-mean(x))/sqrt(length(x));
        ytol = std(y-mean(y))/sqrt(length(y));

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