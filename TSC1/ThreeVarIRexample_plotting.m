% mean plot
load ./IRXYZL500.mat

% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% cmap = colormap(flipud(gray(24)));
% 
% hImage1 = imagesc(xytol,B,leans_storedXY);
% set(gca,'YDir','normal');
% hold on;
%  
% [hCont2,hH2] = contour(xytol,B,leans_storedXY,...
%              [0.0 0.0],':r','LineWidth',2);
% % clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
%          
% xlim([0 1]);
% ylim([0 1]);
% axis square;
% % 
% % caxis([-0.8 0.8]);
% cbar = colorbar();
% set(cbar,'Visible','on');
% 
% hXLabel = xlabel('\delta_y');
% hYLabel = ylabel('B');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 25); 
% 
% hSubtitle = title('\lambda_{XY}');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 25); 
% set(gca,'FontSize', 25); 
% 
% hold off;
% print -depsc2 ./XYZIRexample_XY.eps
% close;
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% cmap = colormap(flipud(gray(24)));
% 
% hImage1 = imagesc(xytol,B,leans_storedYZ);
% set(gca,'YDir','normal');
% hold on;
%  
% [hCont2,hH2] = contour(xytol,B,leans_storedYZ,...
%              [0.0 0.0],':r','LineWidth',2);
% % clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
%          
% xlim([0 1]);
% ylim([0 1]);
% axis square;
% % 
% % caxis([-0.8 0.8]);
% cbar = colorbar();
% set(cbar,'Visible','on');
% 
% hXLabel = xlabel('\delta_y');
% hYLabel = ylabel('B');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 25); 
% 
% hSubtitle = title('\lambda_{YZ}');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 25); 
% set(gca,'FontSize', 25); 
% 
% hold off;
% print -depsc2 ./XYZIRexample_YZ.eps
% close;
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% 
% hold on;
% cmap = colormap(flipud(gray(24)));
% 
% hImage1 = imagesc(xytol,B,leans_storedXZ);
% set(gca,'YDir','normal');
% hold on;
%  
% [hCont2,hH2] = contour(xytol,B,leans_storedXZ,...
%              [0.0 0.0],':r','LineWidth',2);
% % clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
%          
% xlim([0 1]);
% ylim([0 1]);
% axis square;
% % 
% % caxis([-0.8 0.8]);
% cbar = colorbar();
% set(cbar,'Visible','on');
% 
% hXLabel = xlabel('\delta_y');
% hYLabel = ylabel('B');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 25); 
% 
% hSubtitle = title('\lambda_{XZ}');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 25); 
% set(gca,'FontSize', 25); 
% 
% hold off;
% print -depsc2 ./XYZIRexample_XZ.eps
% close;


% B = xytol plotting
tempX = zeros(1,length(B));
tempPnts = zeros(3,length(B));

for iter = 1:1:length(B),
    tempX(1,iter) = B(iter);
    tempPnts(1,iter) = leans_storedXY(iter,iter);
    tempPnts(2,iter) = leans_storedYZ(iter,iter);
    tempPnts(3,iter) = leans_storedXZ(iter,iter);
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(tempX,tempPnts(1,:),'k.',tempX,tempPnts(2,:),'kx',...
            tempX,tempPnts(3,:),'ko',...
            'MarkerSize',15);
% grid on;
ylim([-0.1 1.1]);

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

legend('XY','YZ', 'XZ','Location','northoutside','Orientation','horizontal')
legend boxoff

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 25); 
set(gca,'FontSize', 25);
set(get(gca,'xlabel'),'position',[0.5 -0.65 0]);
set(gca,'position',[0.1300 0.1100 0.7750 0.8150] );
set(gca,'OuterPosition',[0 0.2 1 0.6])

hold off;
print -depsc2 ./XYZIRexample_Bxytol.eps
close;

clear all;
load ./IRXYZL500ZXandY.mat
tempX = zeros(1,length(B));
tempPnts = zeros(3,length(B));

for iter = 1:1:length(B),
    tempX(1,iter) = B(iter);
    tempPnts(1,iter) = leans_storedXY(iter,iter);
    tempPnts(2,iter) = leans_storedYZ(iter,iter);
    tempPnts(3,iter) = leans_storedXZ(iter,iter);
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(tempX,tempPnts(1,:),'k.',tempX,tempPnts(2,:),'kx',...
            tempX,tempPnts(3,:),'ko',...
            'MarkerSize',15);
% grid on;
ylim([0 1.1]);

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

% legend('XY','YZ', 'XZ');
% 
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 25); 
set(gca,'FontSize', 25);
set(get(gca,'xlabel'),'position',[0.5 -0.25 0]);
set(gca,'position',[0.1300 0.1100 0.7750 0.8150] );
set(gca,'OuterPosition',[0 0.2 1 0.8])

hold off;
print -depsc2 ./XYZIRexample_BxytolZXandY.eps
close;

clear all;
load ./IRXYZL500ZXandYandZ.mat
tempX = zeros(1,length(B));
tempPnts = zeros(3,length(B));

for iter = 1:1:length(B),
    tempX(1,iter) = B(iter);
    tempPnts(1,iter) = leans_storedXY(iter,iter);
    tempPnts(2,iter) = leans_storedYZ(iter,iter);
    tempPnts(3,iter) = leans_storedXZ(iter,iter);
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(tempX,tempPnts(1,:),'k.',tempX,tempPnts(2,:),'kx',...
            tempX,tempPnts(3,:),'ko',...
            'MarkerSize',15);
% grid on;
ylim([-0.5 1.2]);

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

% legend('XY','YZ', 'XZ','Location','northoutside','Orientation','horizontal')
% legend boxoff

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 25); 
set(gca,'FontSize', 25);
set(get(gca,'xlabel'),'position',[0.5 -1.0 0]);
set(gca,'position',[0.1300 0.1100 0.7750 0.8150] );
set(gca,'OuterPosition',[0 0.2 1 0.6])

hold off;
print -depsc2 ./XYZIRexample_BxytolZXandYandZ.eps
close;