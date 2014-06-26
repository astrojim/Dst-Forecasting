%{
load 'LinearEx_Out10x10grid/LinearEx_DataRead_Out10x10grid.mat';
AvOrig = Av;
BvOrig = Bv;
%}
load 'LinearEx_OutPAI/LinearEx_OutPAI_temp.mat';

%DiffYXXY = CdataYX-CdataXY;
DiffPrime = CdataYYX-CdataXXY;

%{
figure(1);
subplot(1,2,1);
colormap(gray);
imagesc(BvOrig,AvOrig,DiffYXXY);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YX}-C_{XY}');
%}

width = 4.5;
height = 2.5;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,DiffPrime);
hPnt1 = plot(Bv(27),Av(31),'ko','MarkerSize',4);
hPnt1 = plot(Bv(27),Av(27),'ko','MarkerSize',4);
set(gca,'YDir','normal');
axis([0 10 0 10]);
cbar = colorbar();

hXLabel = xlabel('B');
hYLabel = ylabel('A');
hCLabel = title(cbar,'\Delta\prime');

set([hXLabel, hYLabel, hCLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel, hCLabel],'FontSize', 9);

hold off;
print -depsc2 PlotOutTempDir/LinearExPAI.eps
close;

temp = DiffPrime;
temp(temp<0) = -1;
temp(temp>0) = 1;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,temp);
set(gca,'YDir','normal');
axis([0 10 0 10]);

hXLabel = xlabel('B');
hYLabel = ylabel('A');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 PlotOutTempDir/LinearExPAI3Color.eps
close;

