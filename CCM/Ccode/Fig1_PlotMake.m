%These data sets calculated each point as CCM(X,Y)-CCM(Y,X), but Sugihara
%et al. plot CCM(Y,X)-CCM(X,Y).  Rather than recreate the data sets (which,
%admittedly, would not be too difficult), everything is just multiplied
%through by -1
load 'BGridCOutDataSmallL1000/PlotGridDataL1000.mat';
PlotGridL1000 = -1.*PlotGrid;
load 'BGridCOutDataSmallL500/PlotGridDataL500.mat';
PlotGridL500 = -1.*PlotGrid;
load 'BGridCOutDataSmallL100/PlotGridDataL100.mat';
PlotGridL100 = -1.*PlotGrid;

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2.0;      % LineWidth
msz = 8;       % MarkerSize

figure(1);
subplot(2,2,1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
contourf(Bxy_vec,Byx_vec,PlotGridL100,15);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
colorbar(); 
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 100');

subplot(2,2,2);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
contourf(Bxy_vec,Byx_vec,PlotGridL500,15);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
colorbar(); 
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 500');

subplot(2,2,3);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
contourf(Bxy_vec,Byx_vec,PlotGridL1000,15);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
colorbar(); 
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 1000');

subplot(2,2,4);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
contourf(Bxy_vec,Byx_vec,PlotGridL1000,15);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
colorbar(); 
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('PLACEHOLDER --- L = 1000');