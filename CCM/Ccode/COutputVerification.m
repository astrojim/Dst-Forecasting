addpath('..');
addpath('../../utils');

number_of_samples = 1000;
mean_rx = 3.8;
mean_ry = 3.5;
mean_Xo = 0.4;
mean_Yo = 0.2;
var_rx = 0.05;
var_ry = 0.05;
var_Xo = 0.1;
var_Yo = 0.1;

Matlabdata = zeros(number_of_samples,2);
Matlabtimes = zeros(number_of_samples,1);
Cdata = zeros(number_of_samples,2);

tic;
fileID = fopen('COutputVerification.dat','w');
for sampstep = 1:1:number_of_samples,
    library_length = 1500;
    X = zeros(library_length,1);
    Y = X;
    X(1) = abs(normrnd(mean_Xo,var_Xo,1,1));
    Y(1) = abs(normrnd(mean_Yo,var_Yo,1,1));
    rx = abs(normrnd(mean_rx,var_rx,1,1));
    ry = abs(normrnd(mean_ry,var_ry,1,1));
    Bxy = 0.02;
    Byx = 0.1;

    for fstep = 1:(length(X)-1),
        X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
        Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
    end;
    
    for wstep = 1:length(X),
        fprintf(fileID,'%.20f,%.20f;\n',X(wstep),Y(wstep));
    end;
    
    %tic;
    Matlabdata(sampstep,1) = CCM(Y,X,3,1);
    Matlabdata(sampstep,2) = CCM(X,Y,3,1);
    %Matlabtimes(sampstep,1) = toc;
    
end;
fclose(fileID);
TotalTime = toc;  

%fprintf('================= C CODE =========================\n');
tic;
CCommandString = sprintf('./ccm -E 3 -t 1 -L %i -f COutputVerification.dat -n %i -o out.dat',library_length,number_of_samples);
[status,cmdout] = system(CCommandString);
COutTime = toc;
%fprintf('%s\n',cmdout);

fileID = fopen('out.dat','r');
Outdat = fscanf(fileID, '%f,%f');
fclose(fileID);

iter = 1;
for sampstep = 1:1:number_of_samples,
    Cdata(sampstep,1) = Outdat(iter);
    iter = iter+1;
    Cdata(sampstep,2) = Outdat(iter);
    iter = iter+1;
end;

fprintf('Matlab took %d seconds (overall) to get %d,%d [TS1]\n',TotalTime,Matlabdata(1,1),Matlabdata(1,2));
fprintf('C code took %d seconds (overall) to get %d,%d [TS1]\n',COutTime,Cdata(1,1),Cdata(1,2));
fprintf('Matlab :  %d,%d [mean]\n',mean(Matlabdata(:,1)),mean(Matlabdata(:,2)));
fprintf('C code :  %d,%d [mean]\n',mean(Cdata(:,1)),mean(Cdata(:,2)));
fprintf('Matlab :  %d,%d [std]\n',std(Matlabdata(:,1)),std(Matlabdata(:,2)));
fprintf('C code :  %d,%d [std]\n',std(Cdata(:,1)),std(Cdata(:,2)));
fprintf('Differences [TS1] : %d,%d\n',abs(Matlabdata(1,1)-Cdata(1,1)),abs(Matlabdata(1,2)-Cdata(1,2)));
fprintf('Differences [mean] : %d,%d\n',abs(mean(Matlabdata(:,1))-mean(Cdata(:,1))),abs(mean(Matlabdata(:,2))-mean(Cdata(:,2))));
fprintf('Differences [std] : %d,%d\n',abs(std(Matlabdata(:,1))-std(Cdata(:,1))),abs(std(Matlabdata(:,2))-std(Cdata(:,2))));
fprintf('Speed-up: %d\n',TotalTime/COutTime);
