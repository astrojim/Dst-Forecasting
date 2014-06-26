% load 'RLCircuit_varyV_amp/RLcircuitDataExplore_DataRead_varyV_amp.mat';
% data = Av;
% dataLabel = 'Av';

% load 'RLCircuit_varyV_offset/RLcircuitDataExplore_DataRead_varyV_offset.mat';
% data = offset;
% dataLabel = 'offset';

% load 'RLCircuit_varyV_phase/RLcircuitDataExplore_DataRead_varyV_phase.mat';
% data = phase;
% dataLabel = 'phase';

load 'RLCircuit_varyV_freq/RLcircuitDataExplore_DataRead_varyV_freq.mat';
data = freq;
dataLabel = 'freq';

% load 'RLCircuit_varyR_amp/RLcircuitDataExplore_DataRead_varyR_amp.mat';
% data = Av;
% dataLabel = 'Av';

% load 'RLCircuit_varyR_offset/RLcircuitDataExplore_DataRead_varyR_offset.mat';
% data = offset;
% dataLabel = 'offset';

% load 'RLCircuit_varyR_phase/RLcircuitDataExplore_DataRead_varyR_phase.mat';
% data = phase;
% dataLabel = 'phase';

% load 'RLCircuit_varyR_freq/RLcircuitDataExplore_DataRead_varyR_freq.mat';
% data = freq;
% dataLabel = 'freq';

% load 'RLCircuit_varyV_offsetlong/RLcircuitDataExplore_DataRead_varyV_offsetlong.mat';
% data = offset;
% dataLabel = 'offset';

% load 'RLCircuit_varyV_offsetLup/RLcircuitDataExplore_DataRead_varyV_offsetLup.mat';
% data = offset;
% dataLabel = 'offset';

% load 'RLCircuit_varyR_freqlong/RLcircuitDataExplore_DataRead_varyR_freqlong.mat';
% data = freq;
% dataLabel = 'freq';

% load 'RLCircuit_varyR_freqLup/RLcircuitDataExplore_DataRead_varyR_freqLup.mat';
% data = freq;
% dataLabel = 'freq';

% load 'RLCircuit_varyV_ampE3/RLcircuitDataExplore_DataRead_varyV_ampE3.mat';
% data = Av;
% dataLabel = 'Av';

% load 'RLCircuit_varyV_offsetE3/RLcircuitDataExplore_DataRead_varyV_offsetE3.mat';
% data = offset;
% dataLabel = 'offset';

% load 'RLCircuit_varyV_phaseE3/RLcircuitDataExplore_DataRead_varyV_phaseE3.mat';
% data = phase;
% dataLabel = 'phase';

% load 'RLCircuit_varyV_freqE3/RLcircuitDataExplore_DataRead_varyV_freqE3.mat';
% data = freq;
% dataLabel = 'freq';

% load 'RLCircuit_varyV_offsetlongE3/RLcircuitDataExplore_DataRead_varyV_offsetlongE3.mat';
% data = offset;
% dataLabel = 'offset';

% load 'RLCircuit_varyV_offsetLupE3/RLcircuitDataExplore_DataRead_varyV_offsetLupE3.mat';
% data = offset;
% dataLabel = 'offset';

Delta = CdataVI(:,1) - CdataVI(:,2);

width = 4;
height = 2;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;

hPnts = plot(Delta,'xk','MarkerSize',5);

hXLabel = xlabel('\Omega_v');
hYLabel = ylabel('\Delta = C_{VI}-C_{IV}');

set([hXLabel, hYLabel],'FontName','AvantGarde');
set([hXLabel, hYLabel],'FontSize', 10);

hold off;
print -depsc2 PlotOutTempDir/RLCircuitVaryV_Freq.eps
close;


