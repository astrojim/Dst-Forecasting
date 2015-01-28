% mean plot
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

% different library length plot
clear all
load ./SimpleRIExample_Ldiff.mat

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(xytol,B,leans_stored10);
set(gca,'YDir','normal');
hold on;
 
[hCont2,hH2] = contour(xytol,B,leans_stored10,...
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

hSubtitle = title('L = 10');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_diffLpart1.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(xytol,B,leans_stored50);
set(gca,'YDir','normal');
hold on;
 
[hCont2,hH2] = contour(xytol,B,leans_stored50,...
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

hSubtitle = title('L = 50');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_diffLpart2.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');


hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(xytol,B,leans_stored250);
set(gca,'YDir','normal');
hold on;
 
[hCont2,hH2] = contour(xytol,B,leans_stored250,...
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

hSubtitle = title('L = 250');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_diffLpart3.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(xytol,B,leans_stored1750);
set(gca,'YDir','normal');
hold on;
 
[hCont2,hH2] = contour(xytol,B,leans_stored1750,...
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

hSubtitle = title('L = 1750');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_diffLpart4.eps
close;

% B = xytol plotting
tempX = zeros(1,length(B));
tempPnts = zeros(4,length(B));

for iter = 1:1:length(B),
    tempX(1,iter) = B(iter);
    tempPnts(1,iter) = leans_stored10(iter,iter);
    tempPnts(2,iter) = leans_stored50(iter,iter);
    tempPnts(3,iter) = leans_stored250(iter,iter);
    tempPnts(4,iter) = leans_stored1750(iter,iter);
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(tempX,tempPnts(1,:),'k.',tempX,tempPnts(2,:),'kx',...
            tempX,tempPnts(3,:),'ko',tempX,tempPnts(4,:),'kv',...
            'MarkerSize',5);
grid on;

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

legend('L = 10','L = 50', 'L = 250', 'L = 1750');

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_Bxytol.eps
close;

% lag stem plot
load ./SimpleRIExample_lags.mat

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = stem(lag,leans_keep,'MarkerSize',5);
grid on;

hXLabel = xlabel('l');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_difflags.eps
close;