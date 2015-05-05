load ./SolarDataExample_Samp500.mat

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hist(leansBxDstSamp,100);
mu = nanmean(leansBxDstSamp);
plot([mu,mu],ylim,'r--','LineWidth',3)
grid on;

hXLabel = xlabel('\lambda^1_x');
hYLabel = ylabel('counts');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./SolarDataBxDst.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hist(leansByDstSamp,100);
mu = nanmean(leansByDstSamp);
plot([mu,mu],ylim,'r--','LineWidth',3)
grid on;

hXLabel = xlabel('\lambda^1_y');
hYLabel = ylabel('counts');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./SolarDataByDst.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hist(leansBzDstSamp,100);
mu = nanmean(leansBzDstSamp);
plot([mu,mu],ylim,'r--','LineWidth',3)
grid on;

hXLabel = xlabel('\lambda^1_z');
hYLabel = ylabel('counts');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./SolarDataBzDst.eps
close;