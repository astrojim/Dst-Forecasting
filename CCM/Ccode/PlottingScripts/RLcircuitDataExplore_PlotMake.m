load 'RLcircuitDataExplore_DataRead_varyV_freq.mat';
data = freq;
dataLabel = 'freq';

Delta = CdataVI(:,1) - CdataVI(:,2);

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hPnts = plot(Delta,'.k','MarkerSize',6);
grid on;

hXLabel = xlabel('\Omega_v');
hYLabel = ylabel('\Delta = C_{VI}-C_{IV}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 9);

hold off;
print -depsc2 ../PlotOutTempDir/RLCircuitVaryV_Freq.eps
close;
