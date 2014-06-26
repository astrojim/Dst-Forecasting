load 'BGridCOutDataL100E2t1/BGridL100E2t1_PlotGrid.mat';
PlotGridL100 = PlotGrid;
load 'BGridCOutDataL400E2t1/BGridL400E2t1_PlotGrid.mat';
PlotGridL400 = PlotGrid;
load 'BGridCOutDataL800E2t1/BGridL800E2t1_PlotGrid.mat';
PlotGridL800 = PlotGrid;
load 'BGridCOutDataL1200E2t1/BGridL1200E2t1_PlotGrid.mat';
PlotGridL1200 = PlotGrid;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

subplot(2,2,1);
hImage1 = imagesc(Bxy_vec,Byx_vec,PlotGridL100);
set(gca,'YDir','normal');
hold on;
hCont1 = contour(Bxy_vec,Byx_vec,PlotGridL100,...
            [-0.01 0.01],'k','LineWidth',2,'ShowText','On');

xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 100');


subplot(2,2,2);
hImage2 = imagesc(Bxy_vec,Byx_vec,PlotGridL400);
set(gca,'YDir','normal');
hold on;
hCont2 = contour(Bxy_vec,Byx_vec,PlotGridL400,...
            [-0.01 0.01],'k','LineWidth',2,'ShowText','On');

xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 400');

subplot(2,2,3);
hImage3 = imagesc(Bxy_vec,Byx_vec,PlotGridL800);
set(gca,'YDir','normal');
hold on;
hCont3 = contour(Bxy_vec,Byx_vec,PlotGridL800,...
            [-0.01 0.01],'k','LineWidth',2,'ShowText','On');

xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 800');

subplot(2,2,4);
hImage4 = imagesc(Bxy_vec,Byx_vec,PlotGridL1200);
set(gca,'YDir','normal');
hold on;
hCont4 = contour(Bxy_vec,Byx_vec,PlotGridL1200,...
            [-0.01 0.01],'k','LineWidth',2,'ShowText','On');

xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 1200');

hold off;
print -depsc2 PlotOutTempDir/Figure1.eps
close;
