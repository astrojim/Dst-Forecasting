addpath('..');
addpath('../../utils');

library_length = 1500;

Bxy_vec = [1e-8:0.02:0.5];
Byx_vec = [1e-8:0.02:0.5];

PointTotal = length(Bxy_vec)*length(Byx_vec);
PlotGrid = zeros(length(Bxy_vec),length(Byx_vec));

fprintf('Loading data...');
tic;
for Bxystep = 1:1:length(Bxy_vec),
    for Byxstep = 1:1:length(Byx_vec),    
        
        Meansfilename = sprintf('means_Bxy%.2f_Byx%.2f_L%i.dat',Bxy_vec(Bxystep),Byx_vec(Byxstep),library_length);

        if exist(Meansfilename, 'file')
            fileID = fopen(Meansfilename,'r');
            Outdat = fscanf(fileID, '%f,%f;');
            fclose(fileID);
            PlotGrid(Bxystep,Byxstep) = Outdat(1)-Outdat(2);
        else
          fprintf('Warning: %s does not exist\n',Meansfilename);
          PlotGrid(Bxystep,Byxstep) = nan;
        end;
        
    end;
end;
fprintf('done. [%f]\n',toc);
