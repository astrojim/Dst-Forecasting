load ./NoCauseExampleData.mat

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt1 = plot(ytol,reshape(leansXY(1,:),1,length(ytol)),'k.','MarkerSize',15); 
hplt2 = plot(ytol,reshape(leansXY(2,:),1,length(ytol)),'ko','MarkerSize',15); 
% hplt3 = plot(ytol,reshape(leansXY(3,:),1,length(ytol)),'kx','MarkerSize',12); 
hplt4 = plot(ytol,reshape(leansXY(4,:),1,length(ytol)),'kx','MarkerSize',15); 
% hplt5 = plot(ytol,reshape(leansXY(5,:),1,length(ytol)),'k^','MarkerSize',12); 
% hplt6 = plot(ytol,reshape(leansXY(6,:),1,length(ytol)),'k<','MarkerSize',12); 
ylim([-0.3 0.2])

legend(sprintf('L = %i',liblength(1)),sprintf('L = %i',liblength(2)),sprintf('L = %i',liblength(4)),...
    'Location','northoutside','Orientation','horizontal');
legend('boxoff');

% grid on;

hXLabel = xlabel('\sigma_y');
hYLabel = ylabel('\lambda_1');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25);

set(gca,'fontsize',25);

hold off;
print -depsc2 ./NoCauseplot.eps
close;

