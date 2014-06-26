load 'NonLinearEx_Out/NonLinearEx_DataRead_OutTemp.mat';

DiffYXXY = CdataYX-CdataXY;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;


subplot(2,2,1);
Cstep = 2;
cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,DiffYXXY(:,:,Cstep));
set(gca,'YDir','normal');
hold on;
hCont = contour(Bv,Av,DiffYXXY(:,:,Cstep),...
          [0 0],'r','LineWidth',2);

caxis([-0.1 0.6]);


hXLabel = xlabel('B');
hYLabel = ylabel('A');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title(sprintf('C = %.2f;',Cv(Cstep)));

for iter = 2:4,
    subplot(2,2,iter);
    Cstep = Cstep + 3;
    
    cmap = colormap(flipud(gray));
    hImage = imagesc(Bv,Av,DiffYXXY(:,:,Cstep));
    set(gca,'YDir','normal');
    hold on;
    
    hCont = contour(Bv,Av,DiffYXXY(:,:,Cstep),...
              [0 0],'r','LineWidth',2);
    
    if(iter ==2), 
        cbar = colorbar(); 
        hCLabel = title(cbar,'\Delta');
    end;
    caxis([-0.1 0.6]);
    hXLabel = xlabel('B');
    hYLabel = ylabel('A');

    hSubtitle = title(sprintf('C = %.2f;',Cv(Cstep)));
end;

hold off;
print -depsc2 PlotOutTempDir/NonLinearEx.eps
close;
