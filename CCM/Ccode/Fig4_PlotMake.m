addpath('..');
addpath('../..');
addpath('../../../utils');

load('Fig4_PlottingData_MorePoints_PostBugFix.mat');

width = 3;     % Width in inches
height = 3;    % Height in inches

figure(1);
%OmegaVec(491) corresponds to 0.5 
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); 
axis([0 1 0 1]);
axis square;
arrow([0 0],[CdataRI(491,1) CdataRI(491,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','R','I');
Ystring = sprintf('C_{%s,%s|%s}','I','I','R');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Omega = 0.5');
hold off;

figure(2);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); 
axis([0 1 0 1]);
axis square;
arrow([0 0],[CdataRV(491,1) CdataRV(491,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','R','V');
Ystring = sprintf('C_{%s,%s|%s}','V','V','R');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Omega = 0.5');
hold off;

figure(3);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]); 
axis([0 1 0 1]);
axis square;
arrow([0 0],[CdataVI(491,1) CdataVI(491,2)]);
hold on;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
Xstring = sprintf('C_{%s,%s|%s}','V','V','I');
Ystring = sprintf('C_{%s,%s|%s}','I','I','V');
xlabel(Xstring);
ylabel(Ystring);
title('Omega = 0.5');
hold off;

figure(4);
%OmegaVec(991) corresponds to 1.0 
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
axis([0 1 0 1]);
axis square;
hold on;
for iter = 1:990,
    plot(CdataRI(iter,1),CdataRI(iter,2),'.k');
end;
for iter = 991:length(OmegaVec),
    plot(CdataRI(iter,1),CdataRI(iter,2),'.k');
end;
arrow([0 0],[CdataRI(991,1) CdataRI(991,2)]);
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','R','I');
Ystring = sprintf('C_{%s,%s|%s}','I','I','R');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Omega = 1.0 (plus all other tips)');
hold off;

figure(5);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
axis([0 1 0 1]);
axis square;
hold on;
for iter = 1:990,
    plot(CdataRI(iter,1),CdataRI(iter,2),'.k');
end;
for iter = 991:length(OmegaVec),
    plot(CdataRI(iter,1),CdataRI(iter,2),'.k');
end;
arrow([0 0],[CdataRV(991,1) CdataRV(991,2)]);
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','R','R','V');
Ystring = sprintf('C_{%s,%s|%s}','V','V','R');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Omega = 1.0 (plus all other tips)');
hold off;

figure(6);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
axis([0 1 0 1]);
axis square;
hold on;
for iter = 1:990,
    plot(CdataRI(iter,1),CdataRI(iter,2),'.k');    
end;
for iter = 991:length(OmegaVec),
    plot(CdataRI(iter,1),CdataRI(iter,2),'.k');
end;
arrow([0 0],[CdataVI(991,1) CdataVI(991,2)]);
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('C_{%s,%s|%s}','V','V','I');
Ystring = sprintf('C_{%s,%s|%s}','I','I','V');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Omega = 1.0 (plus all other tips)');
hold off;

figure(7);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
hold on;
for iter = 1:length(OmegaVec),
    plot(OmegaVec(iter),atan(CdataRI(iter,2)/CdataRI(iter,1)),'xk');
    plot(OmegaVec(iter),pi/4,'--k');
end;
grid on;
Ystring = sprintf('P_theta (RI)');
Xstring = sprintf('omega');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Angle v. Omega (pi/4 = 0.7854)');
hold off;

figure(8);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
hold on;
for iter = 1:length(OmegaVec),
    plot(OmegaVec(iter),sqrt(CdataRI(iter,2)^2+CdataRI(iter,1)^2),'xk');
end;
grid on;
Ystring = sprintf('|P| (RI)');
Xstring = sprintf('omega');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
title('Length v. Omega');
hold off;

figure(9);
tempVec = atan(CdataRI(:,2)./CdataRI(:,1));
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
hold on;
hist(tempVec,100);
grid on;
Ystring = sprintf('counts');
Xstring = sprintf('P_theta (RI)');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
hold off;

figure(10);
tempVec = sqrt(CdataRI(:,2).^2+CdataRI(:,1).^2);
pos = get(gcf, 'Position');
set(gcf, 'Position', [pos(1) pos(2) width*100, height*100]);
hold on;
hist(tempVec,100);
grid on;
Ystring = sprintf('counts');
Xstring = sprintf('|P| (RI)');
set(gca, 'FontSize', 12, 'LineWidth', 1.5);
xlabel(Xstring);
ylabel(Ystring);
hold off;