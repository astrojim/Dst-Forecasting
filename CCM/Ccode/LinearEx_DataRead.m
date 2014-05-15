addpath('..');
addpath('../../utils');

tspan = 0:0.5:1000;
library_length = length(tspan);

Av = 0:0.1:10.0;
Bv = 0:0.1:10.0;

CdataXY = zeros(length(Av),length(Bv));
CdataYX = zeros(length(Av),length(Bv));

for Astep = 1:1:length(Av),
    for Bstep = 1:1:length(Bv),

        fprintf('--> A = %.2f; B = %.2f <--\n',...
                Av(Astep),Bv(Bstep));
        CoutputfilenameXY = sprintf('XYout_A%.2fB%.2f.dat',Av(Astep),Bv(Bstep));

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
        
    end;   
end;

save 'LinearEx_DataRead.mat';