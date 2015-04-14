
xtol = 0;%[0:0.01:0.2];
ytol = 0;%[0:0.01:0.2];

numsamp = 1;
library_length = 500;
mean_rx = 3.8;%3.5
mean_ry = 3.2;
mean_Xo = 0.4;%0.4
mean_Yo = 0.4;
var_rx = 0.05;
var_ry = 0.05;
var_Xo = 0.1;
var_Yo = 0.1;

Bxy_vec = [1e-8:0.05:0.5];
Byx_vec = [1e-8:0.05:0.5];

leans_stored = nan(length(Bxy_vec),length(Byx_vec),length(xtol),length(ytol),numsamp);

for iter = 1:1:numsamp,
    for outer1 = 1:1:length(xtol),
        for outer2 = 1:1:length(ytol),
            for Bxystep = 1:1:length(Bxy_vec),
                for Byxstep = 1:1:length(Byx_vec),    

                    tic;
                    X = zeros(library_length,1);
                    Y = X;
                    X(1) = mean_Xo; %abs(normrnd(mean_Xo,var_Xo,1,1));
                    Y(1) = mean_Yo; %abs(normrnd(mean_Yo,var_Yo,1,1));
                    rx = mean_rx; %abs(normrnd(mean_rx,var_rx,1,1));
                    ry = mean_ry; %abs(normrnd(mean_ry,var_ry,1,1));
                    Bxy = Bxy_vec(Bxystep);
                    Byx = Byx_vec(Byxstep);

                    for fstep = 1:(length(X)-1),
                        X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
                        Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
                    end;

                    fprintf('Bxy = %.4f; Byx = %.4f; xtol = %.2f; ytol = %.2f; ... ',Bxy,Byx,xtol(outer1),ytol(outer2));

%                     leans_temp =
%                     leans_lagged(X,Y,xtol(outer1),ytol(outer2),1);
                    leans_temp = leans_lagged(X,Y,std(X-mean(X)),std(Y-mean(Y)),1);
                    leans_stored(Bxystep,Byxstep,outer1,outer2,iter) = leans_temp(1,2);

                    fprintf(' done. [%.3f]\n',toc);
                end;
            end;
        end;
    end;
end;