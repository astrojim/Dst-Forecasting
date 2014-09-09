load '../LinearEx_OutChangeLPAI_A5/LinearExPAI_ChangeL_DataRead_A5.mat';
CXXY_A30B26 = CdataXXY;
CYYX_A30B26 = CdataYYX;

%running means
Delta_A30B26 = zeros(length(Tfinals),1);
for iter = 1:1:length(Tfinals),
    Delta_A30B26(iter) = CYYX_A30B26(iter)-CXXY_A30B26(iter);
end;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(Tfinals,Delta_A30B26,'k.','LineWidth',1.5);
%hText = text(400,-0.17,'(b)',...
%     'FontSize',10,'FontName','Times');
grid on;
axis([0 4180 -0.2 0]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta\prime');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

%{
hLegend = legend('(A,B) = (3.0,2.6)',...
                 '(A,B) = (2.6,2.6)',...
                 'Location','SouthEast');
%}
hold off;
print -depsc2 ../PlotOutTempDir/LinearExPAIChangeL.eps
close;