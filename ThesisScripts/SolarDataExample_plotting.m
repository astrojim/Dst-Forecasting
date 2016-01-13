
% set start and stop times for daily average subsets
SubSetstart = 298057; %01-Jan-1997 00:30:00
SubSetstop = 341880; %31-Dec-2001 23:30:00

% load Bz and Dst and time steps
[bz,bzr,dst,tau] = SolarDataSets(SubSetstart,SubSetstop);

% set times for plotting
elapsedhours = (tau.hourly - tau.hourly(1)).*24;
elapseddays= (tau.dailysubset(1,:) - tau.dailysubset(1,1));

%% plot Dst 
width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(elapsedhours,dst.hourly,'k.','MarkerSize',15);
xlabel('t [hours since 01-Jan-1963 00:30:00 UTC]','FontName','Times','FontSize', 15);
ylabel('D_{st}','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Dhourly.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(elapseddays,dst.dailysubset,'k.','MarkerSize',15);
xlabel('t [days since 01-Jan-1997]','FontName','Times','FontSize', 15);
ylabel('D_{st}','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Ddaily.eps
close;

%% plot Bz 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(elapsedhours,bz.hourly,'k.','MarkerSize',15);
xlabel('t [hours since 01-Jan-1963 00:30:00 UTC]','FontName','Times','FontSize', 15);
ylabel('B_z [nT]','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzhourly.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(elapseddays,bz.dailysubset,'k.','MarkerSize',15);
xlabel('t [days since 01-Jan-1997]','FontName','Times','FontSize', 15);
ylabel('B_z [nT]','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzdaily.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(elapsedhours,bzr.hourly,'k.','MarkerSize',15);
xlabel('t [hours since 01-Jan-1963 00:30:00 UTC]','FontName','Times','FontSize', 15);
ylabel('B_z^\prime [nT]','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzhourlyrec.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(elapseddays,bzr.dailysubset,'k.','MarkerSize',15);
xlabel('t [days since 01-Jan-1997]','FontName','Times','FontSize', 15);
ylabel('B_z^\prime [nT]','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzdailyrec.eps
close;

%% histogram Dst 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(dst.hourly,1000);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('D_{st} bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Dhourlyhist.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(dst.dailysubset,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('D_{st} bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Ddailyhist.eps
close;

%% histogram Bz
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(bz.hourly,1000);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('B_z bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzhourlyhist.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(bz.dailysubset,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('B_z bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzdailyhist.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(bzr.hourly,1000);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('B_z^\prime bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzhourlyrechist.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(bzr.dailysubset,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('B_z^\prime bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./SolarExample_Bzdailyrechist.eps
close;

%% Autocorrelation X and Y

lags = 1:1:100;
autocorrD = nan(length(lags),1);
autocorrBz = nan(length(lags),1);

for liter = 1:1:length(lags),
    autocorrD(liter,1) = abs(corr(dst.dailysubset((lags(liter)+1):end),dst.dailysubset(1:(end-lags(liter)))))^2;
    autocorrBz(liter,1) = abs(nancorr(bz.dailysubset((lags(liter)+1):end),bz.dailysubset(1:(end-lags(liter)))))^2;
end;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrD,'k.','MarkerSize',15);
ylabel('|r(D_{t-l},D_t)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./SolarExample_autocorrDdaily.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrBz,'k.','MarkerSize',15);
ylabel('|r(B_{t-l},B_t)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./SolarExample_autocorrBzdaily.eps
close;

%% Leaning and LCC

% addpath('leans_exec');
LCClags = 1:1:30;
Dtol = (max(dst.dailysubset)-min(dst.dailysubset))/4;
Bztol = (max(bz.dailysubset)-min(bz.dailysubset))/4;
Bzrtol = (max(bzr.dailysubset)-min(bzr.dailysubset))/4;
% leanings = nan(length(LCClags),1);
% for lag_iter = 1:1:length(LCClags),
%     leantemp = leans_lagged(x,y,xtol,ytol,LCClags(lag_iter));
%     leanings(lag_iter,1) = leantemp(1,2);
% end;
% laggedcorrsXY = nan(length(LCClags),1);
% laggedcorrsYX = nan(length(LCClags),1);
% for clag_iter = 1:1:length(LCClags),
%     laggedcorrsXY(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',y(1:(end-LCClags(clag_iter)))');
%     laggedcorrsYX(clag_iter,1) = corr(y((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
% end;
% Deltal = abs(laggedcorrsXY)-abs(laggedcorrsYX);
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 width height],...
% 'PaperPositionMode','auto');
% 
% hold on;
% 
% plot(LCClags,leanings,'k.',LCClags,Deltal,'ko','MarkerSize',15);
% % ylabel('','FontName','Times','FontSize', 15);
% xlabel('l','FontName','Times','FontSize', 15);
% legend('\langle \lambda_l \rangle','\Delta_l');
% grid on;
% set(gca,'fontsize',15);
% % ylim([-2 3.5]);
% 
% hold off;
% print -depsc2 ./SolarExample_LandLCC.eps
% close;

%% GC, TE, and PAI results (no print to terminal, no plots)

y = dst.dailysubset';
x = bz.dailysubset';
[TE_dbz,GC_dbz,PAI_dbz,L_dbz,LCC_dbz,g_dbz] = ECA(x,y,Bztol,Dtol,LCClags,100,1,true,false);

xr = bzr.dailysubset';
[TE_dbzr,GC_dbzr,PAI_dbzr,L_dbzr,LCC_dbzr,g_dbzr] = ECA(xr,y,Bzrtol,Dtol,LCClags,100,1,true,false);
