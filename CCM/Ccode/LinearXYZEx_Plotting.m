load 'LinearEx_OutXYZ/LinearXYZEx_DataRead_OutTemp.mat';

DiffYXXY = CdataYX-CdataXY;
DiffYZZY = CdataYZ-CdataZY;
DiffZXXZ = CdataZX-CdataXZ;

figure(1);
subplot(1,3,1)
colormap(gray);
imagesc(Bv,Av,DiffYXXY);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YX}-C_{XY}');

subplot(1,3,2)
colormap(gray);
imagesc(Bv,Av,DiffYZZY);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YZ}-C_{ZY}');

subplot(1,3,3)
colormap(gray);
imagesc(Bv,Av,DiffZXXZ);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{ZX}-C_{XZ}');