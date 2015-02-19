% B-dy plot
load ./RLcircuitexample_tolLagTmat.mat

LibL = 4;
data = reshape(leans_storedVI(LibL,:,:),length(lag),length(xytol));

% full color plot
figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(xytol,lag,data);
set(gca,'YDir','normal');
hold on;
 
[hCont2,hH2] = contour(xytol,lag,data,...
             [0.0 0.0],':r','LineWidth',2);
clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
         
% xlim([0 1]);
% ylim([0 1]);
% axis square;
% 
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\delta_y');
hYLabel = ylabel('lag');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

hSubtitle = title('');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./RLcircuitexample_matplot.eps
close;
% 
% % B = xytol plotting
% tempX = zeros(1,length(B));
% tempPnts = zeros(4,length(B));
% 
% for iter = 1:1:length(B),
%     tempX(1,iter) = B(iter);
%     tempPnts(1,iter) = leans_stored(iter,iter);
% end;
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% 
% hplt = plot(tempX,tempPnts(1,:),'k.','MarkerSize',5);
% grid on;
% 
% hXLabel = xlabel('B = \delta_y');
% hYLabel = ylabel('\lambda');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% % legend('L = 10','L = 50', 'L = 250', 'L = 1750');
% 
% % set(hSubtitle,'FontName','Times');
% % set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
% 
% hold off;
% print -depsc2 ./SimpleCyclicexample_Bxytol.eps
% close;
% 
% % lag stem plot
% load ./SimpleCyclicExample_lags.mat
% 
% templag = 15;
% tempxcors = nan(templag+1,1);
% tempaxcors = nan(templag+1,1);
% tempaycors = nan(templag+1,1);
% for iter = 0:1:templag,
%     tempxcors(iter+1,1) = corr(x(1,1:end-iter)',y(1,1+iter:end)');
%     tempaxcors(iter+1,1) = corr(x(1,1:end-iter)',x(1,1+iter:end)');
%     tempaycors(iter+1,1) = corr(y(1,1:end-iter)',y(1,1+iter:end)');
% end;
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% 
% hplt = stem(lag(1:15),leans_keep(1:15),'b','MarkerSize',5);
% 
% % hplt2 = stem(1:1:templag,tempaxcors(2:end),'r','MarkerSize',5);
% % hplt3 = stem(1:1:templag,tempaycors(2:end),'g','MarkerSize',5);
% 
% grid on;
% 
% hXLabel = xlabel('l (lag)');
% hYLabel = ylabel('magnitude (unitless)');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% % legend('\lambda','a_x','a_y')
% 
% % set(hSubtitle,'FontName','Times');
% % set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
% 
% hold off;
% print -depsc2 ./SimpleCyclicexample_difflags.eps
% close;
