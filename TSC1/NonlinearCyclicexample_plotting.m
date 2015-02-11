% B-dy plot
load ./NonlinearCyclicExample_L181.mat

Ap = [2 floor(length(A)/3) floor(2*length(A)/3) length(A)];
Bp = [2 floor(length(B)/3) floor(2*length(B)/3) length(B)];

for Astep = 1:1:length(Ap),
    for Bstep = 1:1:length(Bp),
        
        data = reshape(leans_stored(Ap(Astep),Bp(Bstep),:,:),size(leans_stored,3),size(leans_stored,4));

        % full color plot
        figure('Units', 'inches', ...
        'Position', [0 0 8 4],...
        'PaperPositionMode','auto');

        hold on;
        cmap = colormap(flipud(gray(24)));

        hImage1 = imagesc(xytol,C,data);
        set(gca,'YDir','normal');
        hold on;

        [hCont2,hH2] = contour(xytol,C,data,...
                     [0.0 0.0],':r','LineWidth',2);
        % clabel(hCont2,hH2,'FontName','Times','FontSize', 15,'Color','r');         

        xlim([0 1]);
        ylim([0 1]);
        axis square;
        % 
        % caxis([-0.8 0.8]);
        cbar = colorbar();
        set(cbar,'Visible','on');

        hXLabel = xlabel('\delta_y');
        hYLabel = ylabel('C');

        set([hXLabel, hYLabel],'FontName','Times');
        set([hXLabel, hYLabel],'FontSize', 15);

        hSubtitle = title(sprintf('A = %.2f, B = %.2f',A(Ap(Astep)),B(Bp(Bstep))));
        set(hSubtitle,'FontName','Times');
        set(hSubtitle,'FontSize', 15);
        set(gca,'fontsize',15);

        hold off;
        print('-depsc2',sprintf('./NonlinearCyclicexample_Bdy_A%iB%i.eps',A(Ap(Astep))*100,B(Bp(Bstep))*100));
        close;
    end;
end;
%{
% B = xytol plotting
tempX = zeros(1,length(B));
tempPnts = zeros(4,length(B));

for iter = 1:1:length(B),
    tempX(1,iter) = B(iter);
    tempPnts(1,iter) = leans_stored(iter,iter);
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = plot(tempX,tempPnts(1,:),'k.','MarkerSize',5);
grid on;

hXLabel = xlabel('B = \delta_y');
hYLabel = ylabel('\lambda');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

% legend('L = 10','L = 50', 'L = 250', 'L = 1750');

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleCyclicexample_Bxytol.eps
close;

% lag stem plot
load ./SimpleCyclicExample_lags.mat

templag = 15;
tempxcors = nan(templag+1,1);
tempaxcors = nan(templag+1,1);
tempaycors = nan(templag+1,1);
for iter = 0:1:templag,
    tempxcors(iter+1,1) = corr(x(1,1:end-iter)',y(1,1+iter:end)');
    tempaxcors(iter+1,1) = corr(x(1,1:end-iter)',x(1,1+iter:end)');
    tempaycors(iter+1,1) = corr(y(1,1:end-iter)',y(1,1+iter:end)');
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;

hplt = stem(lag(1:15),leans_keep(1:15),'b','MarkerSize',5);

% hplt2 = stem(1:1:templag,tempaxcors(2:end),'r','MarkerSize',5);
% hplt3 = stem(1:1:templag,tempaycors(2:end),'g','MarkerSize',5);

grid on;

hXLabel = xlabel('l (lag)');
hYLabel = ylabel('magnitude (unitless)');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

% legend('\lambda','a_x','a_y')

% set(hSubtitle,'FontName','Times');
% set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleCyclicexample_difflags.eps
close;

% lagged cross cor plot
% figure('Units', 'inches', ...
% 'Position', [0 0 8 4],...
% 'PaperPositionMode','auto');
% 
% hold on;
% 
% hplt = stem(0:1:templag,tempxcors,'MarkerSize',5);
% grid on;
% 
% hXLabel = xlabel('l');
% hYLabel = ylabel('c');
% 
% set([hXLabel, hYLabel],'FontName','Times');
% set([hXLabel, hYLabel],'FontSize', 15);
% 
% % set(hSubtitle,'FontName','Times');
% % set(hSubtitle,'FontSize', 15);
% set(gca,'fontsize',15);
% 
% hold off;
% print -depsc2 ./SimpleCyclicexample_lagcorr.eps
% close;
%}