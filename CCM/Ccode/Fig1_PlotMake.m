%These data sets calculated each point as CCM(X,Y)-CCM(Y,X), but Sugihara
%et al. plot CCM(Y,X)-CCM(X,Y).  Rather than recreate the data sets (which,
%admittedly, would not be too difficult), everything is just multiplied
%through by -1
load 'BGridCOutDataSmallL1500/PlotGridDataL1500.mat';
PlotGridL1500 = -1.*PlotGrid;
load 'BGridCOutDataSmallL1000/PlotGridDataL1000.mat';
PlotGridL1000 = -1.*PlotGrid;
load 'BGridCOutDataSmallL500/PlotGridDataL500.mat';
PlotGridL500 = -1.*PlotGrid;
load 'BGridCOutDataSmallL100/PlotGridDataL100.mat';
PlotGridL100 = -1.*PlotGrid;

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 1.5;    % AxesLineWidth
fsz = 18;      % Fontsize
lw = 2.5;      % LineWidth
msz = 10;       % MarkerSize

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
numColors = 16;
cmap = colormap(gray(numColors));
colormap(cmap); 

subplot(2,2,1);
imagesc(Bxy_vec,Byx_vec,PlotGridL100);
set(gca,'YDir','normal');
hold on;
contour(Bxy_vec,Byx_vec,PlotGridL100,...
        [-0.05 0.05],'k','LineWidth',2,'ShowText','On');
hold off;
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 100');

subplot(2,2,2);
imagesc(Bxy_vec,Byx_vec,PlotGridL500);
set(gca,'YDir','normal');
hold on;
contour(Bxy_vec,Byx_vec,PlotGridL500,...
        [-0.05 0.05],'k','LineWidth',2,'ShowText','On');
hold off;
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 500');

subplot(2,2,3);
imagesc(Bxy_vec,Byx_vec,PlotGridL1000);
set(gca,'YDir','normal');
hold on;
contour(Bxy_vec,Byx_vec,PlotGridL1000,...
        [-0.05 0.05],'k','LineWidth',2,'ShowText','On');
hold off;
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 1000');

subplot(2,2,4);
imagesc(Bxy_vec,Byx_vec,PlotGridL1500);
set(gca,'YDir','normal');
hold on;
contour(Bxy_vec,Byx_vec,PlotGridL1500,...
        [-0.05 0.05],'k','LineWidth',2,'ShowText','On');
hold off;
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 1500');

