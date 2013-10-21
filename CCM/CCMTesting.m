L = [5:1:100,110:10:1000,1100:100:4000];
XY_YX = zeros(length(L),2);
for lstep = 1:length(L),
    fprintf('L = %i (%i/%i) ...',L(lstep),lstep,length(L));
    X = zeros(L(lstep),1);
    Y = X;
    X(1) = 0.4;
    Y(1) = 0.2;
    rx = 3.8;
    ry = 3.5;
    Bxy = 0.02;
    Byx = 0.1;
    for fstep = 2:length(X),
        X(fstep) = X(fstep-1)*(rx-rx*X(fstep-1)-Bxy*Y(fstep-1));
        Y(fstep) = Y(fstep-1)*(ry-ry*Y(fstep-1)-Byx*X(fstep-1));
    end;  

    XY_YX(lstep,1) = CCM(X,Y,2);
    XY_YX(lstep,2) = CCM(Y,X,2);
    fprintf('done.\n');
end;

%plot(1:length(L),XY_YX(:,1),1:length(L),XY_YX(:,2))

