
load 'LseriesBxy0.01Byx0.20/LseriesBxy0.01Byx0.20.mat';
CCMXY1 = LseriesPlot(1:185,1);
CCMYX1 = LseriesPlot(1:185,2);
load 'LseriesBxy0.20Byx0.10/LseriesBxy0.20Byx0.10.mat';
CCMXY2 = LseriesPlot(1:185,1);
CCMYX2 = LseriesPlot(1:185,2);
xlabel = library_length(1:185);

width = 3;     % Width in inches
height = 3;    % Height in inches

figure(1);
set(0,'DefaultAxesFontSize',12);
plot(xlabel,CCMYX1-CCMXY1,'ko','MarkerSize',12,'LineWidth',3);
grid on;
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca,'FontName','Arial','FontSize',12,'FontWeight','Bold'); %<- Set properties
xlabel('L');
ylabel('\Delta');
title('B_{xy} = 0.01, B_{yx} = 0.2');

figure(2);
set(0,'DefaultAxesFontSize',12);
plot(xlabel,CCMYX2-CCMXY2,'ko','MarkerSize',12,'LineWidth',3);
grid on;
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca,'FontName','Arial','FontSize',12,'FontWeight','Bold'); %<- Set properties
xlabel('L');
ylabel('\Delta');
title('B_{xy} = 0.2, B_{yx} = 0.1');