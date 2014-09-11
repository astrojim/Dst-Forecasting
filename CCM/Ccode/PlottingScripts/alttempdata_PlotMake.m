load '../AltTempDataOut/alttempdata_DataRead.mat';

%running means
Delta_CCM = zeros(length(Tfinals),1);
Delta_PAI = zeros(length(Tfinals),1);
for iter = 1:1:length(Tfinals),
    Delta_CCM(iter) = CdataYX(iter)-CdataXY(iter);
end;
for iter = 1:1:length(Tfinals),
    Delta_PAI(iter) = CdataYYX(iter)-CdataXXY(iter);
end;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(Tfinals,Delta_CCM,'k.','LineWidth',1.5);
%hText = text(500,0.35,'(c)',...
%     'FontSize',10,'FontName','Times');
grid on;
axis([0 350 -0.2 0.1]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/alttempdataCCM.eps
close;


figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(Tfinals,Delta_PAI,'k.','LineWidth',1.5);
%hText = text(500,0.35,'(c)',...
%     'FontSize',10,'FontName','Times');
grid on;
axis([0 350 -0.1 0.05]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta\prime');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/alttempdataPAI.eps
close;