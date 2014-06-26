load 'LinearEx_Out10x10grid/LinearEx_DataRead_Out10x10grid.mat';

DiffYXXY = CdataYX-CdataXY;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,DiffYXXY);
hPnt1 = plot(Bv(27),Av(31),'ko','MarkerSize',4);
hPnt1 = plot(Bv(27),Av(27),'ko','MarkerSize',4);
set(gca,'YDir','normal');
caxis([-0.12 0.12]);
axis([0 10 0 10]);
cbar = colorbar();

hXLabel = xlabel('B');
hYLabel = ylabel('A');
hCLabel = title(cbar,'\Delta');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 PlotOutTempDir/LinearEx.eps
close;


temp = DiffYXXY;
temp(temp<0) = -1;
temp(temp>0) = 1;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,temp);
set(gca,'YDir','normal');
axis([0 10 0 10]);

hXLabel = xlabel('B');
hYLabel = ylabel('A');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 PlotOutTempDir/LinearEx3Color.eps
close;
