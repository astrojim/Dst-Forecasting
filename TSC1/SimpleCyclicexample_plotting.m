% B-dy plot
load ./SimpleCyclicExample_L41.mat

data = leans_stored;

% full color plot
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% cmap = colormap(flipud(gray(24)));
% 
% hImage1 = imagesc(xytol,B,data);
% set(gca,'YDir','normal');
% hold on;
%  
% [hCont2,hH2] = contour(xytol,B,data,...
%              [0.0 0.0],':r','LineWidth',2);
% % clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
%          
% xlim([0 1]);
% ylim([0 1]);
% axis square;
% % 
% % caxis([-0.8 0.8]);
% cbar = colorbar();
% set(cbar,'Visible','on');
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
% print -depsc2 ./SimpleCyclicexample_Bdy.eps
% close;

% B = xytol plotting
tempX = zeros(1,length(B));
tempPnts = zeros(4,length(B));

for iter = 1:1:length(B),
    tempX(1,iter) = B(iter);
    tempPnts(1,iter) = leans_stored(iter,iter);
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(tempX,tempPnts(1,:),'k.','MarkerSize',15);
% grid on;

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25);

% legend('L = 10','L = 50', 'L = 250', 'L = 1750');

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',25);
set(get(gca,'xlabel'),'position',[0.5 -0.2 0]);
set(gca,'position',[0.1300 0.1100 0.7750 0.8150] );
set(gca,'OuterPosition',[0 0.2 1 0.8])

hold off;
print -depsc2 ./SimpleCyclicexample_Bxytol.eps
close;

% lag stem plot
% load ./SimpleCyclicExample_lags.mat
load ./SimpleCyclicExample_lagsB05.mat

templag = 20;
tempxcors = nan(templag+1,1);
tempxcors2 = nan(templag+1,1);
tempaxcors = nan(templag+1,1);
tempaycors = nan(templag+1,1);
normleans = nan(templag,1);
diffxcors = nan(templag+1,1);
for iter = 0:1:templag,
    tempxcors(iter+1,1) = corr(x(1,1:end-iter)',y(1,1+iter:end)');
    tempxcors2(iter+1,1) = corr(y(1,1:end-iter)',x(1,1+iter:end)');
    diffxcors(iter+1,1) = tempxcors(iter+1,1) - tempxcors2(iter+1,1);
    tempaxcors(iter+1,1) = corr(x(1,1:end-iter)',x(1,1+iter:end)');
    tempaycors(iter+1,1) = corr(y(1,1:end-iter)',y(1,1+iter:end)');
end;

for iter = 1:1:templag,
    normleans(iter,1) = leans_keep(iter)/max(leans_keep(1:templag));
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(lag(1:templag),normleans,'.b','MarkerSize',15);
%hplt2 = plot(1:1:templag,tempxcors(2:end),'xr','MarkerSize',12);
hplt3 = plot(1:1:templag,diffxcors(2:end),'xr','MarkerSize',15);

% hplt2 = stem(1:1:templag,tempaxcors(2:end),'r','MarkerSize',5);
% hplt3 = stem(1:1:templag,tempaycors(2:end),'g','MarkerSize',5);

% grid on;

hXLabel = xlabel('l (lag)');
hYLabel = ylabel('magnitude (unitless)');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25);

legend('\lambda^\prime','\delta\chi_{xy}','Location','northoutside','Orientation','horizontal')
legend boxoff

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',25);

hold off;
print -depsc2 ./SimpleCyclicexample_difflags.eps
close;

% lagged cross cor plot
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% 
% hplt = stem(0:1:templag,tempxcors,'MarkerSize',5);
% grid on;
% 
% hXLabel = xlabel('l');
% hYLabel = ylabel('c');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% % set(hSubtitle,'FontName','Times');
% % set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
% 
% hold off;
% print -depsc2 ./SimpleCyclicexample_lagcorr.eps
% close;