%These data sets calculated each point as CCM(X,Y)-CCM(Y,X), but Sugihara
%et al. plot CCM(Y,X)-CCM(X,Y).  Rather than recreate the data sets (which,
%admittedly, would not be too difficult), everything is just multiplied
%through by -1
load 'Lseries_temp.mat';
CCMXY = LseriesPlot(1:(end-6),1);
CCMYX = LseriesPlot(1:(end-6),2);

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.75;    % AxesLineWidth
fsz = 12;      % Fontsize
lw = 2.0;      % LineWidth
msz = 8;       % MarkerSize

figure(1);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties
xlabel('L');
ylabel('CCM Correlation');
title('B_{xy} = 0.01, B_{yx} = 0.2');
plot(10:10:(1900),CCMXY,'.',10:10:(1900),CCMYX,'o',10:10:(1900),CCMXY-CCMYX,'x');
legend('CCM(X,Y)','CCM(Y,X)','\Delta');

