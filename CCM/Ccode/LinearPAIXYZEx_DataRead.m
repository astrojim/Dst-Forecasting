Av = 0:0.1:4.0;
Bv = 0:0.1:4.0;

CdataXX = zeros(length(Av),length(Bv));
CdataXXY = CdataXX;
CdataYY = CdataXX;
CdataYYX = CdataXX;
CdataXXZ = CdataXX;
CdataZZX = CdataXX;
CdataYYZ = CdataXX;
CdataZZ = CdataXX;
CdataZZY = CdataXX;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),

        fprintf('--> A = %.2f; B = %.2f <--\n',...
            Av(Astep),Bv(Bstep));        
                
        CoutputfilenameXY = sprintf('XYoutPAIXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CoutputfilenameYZ = sprintf('YZoutPAIXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CoutputfilenameXZ = sprintf('XZoutPAIXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));

        fprintf('Reading %s...',CoutputfilenameXY);
        tic;
        if exist(CoutputfilenameXY, 'file')
            fileID = fopen(CoutputfilenameXY,'r');
            Outdat = fscanf(fileID, '%f,%f,%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataXX(Astep,Bstep) = Outdat(1);
            CdataXXY(Astep,Bstep) = Outdat(2);
            CdataYY(Astep,Bstep) = Outdat(3);
            CdataYYX(Astep,Bstep) = Outdat(4);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
          %CdataXY(Astep,Bstep) = nan;
          %CdataYX(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);
        
        fprintf('Reading %s...',CoutputfilenameYZ);
        tic;
        if exist(CoutputfilenameYZ, 'file')
            fileID = fopen(CoutputfilenameYZ,'r');
            Outdat = fscanf(fileID, '%f,%f,%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataYYZ(Astep,Bstep) = Outdat(2);
            CdataZZ(Astep,Bstep) = Outdat(3);
            CdataZZY(Astep,Bstep) = Outdat(4);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameYZ);
          %CdataYZ(Astep,Bstep) = nan;
          %CdataZY(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);
        
        fprintf('Reading %s...',CoutputfilenameXZ);
        tic;
        if exist(CoutputfilenameXZ, 'file')
            fileID = fopen(CoutputfilenameXZ,'r');
            Outdat = fscanf(fileID, '%f,%f,%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataXXZ(Astep,Bstep) = Outdat(2);
            CdataZZX(Astep,Bstep) = Outdat(4);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameXZ);
          %CdataXZ(Astep,Bstep) = nan;
          %CdataZX(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);
    
    end;
end;