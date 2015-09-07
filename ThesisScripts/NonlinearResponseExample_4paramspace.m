
% Set B and C for the plots
Avec = [0.05:0.05:1.0];
Bvec = [0.05:0.05:1.0];
Cvec = [0.05:0.05:1.0];
Dvec = [0.05:0.05:1.0];

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

% preallocate some storage
g_stored = nan(length(Avec),length(Bvec),length(Cvec),length(Dvec),5);
% TE_stored = struct();
% GC_stored = struct();
% PAI_stored = struct();
% L_stored = struct();
% LCC_stored = struct();

for Aiter = 1:1:length(Avec),
    for Biter = 1:1:length(Bvec),
        for Citer = 1:1:length(Cvec),
            for Diter = 1:1:length(Dvec),
                
                % set coefficients
                A = Avec(Aiter);
                B = Bvec(Biter);
                C = Cvec(Citer);
                D = Dvec(Diter);                
                
                % notify the terminal
                fprintf('--- (A,B,C,D) = (%.4f,%.4f,%.4f,%.4f) ---- running --- ',...
                    Avec(Aiter),Bvec(Biter),Cvec(Citer),Dvec(Diter));
                tic;

                % build X and Y
                [x,y] = NonlinearResponse(liblength,unit_step,a,b,c,A,B,C,D);

                % set tolerances
                xtol = (max(x)-min(x))/4;
                ytol = (max(y)-min(y))/4;

                % call ECA script
                [TE,GC,PAI,L,LCC,g] = ECA(x,y,xtol,ytol,lags,true);

                % store everything
                TE_stored(Aiter,Biter,Citer,Diter) = TE;
                GC_stored(Aiter,Biter,Citer,Diter) = GC;
                PAI_stored(Aiter,Biter,Citer,Diter) = PAI;
                L_stored(Aiter,Biter,Citer,Diter) = L;
                LCC_stored(Aiter,Biter,Citer,Diter) = LCC;
                for siter = 1:1:5,
                    g_stored(Aiter,Biter,Citer,Diter,siter) = g(siter);
                end;

                % notify the terminal
                fprintf('done (%.4f s) --- ',toc);

            end;
        end;
    end;
end;