%{
n = 1;

figure(n);
%OmegaVec(491) corresponds to 0.5 
axis([0 1 0 1]);
axis square;
plot(CdataRI(1,1),CdataRI(1,2),'xk','MarkerSize',5);
hold on;
grid on;
for iter = 1:length(data),
    plot(CdataRI(iter,1),CdataRI(iter,2),'xk','MarkerSize',5);
end;
plot(0:0.1:1,0:0.1:1,'--k');
hold off;
Xstring = sprintf('C_{%s,%s|%s}','R','R','I');
Ystring = sprintf('C_{%s,%s|%s}','I','I','R');
xlabel(Xstring);
ylabel(Ystring);
title('RI');
n = n+1;

figure(n);
%OmegaVec(491) corresponds to 0.5 
subplot(1,2,1);
hist(CdataRI(:,1),100);
xlabel('CdataRI 1');
ylabel('counts');
title('RI hist 1');
subplot(1,2,2);
hist(CdataRI(:,2),100);
xlabel('CdataRI 2');
ylabel('counts');
title('RI hist 2');
n = n+1;

figure(n);
axis([0 1 0 1]);
axis square;
plot(CdataRV(1,1),CdataRV(1,2),'xk','MarkerSize',5);
hold on;
grid on;
for iter = 1:length(data),
    plot(CdataRV(iter,1),CdataRV(iter,2),'xk','MarkerSize',5);
end;
plot(0:0.1:1,0:0.1:1,'--k');
hold off;
Xstring = sprintf('C_{%s,%s|%s}','R','R','V');
Ystring = sprintf('C_{%s,%s|%s}','V','V','R');
xlabel(Xstring);
ylabel(Ystring);
title('RV');
n = n+1;

figure(n);
subplot(1,2,1);
hist(CdataRV(:,1),100);
xlabel('CdataRV 1');
ylabel('counts');
title('RV hist 1');
subplot(1,2,2);
hist(CdataRV(:,2),100);
xlabel('CdataRV 2');
ylabel('counts');
title('RV hist 2');
n = n+1;

figure(n);
axis([0 1 0 1]);
axis square;
plot(CdataVI(1,1),CdataVI(1,2),'xk','MarkerSize',5);
hold on;
grid on;
for iter = 1:length(data),
    plot(CdataVI(iter,1),CdataVI(iter,2),'xk','MarkerSize',5);
end;
plot(0:0.1:1,0:0.1:1,'--k');
hold off;
Xstring = sprintf('C_{%s,%s|%s}','V','V','I');
Ystring = sprintf('C_{%s,%s|%s}','I','I','V');
xlabel(Xstring);
ylabel(Ystring);
title('VI');
n = n+1;

figure(n);
subplot(1,2,1);
hist(CdataVI(:,1),100);
xlabel('CdataVI 1');
ylabel('counts');
title('VI hist 1');
subplot(1,2,2);
hist(CdataVI(:,2),100);
xlabel('CdataVI 2');
ylabel('counts');
title('VI hist 2');
n = n+1;

figure(n);
subplot(1,2,1);
hist(atan(CdataVI(:,2)./CdataVI(:,1)),100);
xlabel('CdataVI 1');
ylabel('counts');
title('VI hist Angle');
subplot(1,2,2);
hist(sqrt(CdataVI(:,1).^2+CdataVI(:,2).^2),100);
xlabel('CdataVI 2');
ylabel('counts');
title('VI hist Length');
n = n+1;

figure(n);
subplot(1,2,1);
hist(atan(CdataRV(:,2)./CdataRV(:,1)),100);
xlabel('CdataRV 1');
ylabel('counts');
title('RV hist Angle');
subplot(1,2,2);
hist(sqrt(CdataRV(:,1).^2+CdataRV(:,2).^2),100);
xlabel('CdataRV 2');
ylabel('counts');
title('RV hist Length');
n = n+1;

figure(n);
subplot(1,2,1);
hist(atan(CdataRI(:,2)./CdataRI(:,1)),100);
xlabel('CdataRI 1');
ylabel('counts');
title('RI hist Angle');
subplot(1,2,2);
hist(sqrt(CdataRI(:,1).^2+CdataRI(:,2).^2),100);
xlabel('CdataRI 2');
ylabel('counts');
title('RI hist Length');
n = n+1;

figure(n);
subplot(1,2,1);
plot(data,atan(CdataVI(:,2)./CdataVI(:,1)),'xk','MarkerSize',7);
hold on;
plot([0:0.01:data(end)],pi/4,'--','LineWidth',3);
xlabel(dataLabel);
ylabel('P_\theta');
title('VI Angle');
subplot(1,2,2);
plot(data,sqrt(CdataVI(:,1).^2+CdataVI(:,2).^2),'xk','MarkerSize',7);
hold on;
plot([0:0.01:data(end)],sqrt(2),'--','LineWidth',3);
xlabel(dataLabel);
ylabel('|P|');
title('VI Length');
n = n+1;

figure(n);
subplot(1,2,1);
plot(data,atan(CdataRV(:,2)./CdataRV(:,1)),'xk','MarkerSize',7);
hold on;
plot([0:0.01:data(end)],pi/4,'--','LineWidth',3);
xlabel(dataLabel);
ylabel('P_\theta');
title('RV Angle');
subplot(1,2,2);
plot(data,sqrt(CdataRV(:,1).^2+CdataRV(:,2).^2),'xk','MarkerSize',7);
hold on;
plot([0:0.01:data(end)],sqrt(2),'--','LineWidth',3);
xlabel(dataLabel);
ylabel('|P|');
title('RV Length');
n = n+1;

figure(n);
subplot(1,2,1);
plot(data,atan(CdataRI(:,2)./CdataRI(:,1)),'xk','MarkerSize',7);
hold on;
plot([0:0.01:data(end)],pi/4,'--','LineWidth',3);
xlabel(dataLabel);
ylabel('P_\theta');
title('RI Angle');
subplot(1,2,2);
plot(data,sqrt(CdataRI(:,1).^2+CdataRI(:,2).^2),'xk','MarkerSize',7);
hold on;
plot([0:0.01:data(end)],sqrt(2),'--','LineWidth',3);
xlabel(dataLabel);
ylabel('|P|');
title('RI Length');
n = n+1;

figure(n);
subplot(1,2,1);
plot(data,CdataVI(:,1),'xk','MarkerSize',7);
hold on;
xlabel(dataLabel);
ylabel('C_{VI}');
title('CdataVI 1');
subplot(1,2,2);
plot(data,CdataVI(:,2),'xk','MarkerSize',7);
xlabel(dataLabel);
ylabel('C_{IV}');
title('CdataVI 2');
n = n+1;

figure(n);
subplot(1,2,1);
plot(data,CdataRV(:,1),'xk','MarkerSize',7);
hold on;
xlabel(dataLabel);
ylabel('C_{RV}');
title('CdataRV 1');
subplot(1,2,2);
plot(data,CdataRV(:,2),'xk','MarkerSize',7);
xlabel(dataLabel);
ylabel('C_{VR}');
title('CdataRV 2');
n = n+1;

figure(n);
subplot(1,2,1);
plot(data,CdataRI(:,1),'xk','MarkerSize',7);
hold on;
xlabel(dataLabel);
ylabel('C_{RI}');
title('CdataRI 1');
subplot(1,2,2);
plot(data,CdataRI(:,2),'xk','MarkerSize',7);
xlabel(dataLabel);
ylabel('C_{IR}');
title('CdataRI 2');
n = n+1;
%}