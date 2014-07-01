load 'LinearEx_OutPAI_temp.mat';

DiffPrime = CdataYYX-CdataXXY;

width = 4.5;
height = 2.5;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,DiffPrime);
hPnt1 = plot(Bv(27),Av(31),'ko','MarkerSize',4);
hPnt2 = plot(Bv(27),Av(27),'ko','MarkerSize',4);
hText = text(1,9,'(a)',...
     'FontSize',10,'FontName','Times');

set(gca,'YDir','normal');
axis([0 10 0 10]);
cbar = colorbar();

hXLabel = xlabel('B');
hYLabel = ylabel('A');
hCLabel = title(cbar,'\Delta\prime');

set([hXLabel, hYLabel, hCLabel],'FontName','Times');
set([hXLabel, hYLabel, hCLabel],'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/LinearExPAI.eps
close;

