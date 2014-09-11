load '../SnowDataOut/snowdata_DataRead.mat';

%running means
Delta_CCM = zeros(length(TfinalsCCM),1);
Delta_PAI = zeros(length(TfinalsPAI),1);
for iter = 1:1:length(TfinalsCCM),
    Delta_CCM(iter) = CdataYX_CCM(iter)-CdataXY_CCM(iter);
end;
for iter = 1:1:length(TfinalsPAI),
    Delta_PAI(iter) = CdataYX_PAI(iter)-CdataXY_PAI(iter);
end;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(TfinalsCCM,Delta_CCM,'k.','LineWidth',1.5);
%hText = text(500,0.35,'(c)',...
%     'FontSize',10,'FontName','Times');
grid on;
%axis([0 4180 -0.2 0.2]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/snowdataCCM.eps
close;


figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(TfinalsPAI,Delta_PAI,'k.','LineWidth',1.5);
%hText = text(500,0.35,'(c)',...
%     'FontSize',10,'FontName','Times');
grid on;
%axis([0 4180 -0.2 0.2]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta\prime');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/snowdataPAI.eps
close;