addpath('..');
addpath('../../utils');

number_of_samples = 1000;
library_length = 1200;

Bxy_vec = [1e-8:0.02:0.5];
Byx_vec = [1e-8:0.02:0.5];

PointTotal = length(Bxy_vec)*length(Byx_vec);
fprintf('There are %i points total.\n',PointTotal);
PointCount = 1;

for Bxystep = 1:1:length(Bxy_vec),
    for Byxstep = 1:1:length(Byx_vec),    
        
        Cdata = zeros(number_of_samples,2);
        fprintf('== Point %i (%f); Bxy %i,Byx %i ==\n',...
            PointCount,PointCount/PointTotal,Bxy_vec(Bxystep),Byx_vec(Byxstep));
        PointCount = PointCount+1;
        Coutputfilename = sprintf('out_Bxy%.2f_Byx%.2f_L%i.dat',Bxy_vec(Bxystep),Byx_vec(Byxstep),library_length);
        fprintf('Reading %s...',Coutputfilename);
        tic;
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
        fprintf('done. [%f]\n',toc);

        Meansfilename = sprintf('means_Bxy%.2f_Byx%.2f_L%i.dat',Bxy_vec(Bxystep),Byx_vec(Byxstep),library_length);
        fprintf('Writing means ...');
        fileID = fopen(Meansfilename,'w');
        fprintf(fileID,'%.20f,%.20f;\n',nanmean(Cdata(:,1)),nanmean(Cdata(:,2)));
        fclose(fileID);
        fprintf('done. [%f]\n',toc);
        
    end;
end;
