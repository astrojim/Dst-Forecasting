load 'NonLinearPAIEx_Out/NonLinearPAIEx_DataRead_OutTemp.mat';

DiffYXXYYYX = CdataYYX-CdataXXY;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;


subplot(2,2,1);
Cstep = 2;
cmap = colormap(flipud(gray));
hImage = imagesc(Bv,Av,DiffYXXYYYX(:,:,Cstep));
set(gca,'YDir','normal');
hold on;
hCont = contour(Bv,Av,DiffYXXYYYX(:,:,Cstep),...
          [0 0],'r','LineWidth',2);

caxis([-0.01 -0.001]);


hXLabel = xlabel('B');
hYLabel = ylabel('A');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hSubtitle = title(sprintf('C = %.2f;',Cv(Cstep)));

for iter = 2:4,
    subplot(2,2,iter);
    Cstep = Cstep + 3;
    
    cmap = colormap(flipud(gray));
    hImage = imagesc(Bv,Av,DiffYXXYYYX(:,:,Cstep));
    set(gca,'YDir','normal');
    hold on;
    
    hCont = contour(Bv,Av,DiffYXXYYYX(:,:,Cstep),...
              [0 0],'r','LineWidth',2);
    
    if(iter ==2), 
        cbar = colorbar(); 
        hCLabel = title(cbar,'\Delta^\prime');
    end;
    caxis([-0.01 -0.001]);
    hXLabel = xlabel('B');
    hYLabel = ylabel('A');

    hSubtitle = title(sprintf('C = %.2f;',Cv(Cstep)));
end;

hold off;
print -depsc2 PlotOutTempDir/NonLinearPAIEx.eps
close;



%{
figure(1);
subplot(3,3,1);
Cstep = 2;
colormap(gray);
imagesc(Bv,Av,DiffYXXYYYX(:,:,Cstep));
set(gca,'YDir','normal');
hold on;
contour(Bv,Av,DiffYXXYYYX(:,:,Cstep),...
          [0 0],'r','LineWidth',2);
hold off;
cbar = colorbar();
%caxis([-0.1 0.1]);
title(cbar,'\Delta = C_{YX}-C_{XY}');
xlabel('B');
ylabel('A');
title(sprintf('C = %.2f;',Cv(Cstep)));

for iter = 2:9,
    subplot(3,3,iter);
    Cstep = Cstep + 1;
    colormap(gray);
    imagesc(Bv,Av,DiffYXXYYYX(:,:,Cstep));
    set(gca,'YDir','normal');
    hold on;
    contour(Bv,Av,DiffYXXYYYX(:,:,Cstep),...
              [0 0],'r','LineWidth',2);
    hold off;
    cbar = colorbar();
    %caxis([-0.1 0.6]);
    xlabel('B');
    ylabel('A');
    title(sprintf('C = %.2f;',Cv(Cstep)));
end;
%}