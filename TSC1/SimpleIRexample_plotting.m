load ./SimpleRIExample_50000samp.mat

data = leans_nmean;

% full color plot
figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(xytol,B,data);
set(gca,'YDir','normal');
hold on;
 
[hCont2,hH2] = contour(xytol,B,data,...
             [0.0 0.0],':r','LineWidth',2);
% clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
         
xlim([0 1]);
ylim([0 1]);
axis square;
% 
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\delta_y');
hYLabel = ylabel('B');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

hSubtitle = title('');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_plot.eps
close;

% % 3color plot
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% cmap = colormap(flipud(gray(3)));
% 
% hImage1 = imagesc(xytol,B,tcolorp);
% set(gca,'YDir','normal');
% hold on;
% 
% xlim([0 1]);
% ylim([0 1]);
% axis square;
% cbar = colorbar();
% set(cbar,'Visible','off');
% 
% hXLabel = xlabel('\delta_y');
% hYLabel = ylabel('B');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% hSubtitle = title('');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
% 
% hold off;
% print -depsc2 ./SimpleIRexample_plot3C.eps
% close;
