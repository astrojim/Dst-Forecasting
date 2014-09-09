addpath('..');
addpath('../../utils');

Tfinals = [10:10:4180];

CdataXX = zeros(length(Tfinals),1);
CdataXXY = zeros(length(Tfinals),1);
CdataYY = zeros(length(Tfinals),1);
CdataYYX = zeros(length(Tfinals),1);

%A = 3.0; %index 31
A = 5.0;
%B = 2.6; %index 27
B = 8.3;

for Tfstep = 1:1:length(Tfinals);

    tspan = 0:0.5:Tfinals(Tfstep);
    library_length = length(tspan);

    fprintf('--> L = %i <--\n',Tfinals(Tfstep));
    CoutputfilenameXY = sprintf('XYPAIout_A%.2fB%.2f_L%i.dat',A,B,Tfinals(Tfstep));

    fprintf('Reading %s...',CoutputfilenameXY);
    tic;
    if exist(CoutputfilenameXY, 'file')
        fileID = fopen(CoutputfilenameXY,'r');
        Outdat = fscanf(fileID, '%f,%f,%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataXX(Tfstep,1) = Outdat(1);
        CdataXXY(Tfstep,1) = Outdat(2);
        CdataYY(Tfstep,1) = Outdat(3);
        CdataYYX(Tfstep,1) = Outdat(4);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
    end;
    fprintf('done. [%f]\n',toc);

end;   

save 'LinearExPAI_ChangeL_DataRead_A5.mat';