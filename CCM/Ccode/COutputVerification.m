addpath('..');
addpath('../../utils');

library_length = 2000;
X = zeros(library_length,1);
Y = X;
X(1) = 0.4;
Y(1) = 0.2;
rx = 3.8;
ry = 3.5;
Bxy = 0.02;
Byx = 0.1;

for fstep = 1:(length(X)-1),
    X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
end;

fileID = fopen('COutputVerification.dat','w');
for wstep = 1:length(X),
    fprintf(fileID,'%f,%f;\n',X(wstep),Y(wstep));
end;
fclose(fileID);

tic;
CCM_XY = CCM(Y,X,3,1);
CCM_YX = CCM(X,Y,3,1);
MatlabOutTime = toc;

tic;
CCommandString = sprintf('./ccm -E 3 -t 1 -L %i -f COutputVerification.dat',library_length);
[status,cmdout] = system(CCommandString);
COutTime = toc;

fprintf('Matlab took %d seconds to get %d,%d\n',MatlabOutTime,CCM_XY,CCM_YX);
fprintf('Matlab took %d seconds to get %s\n',COutTime,cmdout);
