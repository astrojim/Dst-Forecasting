addpath('..');
addpath('../../utils');

Tfinals = [10:10:340];

CdataXY = zeros(length(Tfinals),1);
CdataYX = zeros(length(Tfinals),1);
CdataXX = zeros(length(Tfinals),1);
CdataXXY = zeros(length(Tfinals),1);
CdataYY = zeros(length(Tfinals),1);
CdataYYX = zeros(length(Tfinals),1);

for Tfstep = 1:1:length(Tfinals);

    fprintf('--> [CCM] L = %i <--\n',Tfinals(Tfstep));
    CoutputfilenameXY = sprintf('alttempdataCCMout_L%i.dat',Tfinals(Tfstep));

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

for Tfstep = 1:1:length(Tfinals);

    fprintf('--> [PAI] L = %i <--\n',Tfinals(Tfstep));
    CoutputfilenameXY = sprintf('alttempdataPAIout_L%i.dat',Tfinals(Tfstep));

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
      CdataXX(Tfstep,1) = nan;
      CdataXXY(Tfstep,1) = nan;
      CdataYY(Tfstep,1) = nan;
      CdataYYX(Tfstep,1) = nan;
    end;
    fprintf('done. [%f]\n',toc);

end;

save 'alttempdata_DataRead.mat';