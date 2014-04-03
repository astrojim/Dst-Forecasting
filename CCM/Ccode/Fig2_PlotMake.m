%These data sets calculated each point as CCM(X,Y)-CCM(Y,X), but Sugihara
%et al. plot CCM(Y,X)-CCM(X,Y).  Rather than recreate the data sets (which,
%admittedly, would not be too difficult), everything is just multiplied
%through by -1
load 'EtauGrid/EtauPlotData.mat';
PlotGrid = -1.*EtauPlotGrid;
PlotGrid = PlotGrid(3:end,1:15);

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2.0;      % LineWidth
msz = 8;       % MarkerSize
numContours = 15;

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
cmap = colormap(gray(numContours));
colormap(flipud(cmap)); 
imagesc(PlotGrid);
%xlim([0 0.48]);
%ylim([0 0.48]);
%caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\tau');
ylabel('E');
set(gca,'XTick',1:1:15);
ymarks = 3:1:length(E);
set(gca,'YTick',1:1:(length(E)-2));
set(gca,'YTickLabel',arrayfun(@num2str, ymarks, 'unif', 0));
%title('');

