load 'LinearEx_Out10x10grid/LinearEx_DataRead_Out10x10grid.mat';
AvOrig = Av;
BvOrig = Bv;
load 'LinearEx_OutPAI/LinearEx_OutPAI_temp.mat';

DiffYXXY = CdataYX-CdataXY;
DiffPrime = CdataYYX-CdataXXY;

figure(1);
subplot(1,2,1);
colormap(gray);
imagesc(BvOrig(1:19),AvOrig(1:19),DiffYXXY(1:19,1:19));
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YX}-C_{XY}');

subplot(1,2,2);
colormap(gray);
imagesc(Bv,Av,DiffPrime);
cbar = colorbar();
title(cbar,'\Delta^\prime');
xlabel('B');
ylabel('A');
title('\Delta^\prime = C_{Y(YX)}-C_{X(XY)}');

