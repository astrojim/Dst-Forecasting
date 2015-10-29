% B-dy plot
load ./NonlinearCyclicExample_L181.mat

% Ap = [floor(length(A)/4) floor(2*length(A)/4) floor(3*length(A)/4) length(A)];
% Bp = [floor(length(B)/4) floor(2*length(B)/4) floor(3*length(B)/4) length(B)];
% 
% for Astep = 1:1:length(Ap),
%     for Bstep = 1:1:length(Bp),
%         
%         data = reshape(leans_stored(Ap(Astep),Bp(Bstep),:,:),size(leans_stored,3),size(leans_stored,4));
% 
%         % full color plot
%         figure('Units', 'inches', ...
%         'Position', [0 0 8 4],...
%         'PaperPositionMode','auto');
% 
%         hold on;
%         cmap = colormap(flipud(gray(24)));
% 
%         hImage1 = imagesc(xytol,C,data);
%         set(gca,'YDir','normal');
%         hold on;
% 
%         [hCont2,hH2] = contour(xytol,C,data,...
%                      [0.0 0.0],':r','LineWidth',2);
%         % clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         
% 
%         xlim([0 1]);
%         ylim([0 1]);
%         axis square;
%         % 
%         % caxis([-0.8 0.8]);
%         cbar = colorbar();
%         set(cbar,'Visible','on');
% 
%         hXLabel = xlabel('\delta_y');
%         hYLabel = ylabel('C');
% 
%         set([hXLabel, hYLabel],'FontName','Times');
%         set([hXLabel, hYLabel],'FontSize', 25); 
% 
%         hSubtitle = title(sprintf('A = %.2f, B = %.2f',A(Ap(Astep)),B(Bp(Bstep))));
%         set(hSubtitle,'FontName','Times');
%         set(hSubtitle,'FontSize', 25); 
%         set(gca,'FontSize', 25); 
% 
%         hold off;
%         print('-depsc2',sprintf('./NonlinearCyclicexample_Bdy_A%iB%i.eps',A(Ap(Astep))*100,B(Bp(Bstep))*100));
%         close;
%     end;
% end;

% B = xytol plotting
tempPnts = zeros(length(A),length(B));
testpnt = 2;

for iterA = 1:1:length(A),
    for iterB = 1:1:length(B),
        tempPnts(iterA,iterB) = leans_stored(iterA,iterB,testpnt,testpnt);
    end;
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(A,B,tempPnts);
set(gca,'YDir','normal');
hold on;

[hCont2,hH2] = contour(A,B,tempPnts,...
             [0.0 0.0],':r','LineWidth',2);
     
xlim([0 1]);
ylim([0 1]);
axis square;

cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('B');
hYLabel = ylabel('A');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./NonlinearCyclicexample_BxytolC02.eps
close;

testpnt = 3;

for iterA = 1:1:length(A),
    for iterB = 1:1:length(B),
        tempPnts(iterA,iterB) = leans_stored(iterA,iterB,testpnt,testpnt);
    end;
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(A,B,tempPnts);
set(gca,'YDir','normal');
hold on;

[hCont2,hH2] = contour(A,B,tempPnts,...
             [0.0 0.0],':r','LineWidth',2);
     
xlim([0 1]);
ylim([0 1]);
axis square;

cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('B');
hYLabel = ylabel('A');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./NonlinearCyclicexample_BxytolC04.eps
close;

testpnt = 4;

for iterA = 1:1:length(A),
    for iterB = 1:1:length(B),
        tempPnts(iterA,iterB) = leans_stored(iterA,iterB,testpnt,testpnt);
    end;
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(A,B,tempPnts);
set(gca,'YDir','normal');
hold on;

[hCont2,hH2] = contour(A,B,tempPnts,...
             [0.0 0.0],':r','LineWidth',2);
     
xlim([0 1]);
ylim([0 1]);
axis square;

cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('B');
hYLabel = ylabel('A');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./NonlinearCyclicexample_BxytolC06.eps
close;

testpnt = 5;

for iterA = 1:1:length(A),
    for iterB = 1:1:length(B),
        tempPnts(iterA,iterB) = leans_stored(iterA,iterB,testpnt,testpnt);
    end;
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(24)));

hImage1 = imagesc(A,B,tempPnts);
set(gca,'YDir','normal');
hold on;

[hCont2,hH2] = contour(A,B,tempPnts,...
             [0.0 0.0],':r','LineWidth',2);
     
xlim([0 1]);
ylim([0 1]);
axis square;

cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('B');
hYLabel = ylabel('A');
set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 25); 

set(gca,'FontSize', 25); 

hold off;
print -depsc2 ./NonlinearCyclicexample_BxytolC08.eps
close;

% lag stem plot
% load ./NonlinearCyclicExample_lags.mat
% testpnt1 = floor(length(A)/3);
% testpnt2 = floor(2*length(A)/3);
% testpnt3 = floor(3*length(A)/3);
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% 
% hplt = stem(lag(1:50),reshape(leans_keep(testpnt1,testpnt1,1:50),size(lag)),'b','MarkerSize',5);
% hplt1 = stem(lag(1:50),reshape(leans_keep(testpnt2,testpnt2,1:50),size(lag)),'r','MarkerSize',5);
% hplt2 = stem(lag(1:50),reshape(leans_keep(testpnt3,testpnt3,1:50),size(lag)),'k','MarkerSize',5);
% 
% grid on;
% 
% hXLabel = xlabel('l (lag)');
% hYLabel = ylabel('magnitude (unitless)');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 25); 
% 
% legend('\lambda_1','\lambda_2','\lambda_3')
% set(gca,'FontSize', 25); 
% 
% hold off;
% print -depsc2 ./NonlinearCyclicexample_difflags.eps
% close;
