Av = 0:0.1:5.0;
Bv = 0:0.1:5.0;

CdataXY = zeros(length(Av),length(Bv));
CdataYX = CdataXY;
CdataXZ = CdataXY;
CdataZX = CdataXY;
CdataYZ = CdataXY;
CdataZY = CdataXY;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),

        fprintf('--> A = %.2f; B = %.2f <--\n',...
            Av(Astep),Bv(Bstep));        
                
        CoutputfilenameXY = sprintf('XYoutXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CoutputfilenameYZ = sprintf('YZoutXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        CoutputfilenameXZ = sprintf('XZoutXYZ_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));

        fprintf('Reading %s...',CoutputfilenameXY);
        tic;
        if exist(CoutputfilenameXY, 'file')
            fileID = fopen(CoutputfilenameXY,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataXY(Astep,Bstep) = Outdat(1);
            CdataYX(Astep,Bstep) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
          CdataXY(Astep,Bstep) = nan;
          CdataYX(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);
        
        fprintf('Reading %s...',CoutputfilenameYZ);
        tic;
        if exist(CoutputfilenameYZ, 'file')
            fileID = fopen(CoutputfilenameYZ,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataYZ(Astep,Bstep) = Outdat(1);
            CdataZY(Astep,Bstep) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameYZ);
          CdataYZ(Astep,Bstep) = nan;
          CdataZY(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);
        
        fprintf('Reading %s...',CoutputfilenameXZ);
        tic;
        if exist(CoutputfilenameXZ, 'file')
            fileID = fopen(CoutputfilenameXZ,'r');
            Outdat = fscanf(fileID, '%f,%f');
            fclose(fileID);
            if(numel(Outdat) == 0),
                fprintf('Warning: Too few output data points\n');
            end;
            CdataXZ(Astep,Bstep) = Outdat(1);
            CdataZX(Astep,Bstep) = Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',CoutputfilenameXZ);
          CdataXZ(Astep,Bstep) = nan;
          CdataZX(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);
    
    end;
end;