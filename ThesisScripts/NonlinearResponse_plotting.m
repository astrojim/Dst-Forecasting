
% Set B and C for the plots
A = 0.1;
B = 0.3;
C = 0.4;
D = 0.5;

% set signal length
liblength = 6*pi;

% set ampltide
a = 1;

% set frequency
b = 1;

% set phase 
c = 1;

% set stepsize
unit_step = (1/30)*pi;

% build X and Y
[x,y] = NonlinearResponse(liblength,unit_step,a,b,c,A,B,C,D);

% set liblength for plotting
liblength = length(x);

%% plot X 
width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(1:1:liblength,x,'k.','MarkerSize',15);
xlabel('t','FontName','Times','FontSize', 15);
ylabel('x_t','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
ylim([-2.5 2.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_X.eps
close;

%% plot Y 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(1:1:liblength,y,'k.','MarkerSize',15);
xlabel('t','FontName','Times','FontSize', 15);
ylabel('y_t','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
ylim([-2.5 2.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_Y.eps
close;

%% histogram X 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(x,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('x_t bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-1 2.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_Xhist.eps
close;

%% histogram Y 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(y,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('y_t bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_Yhist.eps
close;

%% Autocorrelation X and Y

lags = 1:1:50;
autocorrX = nan(length(lags),1);
autocorrY = nan(length(lags),1);

for liter = 1:1:length(lags),
    autocorrX(liter,1) = abs(corr(x((lags(liter)+1):end)',x(1:(end-lags(liter)))'))^2;
    autocorrY(liter,1) = abs(corr(y((lags(liter)+1):end)',y(1:(end-lags(liter)))'))^2;
end;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrX,'k.','MarkerSize',15);
ylabel('|r(x_{t-l},x_t)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_autocorrX.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrY,'k.','MarkerSize',15);
ylabel('|r(y_{t-l},y_t)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_autocorrY.eps
close;

%% Leaning and LCC

addpath('leans_exec');
LCClags = 1:1:15;
xtol = (max(x)-min(x))/4;
ytol = (max(y)-min(y))/4;
leanings = nan(length(LCClags),1);
for lag_iter = 1:1:length(LCClags),
    leantemp = leans_lagged(x,y,xtol,ytol,LCClags(lag_iter));
    leanings(lag_iter,1) = leantemp(1,2);
end;
laggedcorrsXY = nan(length(LCClags),1);
laggedcorrsYX = nan(length(LCClags),1);
for clag_iter = 1:1:length(LCClags),
    laggedcorrsXY(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',y(1:(end-LCClags(clag_iter)))');
    laggedcorrsYX(clag_iter,1) = corr(y((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
end;
Deltal = abs(laggedcorrsXY)-abs(laggedcorrsYX);

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leanings,'k.',LCClags,Deltal,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NonlinearResponseExample_LandLCC.eps
close;

%% Lagged correlation plots

% for cplots_iter = 1:1:length(LCClags),
%     
%     figure('Units', 'inches', ...
%     'Position', [0 0 width height],...
%     'PaperPositionMode','auto');
% 
%     hold on;
% 
%     plot(x(1:end-cplots_iter),y((cplots_iter+1):end),'k.','MarkerSize',15)
%     ylabel('y_t','FontName','Times','FontSize', 15);
%     xlabel(sprintf('x_{t-%i}',cplots_iter),'FontName','Times','FontSize', 15);
%     grid on;
%     set(gca,'fontsize',15);
%     xlim([-2 4]);
%     ylim([-2 4]);
%     axis square
% 
%     hold off;
%     print('-depsc2',sprintf('./NonlinearResponseExample_lagplotXYl%i.eps',cplots_iter));
%     close;
%     
%     figure('Units', 'inches', ...
%     'Position', [0 0 width height],...
%     'PaperPositionMode','auto');
% 
%     hold on;
% 
%     plot(y(1:end-cplots_iter),x((cplots_iter+1):end),'k.','MarkerSize',15)
%     ylabel('x_t','FontName','Times','FontSize', 15);
%     xlabel(sprintf('y_{t-%i}',cplots_iter),'FontName','Times','FontSize', 15);
%     grid on;
%     set(gca,'fontsize',15);
%     xlim([-2 4]);
%     ylim([-2 4]);
%     axis square
% 
%     hold off;
%     print('-depsc2',sprintf('./NonlinearResponseExample_lagplotYXl%i.eps',cplots_iter));
%     close;
% end;

%% GC, TE, and PAI results (no print to terminal, no plots)

[TE,GC,PAI,L,LCC,g] = ECA(x,y,xtol,ytol,LCClags,true);

%% Leaning w/ different tol domains plots

% xtolv = 0:0.05:1;
% ytolv = 0:0.05:1;
% leanmat1 = nan(length(xtolv),length(ytolv));
% leanmat2 = nan(length(xtolv),length(ytolv));
% plotlag1 = 1;
% plotlag2 = 5;
% 
% for xt_iter = 1:1:length(xtolv),
%     for yt_iter = 1:1:length(ytolv),
%         
%         leantemp = leans_lagged(x,y,xtolv(xt_iter),ytolv(yt_iter),plotlag1);
%         leanmat1(xt_iter,yt_iter) = leantemp(1,2);
%         
%         leantemp = leans_lagged(x,y,xtolv(xt_iter),ytolv(yt_iter),plotlag2);
%         leanmat2(xt_iter,yt_iter) = leantemp(1,2);
%     end;
% end;
% 
% numColors = 32;
% cmap = colormap(flipud(gray(numColors)));
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 width height],...
% 'PaperPositionMode','auto');
% 
% cmap = colormap(flipud(gray(numColors)));
% hold on;
% 
% imagesc(xtolv,ytolv,leanmat1)
% ylabel('\delta_x','FontName','Times','FontSize', 15);
% xlabel('\delta_y','FontName','Times','FontSize', 15);
% grid on;
% set(gca,'fontsize',15);
% set(gca,'YDir','normal');
% xlim([0 1]);
% ylim([0 1]);
% axis square
% cbar = colorbar();
% set(cbar,'Visible','on');
% set(get(cbar,'Title'),'String', '\lambda_l','FontName','Times','FontSize', 12);
% 
% hold off;
% print('-depsc2','./NonlinearResponseExample_leandifftoll1.eps');
% close;
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 width height],...
% 'PaperPositionMode','auto');
% 
% cmap = colormap(flipud(gray(numColors)));
% hold on;
% 
% imagesc(xtolv,ytolv,leanmat2)
% ylabel('\delta_x','FontName','Times','FontSize', 15);
% xlabel('\delta_y','FontName','Times','FontSize', 15);
% grid on;
% set(gca,'fontsize',15);
% set(gca,'YDir','normal');
% xlim([0 1]);
% ylim([0 1]);
% axis square
% cbar = colorbar();
% set(cbar,'Visible','on');
% set(get(cbar,'Title'),'String', '\lambda_l','FontName','Times','FontSize', 12);
% 
% 
% hold off;
% print('-depsc2','./NonlinearResponseExample_leandifftoll5.eps');
% close;

%% Create ECA guess plot

% load NonlinearImpulseExample_20150902.mat
% 
% ECAguessmat = nan(length(B_vec),length(A_vec));
% for Biter = 1:1:length(B_vec),
%     for Citer = 1:1:length(A_vec),
%         
%         gtemp = reshape(g_stored(Biter,Citer,:),5,1);
%         ECAguessmat(Biter,Citer) = gtemp'*gtemp;
%         
%     end;
% end;
% 
% figure('Units', 'inches', ...
% 'Position', [0 0 width height],...
% 'PaperPositionMode','auto');
% 
% numColors = 2;
% cmap = colormap(gray(numColors));
% hold on;
% 
% imagesc(B_vec,A_vec,ECAguessmat)
% ylabel('B','FontName','Times','FontSize', 15);
% xlabel('A','FontName','Times','FontSize', 15);
% grid on;
% set(gca,'fontsize',15);
% set(gca,'YDir','normal');
% xlim([0 1]);
% ylim([0 1]);
% axis square
% cbar = colorbar();
% set(cbar,'Visible','off');
% set(get(cbar,'Title'),'String', '|g|^2','FontName','Times','FontSize', 12);
% 
% 
% hold off;
% print('-depsc2','./NonlinearResponseExample_ECAguessMat.eps');
% close;