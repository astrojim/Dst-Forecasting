addpath('..');
addpath('../../utils');

TfinalsCCM = [10:50:7750];
TfinalsPAI = [10:10:7750];

CdataXY_CCM = zeros(length(TfinalsCCM),1);
CdataYX_CCM = zeros(length(TfinalsCCM),1);
CdataXY_PAI = zeros(length(TfinalsPAI),1);
CdataYX_PAI = zeros(length(TfinalsPAI),1);

for Tfstep = 1:1:length(TfinalsCCM);

    fprintf('--> [CCM] L = %i <--\n',TfinalsCCM(Tfstep));
    CoutputfilenameXY = sprintf('snowdataCCMout_L%i.dat',TfinalsCCM(Tfstep));

    fprintf('Reading %s...',CoutputfilenameXY);
    tic;
    if exist(CoutputfilenameXY, 'file')
        fileID = fopen(CoutputfilenameXY,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataXY_CCM(Tfstep,1) = Outdat(1);
        CdataYX_CCM(Tfstep,1) = Outdat(2);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
      CdataXY_CCM(Tfstep,1) = nan;
      CdataYX_CCM(Tfstep,1) = nan;
    end;
    fprintf('done. [%f]\n',toc);

end;   

for Tfstep = 1:1:length(TfinalsPAI);

    fprintf('--> [PAI] L = %i <--\n',TfinalsPAI(Tfstep));
    CoutputfilenameXY = sprintf('snowdataPAIout_L%i.dat',TfinalsPAI(Tfstep));

    fprintf('Reading %s...',CoutputfilenameXY);
    tic;
    if exist(CoutputfilenameXY, 'file')
        fileID = fopen(CoutputfilenameXY,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataXY_PAI(Tfstep,1) = Outdat(1);
        CdataYX_PAI(Tfstep,1) = Outdat(2);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
      CdataXY_PAI(Tfstep,1) = nan;
      CdataYX_PAI(Tfstep,1) = nan;
    end;
    fprintf('done. [%f]\n',toc);

end;

save 'snowdata_DataRead.mat';