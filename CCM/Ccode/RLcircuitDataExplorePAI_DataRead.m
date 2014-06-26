addpath('..');
addpath('../../utils');

%if( bVaryV_freq ),
    
freq = [0.01:0.01:2.0];

CdataRR = zeros(length(freq),1);
CdataRRI = zeros(length(freq),1);
CdataII = zeros(length(freq),1);
CdataIIR = zeros(length(freq),1);
CdataVV = zeros(length(freq),1);
CdataVVI = zeros(length(freq),1);
CdataIIV = zeros(length(freq),1);
CdataVVR = zeros(length(freq),1);
CdataRRV = zeros(length(freq),1);

CdataRI = zeros(length(freq),2);
CdataRV = zeros(length(freq),2);
CdataVI = zeros(length(freq),2);

for vstep = 1:length(freq),

    fprintf('--> freq = %.2f [%.2f complete] <--\n',...
        freq(vstep),vstep/length(freq));
    CoutputfilenameRI = sprintf('RIoutE2_tempPAI_freq%.3f.dat',freq(vstep));
    CoutputfilenameRV = sprintf('RVoutE2_tempPAI_freq%.3f.dat',freq(vstep));
    CoutputfilenameVI = sprintf('VIoutE2_tempPAI_freq%.3f.dat',freq(vstep));

    fprintf('Reading %s...',CoutputfilenameRI);
    tic;
    if exist(CoutputfilenameRI, 'file')
        fileID = fopen(CoutputfilenameRI,'r');
        Outdat = fscanf(fileID, '%f,%f,%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataRR(vstep,1) = Outdat(1);
        CdataRRI(vstep,1) = Outdat(2);
        CdataII(vstep,1) = Outdat(3);
        CdataIIR(vstep,1) = Outdat(4);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameRI);
      CdataRI(:,:) = nan;
    end;
    fprintf('done. [%f]\n',toc);

    fprintf('Reading %s...',CoutputfilenameRV);
    tic;
    if exist(CoutputfilenameRV, 'file')
        fileID = fopen(CoutputfilenameRV,'r');
        Outdat = fscanf(fileID, '%f,%f,%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataRRV(vstep,1) = Outdat(2);
        CdataVVR(vstep,1) = Outdat(4);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameRV);
      CdataRV(:,:) = nan;
    end;
    fprintf('done. [%f]\n',toc);

    fprintf('Reading %s...',CoutputfilenameVI);
    tic;
    if exist(CoutputfilenameVI, 'file')
        fileID = fopen(CoutputfilenameVI,'r');
        Outdat = fscanf(fileID, '%f,%f,%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataVV(vstep,1) = Outdat(1);
        CdataVVI(vstep,1) = Outdat(2);
        CdataIIV(vstep,1) = Outdat(4);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
      CdataVI(:,:) = nan;
    end;
    fprintf('done. [%f]\n',toc);

end;
save 'RLcircuitDataExplorePAI_DataRead.mat';