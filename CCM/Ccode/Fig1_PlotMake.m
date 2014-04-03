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

%Cut values for plotting effect
PlotGridL100(find(PlotGridL100 > -0.01 & PlotGridL100 < 0.01)) = nan;
PlotGridL500(find(PlotGridL500 > -0.01 & PlotGridL500 < 0.01)) = nan;
PlotGridL1000(find(PlotGridL1000 > -0.01 & PlotGridL1000 < 0.01)) = nan;
PlotGridL1500(find(PlotGridL1500 > -0.01 & PlotGridL1500 < 0.01)) = nan;

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2.0;      % LineWidth
msz = 8;       % MarkerSize
numContours = 7;
zmin = floor(min(PlotGridL100(:)));
zmax = ceil(max(PlotGridL100(:)));
zinc = (zmax - zmin) / numContours;
zlevs = zmin:zinc:zmax;
zlevsALT = [-.8 -.6 -.4 -.2 0 .2 .4 .6 .8];

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
%cmap = colormap(gray(numContours));
cmap = colormap(gray(length(zlevsALT)));
ncol = size(cmap,1);           
colormap(cmap); 

subplot(2,2,1);
contourf(Bxy_vec,Byx_vec,PlotGridL100,zlevs);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 100');

subplot(2,2,2);
contourf(Bxy_vec,Byx_vec,PlotGridL500,zlevs);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 500');

subplot(2,2,3);
contourf(Bxy_vec,Byx_vec,PlotGridL1000,zlevs);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 1000');

subplot(2,2,4);
contourf(Bxy_vec,Byx_vec,PlotGridL1500,zlevs);
xlim([0 0.48]);
ylim([0 0.48]);
caxis([-0.8 0.8]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('\beta_{yx}');
ylabel('\beta_{xy}');
title('L = 1500');

