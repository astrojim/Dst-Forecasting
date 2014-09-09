load SugFig3CD_DataRead.mat;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

subplot(1,2,1);
hPnt = plot(X(2:end),Cdata_XgY,'kx','MarkerSize',5);
hXLabel = xlabel('X');
hYLabel = ylabel('X|Y');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(a)');

subplot(1,2,2);
hPnt = plot(Y(2:end),Cdata_YgX,'kx','MarkerSize',5);
hXLabel = xlabel('Y');
hYLabel = ylabel('Y|X');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(b)');

hold off;
%print -depsc2 PlotOutTempDir/SugFig3CD.eps
%close;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

subplot(2,2,1);
hPnt = plot(X(2:end),Cdata_XgX,'kx','MarkerSize',5);
hXLabel = xlabel('X');
hYLabel = ylabel('X|X');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(a)');

subplot(2,2,2);
hPnt = plot(X(2:end),Cdata_XgXY,'kx','MarkerSize',5);
hXLabel = xlabel('X');
hYLabel = ylabel('X|(XY)');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(b)');

subplot(2,2,3);
hPnt = plot(Y(2:end),Cdata_YgY,'kx','MarkerSize',5);
hXLabel = xlabel('Y');
hYLabel = ylabel('Y|Y');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(c)');

subplot(2,2,4);
hPnt = plot(Y(2:end),Cdata_YgYX,'kx','MarkerSize',5);
hXLabel = xlabel('Y');
hYLabel = ylabel('Y|(YX)');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(d)');
hold off;
%print -depsc2 PlotOutTempDir/SugFig3CD_AddPlot.eps
%close;

