% A = [0:0.05:1.0];
% B = [0:0.05:1.0];
% C = [0:0.2:1.0];
% xytol = [0:0.05:1];
% lag = 1;

A = [0:0.05:1.0];
B = [0:0.05:1.0];
C = 0;%[0:0.2:1.0];
xytol = 0;%[0:0.05:1];
lag = [1:1:50];

leans_stored = nan(length(A),length(B),length(C),length(xytol));
leans_keep = nan(length(A),length(B),length(lag));

tstep = 0:(pi/30):(6*pi);
x = sin(tstep);

for lstep = 1:1:length(lag), 
    for outer = 1:1:length(xytol),
        for Astep = 1:1:length(A),
            for Bstep = 1:1:length(B),
                for Cstep = 1:1:length(C),

                    fprintf('A = %.2f; B = %.2f; C = %.2f; xytol = %.2f; lag = %i ...',...
                        A(Astep),B(Bstep),C(Cstep),xytol(outer),lag(lstep));
                    tic;
                    y = zeros(1,length(x));
                    for iter = 2:1:length(y),
                        y(iter) = (A(Astep)*x(iter-1))*(1-(A(Astep)*x(iter-1))) + C(Cstep)*randn();
                    end;

                    leans_temp = leans_lagged(x,y,0,xytol(outer),lag(lstep));
                    leans_stored(Astep,Bstep,Cstep,outer) = leans_temp(1,2);
                    leans_keep(Astep,Bstep,lstep) = leans_temp(1,2);

            %         if( isnan(leans_stored(step,outer)) ),
            %             pause
            %         end;

                    fprintf(' done. [%.3f]\n',toc);
                
                end;
            end;
        end;
    end;
end;
