load 'BGridL100E2t1_PlotGrid.mat';
PlotGridL100 = PlotGrid;
load 'BGridL400E2t1_PlotGrid.mat';
PlotGridL400 = PlotGrid;
load 'BGridL800E2t1_PlotGrid.mat';
PlotGridL800 = PlotGrid;
load 'BGridL1200E2t1_PlotGrid.mat';
PlotGridL1200 = PlotGrid;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

subplot(1,2,1);
hImage1 = imagesc(Bxy_vec,Byx_vec,PlotGridL100);
set(gca,'YDir','normal');
hold on;
hCont1 = contour(Bxy_vec,Byx_vec,PlotGridL100,...
            [-0.01 0.01],'k','LineWidth',2);
hCont2 = contour(Bxy_vec,Byx_vec,PlotGridL100,...
            [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','off');

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 100');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

subplot(1,2,2);
hImage2 = imagesc(Bxy_vec,Byx_vec,PlotGridL400);
set(gca,'YDir','normal');
hold on;
hCont2 = contour(Bxy_vec,Byx_vec,PlotGridL400,...
            [-0.01 0.01],'k','LineWidth',2);
hCont3 = contour(Bxy_vec,Byx_vec,PlotGridL100,...
            [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 400');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/Figure1A.eps
close;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

subplot(1,2,1);
hImage3 = imagesc(Bxy_vec,Byx_vec,PlotGridL800);
set(gca,'YDir','normal');
hold on;
hCont3 = contour(Bxy_vec,Byx_vec,PlotGridL800,...
            [-0.01 0.01],'k','LineWidth',2);
hCont4 = contour(Bxy_vec,Byx_vec,PlotGridL100,...
            [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','off');

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 800');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

subplot(1,2,2);
hImage4 = imagesc(Bxy_vec,Byx_vec,PlotGridL1200);
set(gca,'YDir','normal');
hold on;
hCont4 = contour(Bxy_vec,Byx_vec,PlotGridL1200,...
            [-0.01 0.01],'k','LineWidth',2);
hCont5 = contour(Bxy_vec,Byx_vec,PlotGridL100,...
            [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','off');

hXLabel = xlabel('\beta_{yx}');
hYLabel = ylabel('\beta_{xy}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('L = 1200');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/Figure1B.eps
close;
