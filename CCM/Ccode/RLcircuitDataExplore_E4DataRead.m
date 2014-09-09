addpath('..');
addpath('../../utils');

bVaryV_amp = false;
bVaryV_offset = false;
bVaryV_phase = false;
bVaryV_freq = true;
bVaryR_amp = false;
bVaryR_offset = false;
bVaryR_phase = false;
bVaryR_freq = false;

bVaryV_offsetlong = false;
bVaryV_offsetLup = false;

bVaryR_freqlong = false;
bVaryR_freqLup = false;

if( bVaryV_amp ),

    Av = [0.01:0.01:2.0];

    CdataRI = zeros(length(Av),2);
    CdataRV = zeros(length(Av),2);
    CdataVI = zeros(length(Av),2);

    for vstep = 1:length(Av),

        fprintf('--> Av = %.2f [%.2f complete] <--\n',...
            Av(vstep),vstep/length(Av));
        CoutputfilenameRI = sprintf('RIoutE3_temp_Av%.3f.dat',Av(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_temp_Av%.3f.dat',Av(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_temp_Av%.3f.dat',Av(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryV_offset ),
    
    offset = [0.01:0.01:2.0];

    CdataRI = zeros(length(offset),2);
    CdataRV = zeros(length(offset),2);
    CdataVI = zeros(length(offset),2);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.2f [%.2f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        CoutputfilenameRI = sprintf('RIoutE3_temp_offset%.3f.dat',offset(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_temp_offset%.3f.dat',offset(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_temp_offset%.3f.dat',offset(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryV_phase ),
    
    phase = [0.01:0.01:2.0];

    CdataRI = zeros(length(phase),2);
    CdataRV = zeros(length(phase),2);
    CdataVI = zeros(length(phase),2);

    for vstep = 1:length(phase),

        fprintf('--> phase = %.2f [%.2f complete] <--\n',...
            phase(vstep),vstep/length(phase));
        CoutputfilenameRI = sprintf('RIoutE3_temp_phase%.3f.dat',phase(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_temp_phase%.3f.dat',phase(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_temp_phase%.3f.dat',phase(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryV_freq ),
    
    freq = [0.01:0.01:1.6];

    CdataRI = zeros(length(freq),2);
    CdataRV = zeros(length(freq),2);
    CdataVI = zeros(length(freq),2);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.2f [%.2f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        CoutputfilenameRI = sprintf('RIoutE4_temp_freq%.3f.dat',freq(vstep));
        CoutputfilenameRV = sprintf('RVoutE4_temp_freq%.3f.dat',freq(vstep));
        CoutputfilenameVI = sprintf('VIoutE4_temp_freq%.3f.dat',freq(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryR_amp ),

    Av = [0.01:0.01:2.0];

    CdataRI = zeros(length(Av),2);
    CdataRV = zeros(length(Av),2);
    CdataVI = zeros(length(Av),2);

    for vstep = 1:length(Av),

        fprintf('--> Av = %.2f [%.2f complete] <--\n',...
            Av(vstep),vstep/length(Av));
        CoutputfilenameRI = sprintf('RIoutE3_tempR_Av%.3f.dat',Av(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_tempR_Av%.3f.dat',Av(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_tempR_Av%.3f.dat',Av(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryR_offset ),
    
    offset = [0.01:0.01:2.0];

    CdataRI = zeros(length(offset),2);
    CdataRV = zeros(length(offset),2);
    CdataVI = zeros(length(offset),2);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.2f [%.2f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        CoutputfilenameRI = sprintf('RIoutE3_tempR_offset%.3f.dat',offset(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_tempR_offset%.3f.dat',offset(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_tempR_offset%.3f.dat',offset(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryR_phase ),
    
    phase = [0.01:0.01:2.0];

    CdataRI = zeros(length(phase),2);
    CdataRV = zeros(length(phase),2);
    CdataVI = zeros(length(phase),2);

    for vstep = 1:length(phase),

        fprintf('--> phase = %.2f [%.2f complete] <--\n',...
            phase(vstep),vstep/length(phase));
        CoutputfilenameRI = sprintf('RIoutE3_tempR_phase%.3f.dat',phase(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_tempR_phase%.3f.dat',phase(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_tempR_phase%.3f.dat',phase(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryR_freq ),
    
    freq = [0.01:0.01:2.0];

    CdataRI = zeros(length(freq),2);
    CdataRV = zeros(length(freq),2);
    CdataVI = zeros(length(freq),2);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.2f [%.2f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        CoutputfilenameRI = sprintf('RIoutE3_tempR_freq%.3f.dat',freq(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_tempR_freq%.3f.dat',freq(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_tempR_freq%.3f.dat',freq(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryV_offsetlong ),
    
    offset = [0.01:0.05:10.0];

    CdataRI = zeros(length(offset),2);
    CdataRV = zeros(length(offset),2);
    CdataVI = zeros(length(offset),2);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.2f [%.2f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        CoutputfilenameRI = sprintf('RIoutE3_temp_offsetlong%.3f.dat',offset(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_temp_offsetlong%.3f.dat',offset(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_temp_offsetlong%.3f.dat',offset(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryV_offsetLup ),
    
    offset = [0.01:0.01:2.0];

    CdataRI = zeros(length(offset),2);
    CdataRV = zeros(length(offset),2);
    CdataVI = zeros(length(offset),2);

    for vstep = 1:length(offset),

        fprintf('--> offset = %.2f [%.2f complete] <--\n',...
            offset(vstep),vstep/length(offset));
        CoutputfilenameRI = sprintf('RIoutE3_temp_offsetLup%.3f.dat',offset(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_temp_offsetLup%.3f.dat',offset(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_temp_offsetLup%.3f.dat',offset(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryR_freqlong ),
    
    freq = [0.01:0.05:10.0];

    CdataRI = zeros(length(freq),2);
    CdataRV = zeros(length(freq),2);
    CdataVI = zeros(length(freq),2);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.2f [%.2f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        CoutputfilenameRI = sprintf('RIoutE3_tempR_freqlong%.3f.dat',freq(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_tempR_freqlong%.3f.dat',freq(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_tempR_freqlong%.3f.dat',freq(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

if( bVaryR_freqLup ),
    
    freq = [0.01:0.01:2.0];

    CdataRI = zeros(length(freq),2);
    CdataRV = zeros(length(freq),2);
    CdataVI = zeros(length(freq),2);

    for vstep = 1:length(freq),

        fprintf('--> freq = %.2f [%.2f complete] <--\n',...
            freq(vstep),vstep/length(freq));
        CoutputfilenameRI = sprintf('RIoutE3_tempR_freqLup%.3f.dat',freq(vstep));
        CoutputfilenameRV = sprintf('RVoutE3_tempR_freqLup%.3f.dat',freq(vstep));
        CoutputfilenameVI = sprintf('VIoutE3_tempR_freqLup%.3f.dat',freq(vstep));

        fprintf('Reading %s...',CoutputfilenameRI);
        tic;
        if exist(CoutputfilenameRI, 'file')
            fileID = fopen(CoutputfilenameRI,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataRI(vstep,1) = Outdat(1);
            CdataRI(vstep,2) = Outdat(2);
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
            CdataRV(vstep,1) = Outdat(1);
            CdataRV(vstep,2) = Outdat(2);
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
            CdataVI(vstep,1) = Outdat(1);
            CdataVI(vstep,2) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameVI);
          CdataVI(:,:) = nan;
        end;
        fprintf('done. [%f]\n',toc);

    end;
end;

save 'RLcircuitDataExplore_DataRead.mat';