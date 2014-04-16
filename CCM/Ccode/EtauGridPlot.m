addpath('..');
addpath('../../utils');

number_of_samples = 1;
library_length = 2000;
E = [2:1:20];
tau = [1:1:50];
mean_rx = 3.8;
mean_ry = 3.5;
mean_Xo = 0.4;
mean_Yo = 0.2;
var_rx = 0.05;
var_ry = 0.05;
var_Xo = 0.1;
var_Yo = 0.1;
Bxy = 0.01;
Byx = 0.2;


PointTotal = length(E)*length(tau);
fprintf('There are %i points total.\n',PointTotal);
PointCount = 1;

%Cdata = zeros(number_of_samples,2);
for Estep = 1:1:length(E),
    for taustep = 1:1:length(tau),    
        
        fprintf('== Point %i (%f); Bxy %i,Byx %i ==\n',...
            PointCount,PointCount/PointTotal,E(Estep),tau(taustep));
        PointCount = PointCount+1;
        fprintf('Creating C input data file...');
        tic;
        Coutputfilename = sprintf('out_E%if_tau%i_L%i.dat',E(Estep),tau(taustep),library_length);
        Cinputfilename = sprintf('EtauGridPlot_E%i_tau%i.dat',E(Estep),tau(taustep));
        fileID = fopen(Cinputfilename,'w');
        TScount = 0;
        
        for sampstep = 1:1:number_of_samples,        
            X = zeros(library_length,1);
            Y = X;
            X(1) = mean_Xo;
            Y(1) = mean_Yo;
            rx = mean_rx;
            ry = mean_ry;

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
        CCommandString = sprintf('./ccm -E %i -t %i -L %i -f %s -n %i -o %s',...
                                  E(Estep),tau(taustep),library_length,...
                                  Cinputfilename,TScount,Coutputfilename);
        [status,cmdout] = system(CCommandString);
        %fprintf('%s\n',cmdout);
        RMCommandString = sprintf('rm %s',Cinputfilename);
        system(RMCommandString);
        fprintf('done. [%f]\n',toc);
        
    end;
end;
