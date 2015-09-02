% set globals (used by ODE solver)
global tspan;
global Vv;
global RR;
global L;

% Set B and C for the plots
R = 10;
L = 5;

% set signal parameters
endtime = 8*pi;
stepsize = (1/10)*pi;

% build X and Y
[x,y_an,y_num] = RLCircuitResponse(endtime,stepsize,R);

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
ylim([-1.5 1.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_X.eps
close;

%% plot Y 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(1:1:liblength,y_an,'k.',1:1:liblength,y_num,'ko','MarkerSize',15);
xlabel('t','FontName','Times','FontSize', 15);
ylabel('y_t','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
ylim([-2.5 2.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_Y.eps
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
print -depsc2 ./IRCircuitResponseExample_Xhist.eps
close;

%% histogram Y 
figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(y_an,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('y_t bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_Yhist_an.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hist(y_num,100);
ylabel('counts','FontName','Times','FontSize', 15);
xlabel('y_t bins','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_Yhist_num.eps
close;

%% Autocorrelation X and Y

lags = 1:1:50;
autocorrX = nan(length(lags),1);
autocorrY_an = nan(length(lags),1);
autocorrY_num = nan(length(lags),1);

for liter = 1:1:length(lags),
    autocorrX(liter,1) = abs(corr(x((lags(liter)+1):end)',x(1:(end-lags(liter)))'))^2;
    autocorrY_an(liter,1) = abs(corr(y_an((lags(liter)+1):end)',y_an(1:(end-lags(liter)))'))^2;
    autocorrY_num(liter,1) = abs(corr(y_num((lags(liter)+1):end)',y_num(1:(end-lags(liter)))'))^2;
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
print -depsc2 ./IRCircuitResponseExample_autocorrX.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(lags,autocorrY_an,'k.',lags,autocorrY_num,'ko','MarkerSize',15);
ylabel('|r(y_{t-l},y_t)|^2','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_autocorrY.eps
close;

%% Leaning and LCC

addpath('leans_exec');
LCClags = 1:1:20;
xtol = (max(x)-min(x))/4;
ytol_an = (max(y_an)-min(y_an))/4;
leanings_an = nan(length(LCClags),1);
ytol_num = (max(y_num)-min(y_num))/4;
leanings_num = nan(length(LCClags),1);

for lag_iter = 1:1:length(LCClags),
    leantemp = leans_lagged(x,y_an,xtol,ytol_an,LCClags(lag_iter));
    leanings_an(lag_iter,1) = leantemp(1,2);
    leantemp = leans_lagged(x,y_num,xtol,ytol_num,LCClags(lag_iter));
    leanings_num(lag_iter,1) = leantemp(1,2);
end;

laggedcorrsXY_an = nan(length(LCClags),1);
laggedcorrsYX_an = nan(length(LCClags),1);
laggedcorrsXY_num = nan(length(LCClags),1);
laggedcorrsYX_num = nan(length(LCClags),1);

for clag_iter = 1:1:length(LCClags),
    laggedcorrsXY_an(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',y_an(1:(end-LCClags(clag_iter)))');
    laggedcorrsYX_an(clag_iter,1) = corr(y_an((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
    laggedcorrsXY_num(clag_iter,1) = corr(x((LCClags(clag_iter)+1):end)',y_num(1:(end-LCClags(clag_iter)))');
    laggedcorrsYX_num(clag_iter,1) = corr(y_num((LCClags(clag_iter)+1):end)',x(1:(end-LCClags(clag_iter)))');
end;
Deltal_an = abs(laggedcorrsXY_an)-abs(laggedcorrsYX_an);
Deltal_num = abs(laggedcorrsXY_num)-abs(laggedcorrsYX_num);

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leanings_an,'k.',LCClags,Deltal_an,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_LandLCC_an.eps
close;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

plot(LCClags,leanings_num,'k.',LCClags,Deltal_num,'ko','MarkerSize',15);
% ylabel('','FontName','Times','FontSize', 15);
xlabel('l','FontName','Times','FontSize', 15);
legend('\langle \lambda_l \rangle','\Delta_l');
grid on;
set(gca,'fontsize',15);
% ylim([-2 3.5]);

hold off;
print -depsc2 ./IRCircuitResponseExample_LandLCC_num.eps
close;

%% GC, TE, and PAI results (no print to terminal, no plots)

[TE_an,GC_an,PAI_an,L_an,LCC_an,g_an] = ECA(x,y_an,xtol,ytol_an,LCClags,true);
[TE_num,GC_num,PAI_num,L_num,LCC_num,g_num] = ECA(x,y_num,xtol,ytol_an,LCClags,true);
