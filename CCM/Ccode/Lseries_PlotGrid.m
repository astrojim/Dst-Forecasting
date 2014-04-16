addpath('..');
addpath('../../utils');

library_length = [50:10:2000];
number_of_samples = 1000;
Bxy = 0.01;
Byx = 0.2;

fprintf('Loading data...');
tic;
for Lstep = 1:1:length(library_length),
        
   Coutputfilename = sprintf('Lseries_Bxy%.2f_Byx%.2f_L%i.dat',Bxy,Byx,library_length(Lstep));

   Cdata = zeros(number_of_samples,2);
   if exist(Coutputfilename, 'file')
        fileID = fopen(Coutputfilename,'r');
        Outdat = fscanf(fileID, '%f,%f');
        fclose(fileID);
        if(numel(Outdat) ~= 2*number_of_samples),
            fprintf('Warning: Too few output data points %i\n',(2*floor(numel(Outdat)/2)));
        end;
        iter = 1;
        for Rstep = 1:2:(2*floor(numel(Outdat)/2)),
            Cdata(iter,1) = Outdat(Rstep);
            Cdata(iter,2) = Outdat(Rstep+1);
            iter = iter+1;
        end;
    else
      fprintf('Warning: %s does not exist\n',Coutputfilename);
      Cdata(:,:) = nan;
    end;
    
    LseriesPlot(Lstep,1) = nanmean(Cdata(:,1));
    LseriesPlot(Lstep,2) = nanmean(Cdata(:,2));
    
end;
fprintf('done. [%f]\n',toc);
