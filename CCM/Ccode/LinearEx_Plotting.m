load 'LinearEx_Out10x10grid/LinearEx_DataRead_Out10x10grid.mat';

DiffYXXY = CdataYX-CdataXY;

figure(1);
colormap(gray);
imagesc(Bv,Av,CdataXY);
caxis([0 1]);
cbar = colorbar();
title(cbar,'C_{XY}');
xlabel('B');
ylabel('A');
title('C_{XY} CCM: estimating X using Y shadow');

figure(2);
colormap(gray);
imagesc(Bv,Av,CdataYX);
caxis([0 1]);
cbar = colorbar();
title(cbar,'C_{YX}');
xlabel('B');
ylabel('A');
title('C_{YX} CCM: estimating Y using X shadow');

figure(3);
colormap(gray);
imagesc(Bv,Av,DiffYXXY);
caxis([-0.12 0.12]);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YX}-C_{XY}');