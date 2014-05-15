addpath('..');
addpath('../../utils');

Tfinals = [10:10:4180];

CdataXY = zeros(length(Tfinals),1);
CdataYX = zeros(length(Tfinals),1);

%A = 2.6; %index 27
A = 3.0; %index 31
B = 2.6; %index 27

for Tfstep = 1:1:length(Tfinals);

    tspan = 0:0.5:Tfinals(Tfstep);
    library_length = length(tspan);

    fprintf('--> L = %i <--\n',Tfinals(Tfstep));
    CoutputfilenameXY = sprintf('XYout_A%.2fB%.2f_L%i.dat',A,B,Tfinals(Tfstep));

    fprintf('Reading %s...',CoutputfilenameXY);
    tic;
    if exist(CoutputfilenameXY, 'file')
        fileID = fopen(CoutputfilenameXY,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataXY(Tfstep,1) = Outdat(1);
        CdataYX(Tfstep,1) = Outdat(2);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
      CdataXY(Tfstep,1) = nan;
      CdataYX(Tfstep,1) = nan;
    end;
    fprintf('done. [%f]\n',toc);

end;   

save 'LinearEx_ChangeL_DataRead.mat';