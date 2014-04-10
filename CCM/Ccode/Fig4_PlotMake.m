addpath('..');
addpath('../../utils');

load('Fig4_PlottingData.mat');

width = 3;     % Width in inches
height = 3;    % Height in inches
alw = 0.25;    % AxesLineWidth
fsz = 8;      % Fontsize
lw = 0.5;      % LineWidth
msz = 4;       % MarkerSize

figure(1);
%OmegaVec(5) corresponds to 0.5 
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

subplot(1,3,1);
axis([0 1 0 1]);
axis square;
arrow([0 0],[CdataRI(5,1) CdataRI(5,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','I','I');
Ystring = sprintf('C_{%s,%s|%s}','I','R','R');
xlabel(Xstring);
ylabel(Ystring);
hold off;

subplot(1,3,2);
axis([0 1 0 1]);
axis square;
arrow([0 0],[CdataRV(5,1) CdataRV(5,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','V','V');
Ystring = sprintf('C_{%s,%s|%s}','V','R','R');
xlabel(Xstring);
ylabel(Ystring);
hold off;

subplot(1,3,3);
axis([0 1 0 1]);
axis square;
arrow([0 0],[CdataVI(5,1) CdataVI(5,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','V','I','I');
Ystring = sprintf('C_{%s,%s|%s}','I','V','V');
xlabel(Xstring);
ylabel(Ystring);
hold off;

figure(2);
%OmegaVec(10) corresponds to 1.0 
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); %<- Set size
set(gca, 'FontSize', fsz, 'LineWidth', alw); %<- Set properties

subplot(1,3,1);
axis([0 1 0 1]);
axis square;
for iter = 1:9,
    arrow([0 0],[CdataRI(iter,1) CdataRI(iter,2)],'FaceColor',[0.5 0.5 0.5]);
    hold on;
end;
for iter = 11:20,
    arrow([0 0],[CdataRI(iter,1) CdataRI(iter,2)],'FaceColor',[0.5 0.5 0.5]);
    hold on;
end;
arrow([0 0],[CdataRI(10,1) CdataRI(10,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','I','I');
Ystring = sprintf('C_{%s,%s|%s}','I','R','R');
xlabel(Xstring);
ylabel(Ystring);
hold off;

subplot(1,3,2);
axis([0 1 0 1]);
axis square;
for iter = 1:9,
    arrow([0 0],[CdataRV(iter,1) CdataRV(iter,2)],'FaceColor',[0.5 0.5 0.5]);
    hold on;
end;
for iter = 11:20,
    arrow([0 0],[CdataRV(iter,1) CdataRV(iter,2)],'FaceColor',[0.5 0.5 0.5]);
    hold on;
end;
arrow([0 0],[CdataRV(5,1) CdataRV(5,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','V','V');
Ystring = sprintf('C_{%s,%s|%s}','V','R','R');
xlabel(Xstring);
ylabel(Ystring);
hold off;

subplot(1,3,3);
axis([0 1 0 1]);
axis square;
for iter = 1:9,
    arrow([0 0],[CdataVI(iter,1) CdataVI(iter,2)],'FaceColor',[0.5 0.5 0.5]);
    hold on;
end;
for iter = 11:20,
    arrow([0 0],[CdataVI(iter,1) CdataVI(iter,2)],'FaceColor',[0.5 0.5 0.5]);
    hold on;
end;
arrow([0 0],[CdataVI(5,1) CdataVI(5,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','V','I','I');
Ystring = sprintf('C_{%s,%s|%s}','I','V','V');
xlabel(Xstring);
ylabel(Ystring);
hold off;