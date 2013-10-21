% fake data
Bxy_vec = [0:0.005:0.4];
Byx_vec = [0:0.005:0.4];
plotdata = zeros(length(Bxy_vec),length(Byx_vec));
for xystep = 1:length(Bxy_vec),
    for yxstep = 1:length(Byx_vec),
        X = zeros(400,1);
        Y = X;
        X(1) = 0.4;
        Y(1) = 0.2;
        rx = 3.8;
        ry = 3.5;
        Bxy = Bxy_vec(xystep);
        Byx = Byx_vec(yxstep);
        for fstep = 1:(length(X)-1),
            X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
            Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
        end  

        plotdata(yxstep,xystep) = CCM(X,Y,2)-CCM(Y,X,2);
    end;
end;
    