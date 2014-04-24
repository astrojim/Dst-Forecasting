addpath('..');
addpath('../../utils');

number_of_samples = 2000;
library_length = [1100:10:1400];
E = 3;
tau = 1;
mean_rx = 3.8;
mean_ry = 3.5;
mean_Xo = 0.4;
mean_Yo = 0.2;
var_rx = 0.05;
var_ry = 0.05;
var_Xo = 0.1;
var_Yo = 0.1;
Bxy = 0.20;
Byx = 0.10;

PointTotal = length(library_length);
fprintf('There are %i points total.\n',PointTotal);
PointCount = 1;

%Cdata = zeros(number_of_samples,2);
for Lstep = 1:1:length(library_length),
        
    fprintf('== Point %i (%f); L %i\n',...
        PointCount,PointCount/PointTotal,library_length(Lstep));
    PointCount = PointCount+1;
    fprintf('Creating C input data file...');
    tic;
    Coutputfilename = sprintf('Lseries_Bxy%.2f_Byx%.2f_L%i.dat',Bxy,Byx,library_length(Lstep));
    Cinputfilename = sprintf('BGridPlot_Bxy%.2f_Byx%.2f.dat',Bxy,Byx);
    fileID = fopen(Cinputfilename,'w');
    TScount = 0;

    for sampstep = 1:1:number_of_samples,        
        X = zeros(library_length(Lstep),1);
        Y = X;
        X(1) = abs(normrnd(mean_Xo,var_Xo,1,1));
        Y(1) = abs(normrnd(mean_Yo,var_Yo,1,1));
        rx = abs(normrnd(mean_rx,var_rx,1,1));
        ry = abs(normrnd(mean_ry,var_ry,1,1));

        for fstep = 1:(length(X)-1),
            X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
            Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
        end;

        for wstep = 1:length(X),
            fprintf(fileID,'%.20f,%.20f;\n',X(wstep),Y(wstep));
        end;
        TScount = TScount + 1;
    end;
    fclose(fileID);
    fprintf('done. [%f]\n',toc);

    fprintf('Calling C code...');
    tic;
    CCommandString = sprintf('./CCMpair -E %i -t %i -L %i -f %s -n %i -o %s -p 2',...
                              E,tau,library_length(Lstep),Cinputfilename,TScount,Coutputfilename);
    [status,cmdout] = system(CCommandString);
    %fprintf('%s\n',cmdout);
    RMCommandString = sprintf('rm %s',Cinputfilename);
    system(RMCommandString);
    fprintf('done. [%f]\n',toc);
        
end;
