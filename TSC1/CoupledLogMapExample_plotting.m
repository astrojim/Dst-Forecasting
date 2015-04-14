width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

load ./CoupledLogMapExampleL500rx35ry35.mat
hImage1 = imagesc(Bxy_vec,Byx_vec,leans_stored);
set(gca,'YDir','normal');
hold on;
% hCont2 = contour(Bxy_vec,Byx_vec,leans_stored,...
%             [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\beta_{xy}');
hYLabel = ylabel('\beta_{yx}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./CoupLogexample_rx35ry35.eps
close;

clear all

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

load ./CoupledLogMapExampleL500rx40ry20.mat
hImage1 = imagesc(Bxy_vec,Byx_vec,leans_stored);
set(gca,'YDir','normal');
hold on;
% hCont2 = contour(Bxy_vec,Byx_vec,leans_stored,...
%             [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\beta_{xy}');
hYLabel = ylabel('\beta_{yx}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./CoupLogexample_rx40ry20.eps
close;

clear all

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

load ./CoupledLogMapExampleL500rx20ry40.mat
hImage1 = imagesc(Bxy_vec,Byx_vec,leans_stored);
set(gca,'YDir','normal');
hold on;
% hCont2 = contour(Bxy_vec,Byx_vec,leans_stored,...
%             [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\beta_{xy}');
hYLabel = ylabel('\beta_{yx}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./CoupLogexample_rx20ry40.eps
close;

clear all

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

numColors = 16;
cmap = colormap(flipud(gray(numColors)));

load ./CoupledLogMapExampleL500rx38ry32.mat
hImage1 = imagesc(Bxy_vec,Byx_vec,leans_stored);
set(gca,'YDir','normal');
hold on;
% hCont2 = contour(Bxy_vec,Byx_vec,leans_stored,...
%             [0.00 0.00],'w','LineWidth',2);
xlim([0 0.48]);
ylim([0 0.48]);
axis square;
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\beta_{xy}');
hYLabel = ylabel('\beta_{yx}');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./CoupLogexample_rx38ry32.eps
close;