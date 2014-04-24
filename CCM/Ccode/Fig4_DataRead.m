addpath('..');
addpath('../../utils');

OmegaVec = [0.01:0.001:2.0];

CdataRI = zeros(length(OmegaVec),2);
CdataRV = zeros(length(OmegaVec),2);
CdataVI = zeros(length(OmegaVec),2);

for ostep = 1:length(OmegaVec),

    fprintf('--> Omega = %.2f [%.2f complete] <--\n',...
        OmegaVec(ostep),ostep/length(OmegaVec));
    Omega = OmegaVec(ostep);
    CoutputfilenameRI = sprintf('RIout_omega%.3f.dat',OmegaVec(ostep));
    CoutputfilenameRV = sprintf('RVout_omega%.3f.dat',OmegaVec(ostep));
    CoutputfilenameVI = sprintf('VIout_omega%.3f.dat',OmegaVec(ostep));
    
    fprintf('Reading %s...',CoutputfilenameRI);
    tic;
    if exist(CoutputfilenameRI, 'file')
        fileID = fopen(CoutputfilenameRI,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataRI(ostep,1) = Outdat(1);
        CdataRI(ostep,2) = Outdat(2);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameRI);
      CdataRI(:,:) = nan;
    end;
    fprintf('done. [%f]\n',toc);

    fprintf('Reading %s...',CoutputfilenameRV);
    tic;
    if exist(CoutputfilenameRV, 'file')
        fileID = fopen(CoutputfilenameRV,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataRV(ostep,1) = Outdat(1);
        CdataRV(ostep,2) = Outdat(2);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameRV);
      CdataRV(:,:) = nan;
    end;
    fprintf('done. [%f]\n',toc);
    
    fprintf('Reading %s...',CoutputfilenameVI);
    tic;
    if exist(CoutputfilenameVI, 'file')
        fileID = fopen(CoutputfilenameVI,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) == 0),
            fprintf('Warning: Too few output data points\n');
        end;
        CdataVI(ostep,1) = Outdat(1);
        CdataVI(ostep,2) = Outdat(2);
    else
      fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
      CdataVI(:,:) = nan;
    end;
    fprintf('done. [%f]\n',toc);

end;

