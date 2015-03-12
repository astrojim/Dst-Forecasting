% B-dy plot
load ./SimpleRIExample_L10000_longTol.mat

temp_an = reshape(leans_storedVI_an(1,:,1,1,:,1),length(Ttstep),length(ytol));
temp_ode45 = reshape(leans_storedVI_ode45(1,:,1,1,:,1),length(Ttstep),length(ytol));

data = temp_an;

% full color plot
figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(0,0,data(4:end,:));
set(gca,'YDir','normal');
set(gca,'XTickLabel',arrayfun(@num2str,ytol,'UniformOutput',false));
set(gca,'YTickLabel',{'\pi/10','\pi/50','\pi/10^2','\pi/10^3','\pi/10^4'});
hold on;
 
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\delta_y');
hYLabel = ylabel('\Delta t');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

hSubtitle = title('');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./RLcircuitexample_tStep.eps
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
