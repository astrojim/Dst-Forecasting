load ./EmpiricalExamplesl20.mat

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(XY1(:,1),'b.','MarkerSize',12,'LineWidth',2);
grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('$ [USD]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./EmpiricalData_p65X.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(XY1(:,2),'r.','MarkerSize',12,'LineWidth',2);
grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('$ [USD]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./EmpiricalData_p65Y.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(SF(:,1),'b.','MarkerSize',12,'LineWidth',2);
grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('temp [C]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./EmpiricalData_p87X.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(SF(:,2),'r.','MarkerSize',12,'LineWidth',2);
grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('snowfall [cm]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

set(gca,'fontsize',15);

hold off;
print -depsc2 ./EmpiricalData_p87Y.eps
close;