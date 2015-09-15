
% Set B and C for the plots
A = 0.4;
B = 0.6;

% set signal length
liblength = 500;

% set spacing for impulses
hitspace = 5;

% set impulse peak
hitpeak = 2;

% build X and Y and Z (3 cases)
[x,y,z1,z2,z3] = NoisyImpulseMultipleResponse(liblength,hitspace,hitpeak,A,B);

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
% ylim([-1 2.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_X.eps
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
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_Y.eps
close;

%% plot Z1 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(1:1:liblength,z1,'k.','MarkerSize',15);
xlabel('t','FontName','Times','FontSize', 15);
ylabel('z_t','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_z1.eps
close;

%% plot Z2 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(1:1:liblength,z2,'k.','MarkerSize',15);
xlabel('t','FontName','Times','FontSize', 15);
ylabel('z_t^\prime','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_z2.eps
close;

%% plot Z3 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(1:1:liblength,z3,'k.','MarkerSize',15);
xlabel('t','FontName','Times','FontSize', 15);
ylabel('z_t^{\prime\prime}','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_z3.eps
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
print -depsc2 ./NoisyMultiResponseExample_Xhist.eps
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
print -depsc2 ./NoisyMultiResponseExample_Yhist.eps
close;

%% histogram Z1 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(z1,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('z_t bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_Z1hist.eps
close;

%% histogram Z2 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(z2,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('z_t^\prime bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_Z2hist.eps
close;

%% histogram Z3 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(z3,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('z_t^{\prime\prime} bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_Z3hist.eps
close;

%% Autocorrelation X and Y

lags = 1:1:50;
autocorrX = nan(length(lags),1);
autocorrY = nan(length(lags),1);
autocorrZ1 = nan(length(lags),1);
autocorrZ2 = nan(length(lags),1);
autocorrZ3 = nan(length(lags),1);

for liter = 1:1:length(lags),
    autocorrX(liter,1) = abs(corr(x((lags(liter)+1):end)',x(1:(end-lags(liter)))'))^2;
    autocorrY(liter,1) = abs(corr(y((lags(liter)+1):end)',y(1:(end-lags(liter)))'))^2;
    autocorrZ1(liter,1) = abs(corr(z1((lags(liter)+1):end)',z1(1:(end-lags(liter)))'))^2;
    autocorrZ2(liter,1) = abs(corr(z2((lags(liter)+1):end)',z2(1:(end-lags(liter)))'))^2;
    autocorrZ3(liter,1) = abs(corr(z3((lags(liter)+1):end)',z3(1:(end-lags(liter)))'))^2;
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
print -depsc2 ./NoisyMultiResponseExample_autocorrX.eps
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
print -depsc2 ./NoisyMultiResponseExample_autocorrY.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrZ1,'k.','MarkerSize',15);
ylabel('|r(z_{t-l},z_t)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_autocorrZ1.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrZ2,'k.','MarkerSize',15);
ylabel('|r(z_{t-l}^\prime,z_t^\prime)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_autocorrZ2.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrZ3,'k.','MarkerSize',15);
ylabel('|r(z_{t-l}^{\prime\prime},z_t^{\prime\prime})|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_autocorrZ3.eps
close;
%% Leaning and LCC

addpath('leans_exec');
LCClags = 1:1:6;
xtol = (max(x)-min(x))/4;
ytol = (max(y)-min(y))/4;
z1tol = (max(z1)-min(z1))/4;
z2tol = (max(z2)-min(z2))/4;
z3tol = (max(z3)-min(z3))/4;
leaningsXY = nan(length(LCClags),1);
leaningsXZ1 = nan(length(LCClags),1);
leaningsXZ2 = nan(length(LCClags),1);
leaningsXZ3 = nan(length(LCClags),1);
leaningsYZ1 = nan(length(LCClags),1);
leaningsYZ2 = nan(length(LCClags),1);
leaningsYZ3 = nan(length(LCClags),1);
for lag_iter = 1:1:length(LCClags),
    leantemp = leans_lagged(x,y,xtol,ytol,LCClags(lag_iter));
    leaningsXY(lag_iter,1) = leantemp(1,2);
    
    leantemp = leans_lagged(x,z1,xtol,z1tol,LCClags(lag_iter));
    leaningsXZ1(lag_iter,1) = leantemp(1,2);
    leantemp = leans_lagged(x,z2,xtol,z2tol,LCClags(lag_iter));
    leaningsXZ2(lag_iter,1) = leantemp(1,2);
    leantemp = leans_lagged(x,z3,xtol,z3tol,LCClags(lag_iter));
    leaningsXZ3(lag_iter,1) = leantemp(1,2);
    
    leantemp = leans_lagged(y,z1,ytol,z1tol,LCClags(lag_iter));
    leaningsYZ1(lag_iter,1) = leantemp(1,2);
    leantemp = leans_lagged(y,z2,ytol,z2tol,LCClags(lag_iter));
    leaningsYZ2(lag_iter,1) = leantemp(1,2);
    leantemp = leans_lagged(y,z3,ytol,z3tol,LCClags(lag_iter));
    leaningsYZ3(lag_iter,1) = leantemp(1,2);
end;

laggedcorrsXY = nan(length(LCClags),1);
laggedcorrsYX = nan(length(LCClags),1);
laggedcorrsXZ1 = nan(length(LCClags),1);
laggedcorrsZ1X = nan(length(LCClags),1);
laggedcorrsXZ2 = nan(length(LCClags),1);
laggedcorrsZ2X = nan(length(LCClags),1);
laggedcorrsXZ3 = nan(length(LCClags),1);
laggedcorrsZ3X = nan(length(LCClags),1);
laggedcorrsYZ1 = nan(length(LCClags),1);
laggedcorrsZ1Y = nan(length(LCClags),1);
laggedcorrsYZ2 = nan(length(LCClags),1);
laggedcorrsZ2Y = nan(length(LCClags),1);
laggedcorrsYZ3 = nan(length(LCClags),1);
laggedcorrsZ3Y = nan(length(LCClags),1);

for clag_iter = 1:1:length(LCClags),
    laggedcorrsXY(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',y(1:(end-LCClags(clag_iter)))');
    laggedcorrsYX(clag_iter,1) = corr(y((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
    
    laggedcorrsXZ1(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',z1(1:(end-LCClags(clag_iter)))');
    laggedcorrsZ1X(clag_iter,1) = corr(z1((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
    laggedcorrsXZ2(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',z2(1:(end-LCClags(clag_iter)))');
    laggedcorrsZ2X(clag_iter,1) = corr(z2((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
    laggedcorrsXZ3(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',z3(1:(end-LCClags(clag_iter)))');
    laggedcorrsZ3X(clag_iter,1) = corr(z3((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
    
    laggedcorrsYZ1(clag_iter,1) = corr(y((LCClags(clag_iter)+1):end)',z1(1:(end-LCClags(clag_iter)))');
    laggedcorrsZ1Y(clag_iter,1) = corr(z1((LCClags(clag_iter)+1):end)',y(1:(end-LCClags(clag_iter)))');
    laggedcorrsYZ2(clag_iter,1) = corr(y((LCClags(clag_iter)+1):end)',z2(1:(end-LCClags(clag_iter)))');
    laggedcorrsZ2Y(clag_iter,1) = corr(z2((LCClags(clag_iter)+1):end)',y(1:(end-LCClags(clag_iter)))');
    laggedcorrsYZ3(clag_iter,1) = corr(y((LCClags(clag_iter)+1):end)',z3(1:(end-LCClags(clag_iter)))');
    laggedcorrsZ3Y(clag_iter,1) = corr(z3((LCClags(clag_iter)+1):end)',y(1:(end-LCClags(clag_iter)))');
end;
DeltalXY = abs(laggedcorrsXY)-abs(laggedcorrsYX);
DeltalXZ1 = abs(laggedcorrsXZ1)-abs(laggedcorrsZ1X);
DeltalXZ2 = abs(laggedcorrsXZ2)-abs(laggedcorrsZ2X);
DeltalXZ3 = abs(laggedcorrsXZ3)-abs(laggedcorrsZ3X);
DeltalYZ1 = abs(laggedcorrsYZ1)-abs(laggedcorrsZ1Y);
DeltalYZ2 = abs(laggedcorrsYZ2)-abs(laggedcorrsZ2Y);
DeltalYZ3 = abs(laggedcorrsYZ3)-abs(laggedcorrsZ3Y);

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsXY,'k.',LCClags,DeltalXY,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_XY.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsXZ1,'k.',LCClags,DeltalXZ1,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_XZ1.eps
close;


figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsXZ2,'k.',LCClags,DeltalXZ2,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_XZ2.eps
close;


figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsXZ3,'k.',LCClags,DeltalXZ3,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_XZ3.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsYZ1,'k.',LCClags,DeltalYZ1,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_YZ1.eps
close;


figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsYZ2,'k.',LCClags,DeltalYZ2,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_YZ2.eps
close;


figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leaningsYZ3,'k.',LCClags,DeltalYZ3,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./NoisyMultiResponseExample_LandLCC_YZ3.eps
close;

%% GC, TE, and PAI results (no print to terminal, no plots)

fprintf('\n\n ==> XY \n');
[TE_xy,GC_xy,PAI_xy,L_xy,LCC_xy,g_xy] = ECA(x,y,xtol,ytol,LCClags,true,false);

fprintf('\n\n ==> XZ1 \n');
[TE_xz1,GC_xz1,PAI_xz1,L_xz1,LCC_xz1,g_xz1] = ECA(x,z1,xtol,z1tol,LCClags,true,false);

fprintf('\n\n ==> XZ2 \n');
[TE_xz2,GC_xz2,PAI_xz2,L_xz2,LCC_xz2,g_xz2] = ECA(x,z2,xtol,z2tol,LCClags,true,false);

fprintf('\n\n ==> XZ3 \n');
[TE_xz3,GC_xz3,PAI_xz3,L_xz3,LCC_xz3,g_xz3] = ECA(x,z3,xtol,z3tol,LCClags,true,true);

fprintf('\n\n ==> YZ1 \n');
[TE_yz1,GC_yz1,PAI_yz1,L_yz1,LCC_yz1,g_yz1] = ECA(y,z1,ytol,z1tol,LCClags,true,true);

fprintf('\n\n ==> YZ2 \n');
[TE_yz2,GC_yz2,PAI_yz2,L_yz2,LCC_yz2,g_yz2] = ECA(y,z2,ytol,z2tol,LCClags,true,true);

fprintf('\n\n ==> XZ3 \n');
[TE_yz3,GC_yz3,PAI_yz3,L_yz3,LCC_yz3,g_yz3] = ECA(y,z3,ytol,z3tol,LCClags,true,true);


