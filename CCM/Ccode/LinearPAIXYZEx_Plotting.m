load 'LinearPAIXYZEx_DataRead_OutTemp.mat';

DiffYXXY = CdataYYX-CdataXXY;
DiffYZZY = CdataYYZ-CdataZZY;
DiffZXXZ = CdataZZX-CdataXXZ;

figure(1);
subplot(1,3,1)
colormap(gray);
imagesc(Bv,Av,DiffYXXY);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YYX}-C_{XXY}');

subplot(1,3,2)
colormap(gray);
imagesc(Bv,Av,DiffYZZY);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{YYZ}-C_{ZZY}');

subplot(1,3,3)
colormap(gray);
imagesc(Bv,Av,DiffZXXZ);
cbar = colorbar();
title(cbar,'\Delta');
xlabel('B');
ylabel('A');
title('\Delta = C_{ZZX}-C_{XXZ}');