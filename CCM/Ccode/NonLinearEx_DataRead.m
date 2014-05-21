Av = 0:0.5:5.0;
Bv = 0:0.5:5.0;
Cv = 0:0.5:5.0;

CdataXY = zeros(length(Av),length(Bv),length(Cv));
CdataYX = CdataXY;

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),
        for Cstep = 1:1:length(Cv),

            CoutputfilenameXY = sprintf('XYout_A%.2fB%.2fC%.2f.dat',...
                Av(Astep),Bv(Bstep),Cv(Cstep));

            fprintf('Reading %s...',CoutputfilenameXY);
            tic;
            if exist(CoutputfilenameXY, 'file')
                fileID = fopen(CoutputfilenameXY,'r');
                Outdat = fscanf(fileID, '%f,%f');
                fclose(fileID);
                if(numel(Outdat) == 0),
                    fprintf('Warning: Too few output data points\n');
                end;
                CdataXY(Astep,Bstep,Cstep) = Outdat(1);
                CdataYX(Astep,Bstep,Cstep) = Outdat(2);
            else
              fprintf('Warning: %s does not exist\n',CoutputfilenameXY);
              CdataXY(Astep,Bstep,Cstep) = nan;
              CdataYX(Astep,Bstep,Cstep) = nan;
            end;
            fprintf('done. [%f]\n',toc);

        end;
    end;
end;