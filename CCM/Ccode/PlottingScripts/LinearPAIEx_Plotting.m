load '../LinearEx_OutPAI/LinearEx_OutPAI_temp.mat';

DiffPrime = CdataYYX-CdataXXY;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hPnt1 = plot(Bv/Av(51),DiffPrime(51,:)/Av(51),'k.','MarkerSize',4);
grid on;

hText = text(1,9,'(a)',...
     'FontSize',10,'FontName','Times');

hXLabel = xlabel('B');
hYLabel = ylabel('\Delta');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/LinearExPAI.eps
close;

