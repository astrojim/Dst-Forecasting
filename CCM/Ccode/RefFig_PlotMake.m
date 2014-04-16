
load 'LseriesBxy0.01Byx0.20/LseriesBxy0.01Byx0.20.mat';
CCMXY1 = LseriesPlot(:,1);
CCMYX1 = LseriesPlot(:,2);
%load 'LseriesBxy0.20Byx0.10/LseriesBxy0.20Byx0.10.mat';
%CCMXY2 = LseriesPlot(:,1);
%CCMYX2 = LseriesPlot(:,2);

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2.0;      % LineWidth
msz = 8;       % MarkerSize

figure(1);
plot(library_length,CCMXY1,'.',library_length,CCMYX1,'o',library_length,CCMYX1-CCMXY1,'x');
%plot(library_length,CCMYX1-CCMXY1,'x');
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
xlabel('L');
ylabel('\Delta');
title('B_{xy} = 0.01, B_{yx} = 0.2');
%legend('CCM(X,Y)','CCM(Y,X)','\Delta');
%{
subplot(1,2,2);
%plot(10:10:(1960),CCMXY2,'.',10:10:(1960),CCMYX2,'o',10:10:(1960),CCMYX2-CCMXY2,'x');
plot(10:10:(1960),CCMYX2-CCMXY2,'x');
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
xlabel('L');
ylabel('\Delta');
title('B_{xy} = 0.2, B_{yx} = 0.1');
%legend('CCM(X,Y)','CCM(Y,X)','\Delta');
%}