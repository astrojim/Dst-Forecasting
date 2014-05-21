%Reproducing Sugihara Figure 3 C and D
tic;
fprintf('Creating test TS #1...');
Bxy = 0;
Byx = 0.32;
library_length = 1000;

Cinputfilename = sprintf('PAItesting_Bxy%.2f_Byx%.2f.dat',Bxy,Byx);
fileID = fopen(Cinputfilename,'w');

X = zeros(library_length,1);
Y = X;
X(1) = 0.2;
Y(1) = 0.4;
rx = 3.7;
ry = 3.7;

for fstep = 1:(length(X)-1),
    X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
end;

for wstep = 1:length(X),
    fprintf(fileID,'%.20f,%.20f;\n',X(wstep),Y(wstep));
end;

fclose(fileID);
fprintf('done. [%f]\n',toc);

tic;
fprintf('Creating test TS #2...');
tspan = 0:0.5:1000;
Xt(1) = sin(tspan(1));
Yt(1) = 0;
A = 3.0;
B = 2.6;
for step = 2:length(tspan),
    Xt(step) = sin(tspan(step));
    Yt(step) = A*Xt(step-1)+B*randn();
end;

CinputfilenameXY = sprintf('PAItesting_A%.2f_B%.2f.dat',A,B);
fileID = fopen(CinputfilenameXY,'w');
for tstep = 1:1:length(tspan),
    fprintf(fileID,'%.20f,%.20f;\n',Xt(tstep),Yt(tstep));
end;
fclose(fileID);
fprintf('done. [%f]\n',toc);