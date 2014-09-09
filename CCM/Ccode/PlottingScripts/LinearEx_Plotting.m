load '../LinearEx_Out10x10grid/LinearEx_DataRead_Out10x10grid.mat';

DiffYXXY = CdataYX-CdataXY;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hPnt1 = plot(Bv/Av(51),DiffYXXY(51,:)/Av(51),'k.','MarkerSize',4);
grid on;

hXLabel = xlabel('B');
hYLabel = ylabel('\Delta');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hText = text(0.009,0.15,'(a)',...
     'FontSize',10,'FontName','Times');

hold off;
print -depsc2 ../PlotOutTempDir/LinearEx.eps
close;

temp = DiffYXXY;
temp(temp<0) = -1;
temp(temp>0) = 1;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

cmap = colormap(flipud(gray(2)));
hImage = imagesc(Bv,Av,temp);
set(gca,'YDir','normal');
axis([0 10 0 10]);

cbar = lcolorbar({'< 0','> 0'},'FontName','Times','FontSize',10);

hXLabel = xlabel('B');
hYLabel = ylabel('A');
hCLabel = title(cbar,'\Delta');

set([hXLabel, hYLabel, hCLabel],'FontName','Times');
set([hXLabel, hYLabel, hCLabel],'FontSize', 10);

hText = text(1,9,'(b)',...
     'FontSize',10,'FontName','Times');

hold off;
print -depsc2 ../PlotOutTempDir/LinearEx3Color.eps
%close;
