%These data sets calculated each point as CCM(X,Y)-CCM(Y,X), but Sugihara
%et al. plot CCM(Y,X)-CCM(X,Y).  Rather than recreate the data sets (which,
%admittedly, would not be too difficult), everything is just multiplied
%through by -1
%load 'EtauGrid/EtauPlotData.mat';
load 'EtauGrid_ALTforCOMPARISON/EtauPlotData.mat';
PlotGrid = -1.*EtauPlotGrid;
PlotGrid = PlotGrid(3:end,1:15);


width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
numContours = 12;
cmap = colormap(gray(numContours));
colormap(flipud(cmap)); 

hImage = imagesc(PlotGrid);
set(gca,'YDir','normal');

caxis([-0.8 0.4]);
cbar = colorbar();
title(cbar,'\Delta');

hXLabel = xlabel('\tau');
hYLabel = ylabel('E');
set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);
axis([1 15 1 17]);

set(gca,'XTick',1:1:15);
ymarks = 3:1:length(E);
set(gca,'YTick',1:1:(length(E)-2));
set(gca,'YTickLabel',arrayfun(@num2str, ymarks, 'unif', 0));

for xt = 1:size(PlotGrid,1),
    for yt = 1:size(PlotGrid,2),
        if(PlotGrid(xt,yt) > 0),
            negpt = plot(yt,xt,'.','LineWidth',1,'MarkerEdgeColor','w','MarkerSize',4);
        end;
    end;
end;

hold off;
print -depsc2 PlotOutTempDir/Figure2_Etau.eps
close;

