addpath('..');
addpath('../../utils');

ThreadCounts = [0:1:30];
number_of_samples = 1000;
library_length = 1000;
Bxy = 0.2;
Byx = 0.01;

fprintf('Loading data...');
tic;
for Pstep = 1:1:length(ThreadCounts),
        
   Coutputfilename= sprintf('out_Bxy%.2f_Byx%.2f_L%i_ThCount%i.dat',...
                              Bxy,Byx,library_length,ThreadCounts(Pstep));
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
    
    ThreadPlot(Pstep,1) = nanmean(Cdata(:,1));
    ThreadPlot(Pstep,2) = nanmean(Cdata(:,2));
    
   Coutputfilename = sprintf('out_Bxy%.2f_Byx%.2f_L%i_OpThCount%i.dat',...
                              Bxy,Byx,library_length,ThreadCounts(Pstep));
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
    
    ThreadPlotOp(Pstep,1) = nanmean(Cdata(:,1));
    ThreadPlotOp(Pstep,2) = nanmean(Cdata(:,2));
    
end;
fprintf('done. [%f]\n',toc);
