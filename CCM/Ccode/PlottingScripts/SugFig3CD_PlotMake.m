load SugFig3CD_DataRead.mat;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');
set(0,'DefaultTextInterpreter','latex');

hold on;

subplot(1,2,1);
hPnt = plot(X(2:end),Cdata_XgY,'k.','MarkerSize',6);
axis([0 1 0 1]);
axis square;
hXLabel = xlabel('$X$');
hYLabel = ylabel('$X|\tilde{\mathbf{Y}}$');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(a)');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

subplot(1,2,2);
hPnt = plot(Y(2:end),Cdata_YgX,'k.','MarkerSize',6);
axis([0 1 0 1]);
axis square;

hXLabel = xlabel('$Y$');
hYLabel = ylabel('$Y|\tilde{\mathbf{X}}$');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(b)');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/SugFig3CD.eps
close;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');
set(0,'DefaultTextInterpreter','latex');

hold on;

subplot(1,2,1);
hPnt = plot(X(2:end),Cdata_XgX,'k.','MarkerSize',6);
axis([0 1 0 1]);
axis square;

hXLabel = xlabel('$X$');
hYLabel = ylabel('$X|\tilde{\mathbf{X}}$');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(a)');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

subplot(1,2,2);
hPnt = plot(X(2:end),Cdata_XgXY,'k.','MarkerSize',6);
axis([0 1 0 1]);
axis square;

hXLabel = xlabel('$X$');
hYLabel = ylabel('$X|(XY)$');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(b)');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/SugFig3CD_AddPlotAB.eps
close;


width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');
set(0,'DefaultTextInterpreter','latex');

hold on;

subplot(1,2,1);
hPnt = plot(Y(2:end),Cdata_YgY,'k.','MarkerSize',6);
axis([0 1 0 1]);
axis square;

hXLabel = xlabel('$Y$');
hYLabel = ylabel('$Y|\tilde{\mathbf{Y}}$');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(c)');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

subplot(1,2,2);
hPnt = plot(Y(2:end),Cdata_YgYX,'k.','MarkerSize',6);
axis([0 1 0 1]);
axis square;

hXLabel = xlabel('$Y$');
hYLabel = ylabel('$Y|(YX)$');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title('(d)');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 10);

hold off;
print -depsc2 ../PlotOutTempDir/SugFig3CD_AddPlotCD.eps
close;

