addpath('..');
addpath('../../utils');

Coutputfilename = 'BGridCOutDataSmallL1000/out_Bxy0.02_Byx0.10.dat';
fprintf('Reading %s...',Coutputfilename);
tic;
if exist(Coutputfilename, 'file')
    fileID = fopen(Coutputfilename,'r');
    Outdat = fscanf(fileID, '%f,%f');
    fclose(fileID);
    if(numel(Outdat) ~= 2000),
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

X = nanmean(Cdata(:,1));
Y = nanmean(Cdata(:,2));

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2.0;      % LineWidth
msz = 8;       % MarkerSize

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
axis([0 1 0 1]);
axis square;
arrow([0 0],[X Y]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','X','X','Y');
Ystring = sprintf('C_{%s,%s|%s}','Y','Y','X');
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
xlabel(Xstring);
ylabel(Ystring);
hold off;
