Av = 0:0.1:10.0;
Bv = 0:0.1:10.0;

CdataXX = zeros(length(Av),length(Bv));
CdataXXY = CdataXX;
CdataYY = CdataXX;
CdataYYX = CdataXX;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),

        fprintf('--> A = %.2f; B = %.2f <--\n',...
            Av(Astep),Bv(Bstep));
        
        CoutputfilenameXY = sprintf('XYoutPAI_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));
        
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
            CdataXX(Astep,Bstep) = nan;
            CdataXXY(Astep,Bstep) = nan;
            CdataYY(Astep,Bstep) = nan;
            CdataYYX(Astep,Bstep) = nan;
        end;
        fprintf('done. [%f]\n',toc);    
    end;
end;