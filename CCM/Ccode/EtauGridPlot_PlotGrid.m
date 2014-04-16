addpath('..');
addpath('../../utils');

library_length = 2000;

E = [2:1:20];
tau = [1:1:50];
Bxy = 0.01;
Byx = 0.2;

fprintf('Loading data...');
tic;
for Estep = 1:1:length(E),
    for taustep = 1:1:length(tau),      
        
        Outfilename = sprintf('out_E%if_tau%i_L%i.dat',E(Estep),tau(taustep),library_length);

        if exist(Outfilename, 'file')
            fileID = fopen(Outfilename,'r');
            Outdat = fscanf(fileID, '%f,%f;');
            fclose(fileID);
            if( numel(Outdat) == 0 ),
                EtauPlotGrid(Estep,taustep) = nan;
            else
                EtauPlotGrid(Estep,taustep) = Outdat(1)-Outdat(2);
            end;
        else
          fprintf('Warning: %s does not exist\n',Outfilename);
          EtauPlotGrid(Estep,taustep) = nan;
        end;
        
    end;
end;
fprintf('done. [%f]\n',toc);
