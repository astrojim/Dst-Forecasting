load 'LinearEx_OutChangeLPAI/LinearExPAI_ChangeL_DataRead_A30B26.mat';
CXXY_A30B26 = CdataXXY;
CYYX_A30B26 = CdataYYX;

load 'LinearEx_OutChangeLPAI/LinearExPAI_ChangeL_DataRead_A26B26.mat';
CXXY_A26B26 = CdataXXY;
CYYX_A26B26 = CdataYYX;

%running means
Delta_A30B26 = zeros(length(Tfinals),1);
Delta_A26B26 = zeros(length(Tfinals),1);
for iter = 1:1:length(Tfinals),
    Delta_A30B26(iter) = CYYX_A30B26(iter)-CXXY_A30B26(iter);
    Delta_A26B26(iter) = CYYX_A26B26(iter)-CXXY_A26B26(iter);
end;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(Tfinals,Delta_A30B26,'r--',...
              Tfinals,Delta_A26B26,'k-',...
              'LineWidth',1.5);
grid on;
axis([0 4180 -0.2 0]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta^\prime');
set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);


hLegend = legend('(A,B) = (3.0,2.6)',...
                 '(A,B) = (2.6,2.6)');
hold off;
print -depsc2 PlotOutTempDir/LinearExPAIChangeL.eps
close;