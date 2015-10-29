load ./EmpiricalExamplesl20.mat

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(XY1(:,1),'k.','MarkerSize',15,'LineWidth',2);
% grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('$ [USD]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./EmpiricalData_p65X.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(XY1(:,2),'k.','MarkerSize',15,'LineWidth',2);
% grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('$ [USD]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./EmpiricalData_p65Y.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(SF(:,1),'k.','MarkerSize',15,'LineWidth',2);
% grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('temp [C]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./EmpiricalData_p87X.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(SF(:,2),'k.','MarkerSize',15,'LineWidth',2);
% grid on;

hXLabel = xlabel('t [days]');
hYLabel = ylabel('snowfall [cm]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./EmpiricalData_p87Y.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(1:1:21,Snowleans,'k.','MarkerSize',15,'LineWidth',2);
% grid on;
ylim([0.01 0.07])
xlim([0 22])

hXLabel = xlabel('l');
hYLabel = ylabel('\lambda^{xy}_l');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./EmpiricalData_p87leans.eps
close;