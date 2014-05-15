load 'LinearEx_OutChangeL/LinearEx_ChangeL_DataRead_A30B26.mat';
CXY_A30B26 = CdataXY;
CYX_A30B26 = CdataYX;

load 'LinearEx_OutChangeL/LinearEx_ChangeL_DataRead_A26B26.mat';
CXY_A26B26 = CdataXY;
CYX_A26B26 = CdataYX;

%running means
Delta_A30B26 = zeros(length(Tfinals),1);
Delta_A26B26 = zeros(length(Tfinals),1);
for iter = 1:1:length(Tfinals),
    Delta_A30B26(iter) = CYX_A30B26(iter)-CXY_A30B26(iter);
    Delta_A26B26(iter) = CYX_A26B26(iter)-CXY_A26B26(iter);
end;

n = 1;

figure(n);
plot(Tfinals,CXY_A30B26,'b.',Tfinals,CYX_A30B26,'ro',...
      Tfinals,CXY_A26B26,'g^',Tfinals,CYX_A26B26,'mv');
 hold on;
 plot(Tfinals,Delta_A30B26,'c-',Tfinals,Delta_A26B26,'k-',...
      'LineWidth',2.5);
grid on;
title('CCM Comparison for A = 3.0 and A = 2.6 given B = 2.6 [see text]');
xlabel('library length');
ylabel('cross-mapped correlation')
legend('C_{XY} A= 3.0','C_{YX} A= 3.0','C_{XY} A= 2.6',...
       'C_{YX} A= 2.6','\Delta A= 3.0','\Delta A= 2.6');
hold off;