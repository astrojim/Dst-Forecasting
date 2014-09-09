load '../LinearEx_OutChangeL_A5/LinearEx_ChangeL_DataRead_A5.mat';
CXY_A30B26 = CdataXY;
CYX_A30B26 = CdataYX;

%running means
Delta_A30B26 = zeros(length(Tfinals),1);
Delta_A26B26 = zeros(length(Tfinals),1);
for iter = 1:1:length(Tfinals),
    Delta_A30B26(iter) = CYX_A30B26(iter)-CXY_A30B26(iter);
end;

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
hPnts = plot(Tfinals,Delta_A30B26,'k.','LineWidth',1.5);
%hText = text(500,0.35,'(c)',...
%     'FontSize',10,'FontName','Times');
grid on;
axis([0 4180 -0.2 0.2]);
hXLabel = xlabel('L');
hYLabel = ylabel('\Delta');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

%{
hLegend = legend('(A,B) = (3.0,2.6)',...
                 '(A,B) = (2.6,2.6)');
set(hLegend,'FontName','Times');
set(hLegend,'FontSize', 10);
%}

hold off;
print -depsc2 ../PlotOutTempDir/LinearExChangeL.eps
close;