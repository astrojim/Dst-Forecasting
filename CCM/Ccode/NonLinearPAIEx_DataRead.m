Av = 0:0.5:5.0;
Bv = 0:0.5:5.0;
Cv = 0:0.5:5.0;

CdataXX = zeros(length(Av),length(Bv),length(Cv));
CdataYY = CdataXX;
CdataYYX = CdataXX;
CdataXXY = CdataXX;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),
        for Cstep = 1:1:length(Cv),

            CoutputfilenameXY = sprintf('XYoutPAI_A%.2fB%.2fC%.2f.dat',...
                Av(Astep),Bv(Bstep),Cv(Cstep));

            fprintf('Reading %s...',CoutputfilenameXY);
            tic;
            if exist(CoutputfilenameXY, 'file')
                fileID = fopen(CoutputfilenameXY,'r');
                Outdat = fscanf(fileID, '%f,%f,%f,%f');
                fclose(fileID);
                if(numel(Outdat) == 0),
                    fprintf('Warning: Too few output data points\n');
                end;
                CdataXX(Astep,Bstep,Cstep) = Outdat(1);
                CdataXXY(Astep,Bstep,Cstep) = Outdat(2);
                CdataYY(Astep,Bstep,Cstep) = Outdat(3);
                CdataYYX(Astep,Bstep,Cstep) = Outdat(4);
            else
              fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
              CdataXX(Astep,Bstep,Cstep) = nan;
              CdataXXY(Astep,Bstep,Cstep) = nan;
              CdataYY(Astep,Bstep,Cstep) = nan;
              CdataYYX(Astep,Bstep,Cstep) = nan;
            end;
            fprintf('done. [%f]\n',toc);

        end;
    end;
end;