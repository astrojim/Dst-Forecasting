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
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% hSubtitle = title('\lambda_{XY}');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
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
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% hSubtitle = title('\lambda_{YZ}');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
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
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% hSubtitle = title('\lambda_{XZ}');
% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
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
            'MarkerSize',5);
grid on;

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

legend('XY','YZ', 'XZ');

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

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
            'MarkerSize',5);
grid on;

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

legend('XY','YZ', 'XZ');

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

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
            'MarkerSize',5);
grid on;

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

legend('XY','YZ', 'XZ');

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./XYZIRexample_BxytolZXandYandZ.eps
close;