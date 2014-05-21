load 'NonLinearEx_Out/NonLinearEx_DataRead_OutTemp.mat';

DiffYXXY = CdataYX-CdataXY;

figure(1);
subplot(3,3,1);
Cstep = 2;
colormap(gray);
imagesc(Bv,Av,DiffYXXY(:,:,Cstep));
set(gca,'YDir','normal');
hold on;
contour(Bv,Av,DiffYXXY(:,:,Cstep),...
          [0 0],'r','LineWidth',2);
hold off;
cbar = colorbar();
caxis([-0.1 0.6]);
title(cbar,'\Delta = C_{YX}-C_{XY}');
xlabel('B');
ylabel('A');
title(sprintf('C = %.2f;',Cv(Cstep)));

for iter = 2:9,
    subplot(3,3,iter);
    Cstep = Cstep + 1;
    colormap(gray);
    imagesc(Bv,Av,DiffYXXY(:,:,Cstep));
    set(gca,'YDir','normal');
    hold on;
    contour(Bv,Av,DiffYXXY(:,:,Cstep),...
              [0 0],'r','LineWidth',2);
    hold off;
    cbar = colorbar();
    caxis([-0.1 0.6]);
    xlabel('B');
    ylabel('A');
    title(sprintf('C = %.2f;',Cv(Cstep)));
end;
