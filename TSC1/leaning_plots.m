% x = [0,1,2,1,0];
% y = [0,0,1,2,1];
% dx = [0,1,1,-1,-1];
% dy = [0,0,1,1,-1];

x = [0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0];
y = [0,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1];
dx = [0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1];
dy = [0,0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,];

tol = 1e-18;

nbins = 2:1:length(x);
plotdataNTSxy = zeros(2,length(nbins));
plotdataNTSdxy = zeros(2,length(nbins));
plotdataNTSxdy = zeros(2,length(nbins));
plotdataNTSdxdy = zeros(2,length(nbins));
plotdataNTSxdx = zeros(2,length(nbins));
plotdataNTSydy = zeros(2,length(nbins));
for iter = 1:1:length(nbins),
    
    fprintf('Notional TS; nbins = %i\n',nbins(iter));
    
    lenvec = leaningALT(x,y,nbins(iter));
    plotdataNTSxy(1,iter) = nbins(iter);
    plotdataNTSxy(2,iter) = mean_ignorezero(lenvec,tol);
    
    lenvec = leaningALT(dx,y,nbins(iter));
    plotdataNTSdxy(1,iter) = nbins(iter);
    plotdataNTSdxy(2,iter) = mean_ignorezero(lenvec,tol);
    
    lenvec = leaningALT(x,dy,nbins(iter));
    plotdataNTSxdy(1,iter) = nbins(iter);
    plotdataNTSxdy(2,iter) = mean_ignorezero(lenvec,tol);
    
    lenvec = leaningALT(dx,dy,nbins(iter));
    plotdataNTSdxdy(1,iter) = nbins(iter);
    plotdataNTSdxdy(2,iter) = mean_ignorezero(lenvec,tol);
    
    lenvec = leaningALT(x,dx,nbins(iter));
    plotdataNTSxdx(1,iter) = nbins(iter);
    plotdataNTSxdx(2,iter) = mean_ignorezero(lenvec,tol);
    
    lenvec = leaningALT(y,dy,nbins(iter));
    plotdataNTSydy(1,iter) = nbins(iter);
    plotdataNTSydy(2,iter) = mean_ignorezero(lenvec,tol);
    
end;

figure(1);
hold on;
plot(plotdataNTSxy(1,:),plotdataNTSxy(2,:),'bo','MarkerSize',12);
plot(plotdataNTSdxy(1,:),plotdataNTSdxy(2,:),'rx','MarkerSize',12);
plot(plotdataNTSxdy(1,:),plotdataNTSxdy(2,:),'g.','MarkerSize',12);
plot(plotdataNTSdxdy(1,:),plotdataNTSdxdy(2,:),'kv','MarkerSize',12);
plot(plotdataNTSxdx(1,:),plotdataNTSxdx(2,:),'y^','MarkerSize',12);
plot(plotdataNTSydy(1,:),plotdataNTSydy(2,:),'c>','MarkerSize',12);
title('Notional TS (L = 25); Expect dx DRIVES dy');
xlabel('number of bins in histograms');
ylabel('leanings');
l1 = sprintf('xy; final = %.5f, max = %.5f',plotdataNTSxy(2,end),max(plotdataNTSxy(2,:)));
l2 = sprintf('dxy; final = %.5f, max = %.5f',plotdataNTSdxy(2,end),max(plotdataNTSdxy(2,:)));
l3 = sprintf('xdy; final = %.5f, max = %.5f',plotdataNTSxdy(2,end),max(plotdataNTSxdy(2,:)));
l4 = sprintf('dxdy; final = %.5f, max = %.5f',plotdataNTSdxdy(2,end),max(plotdataNTSdxdy(2,:)));
l5 = sprintf('xdx; final = %.5f, max = %.5f',plotdataNTSxdx(2,end),max(plotdataNTSxdx(2,:)));
l6 = sprintf('ydy; final = %.5f, max = %.5f',plotdataNTSydy(2,end),max(plotdataNTSydy(2,:)));
legend(l1,l2,l3,l4,l5,l6);
grid on;
hold off;

clear nbins x y dx dy

% nbins = 2:1:250;
% B = 0.001:0.05:0.99;
% plotdataLxTSxy = zeros(length(B),length(nbins));
% plotdataLxTSdxy = zeros(length(B),length(nbins));
% plotdataLxTSxdy = zeros(length(B),length(nbins));
% plotdataLxTSdxdy = zeros(length(B),length(nbins));
% for iter = 1:1:length(nbins),
%     for iter2 = 1:1:length(B),
% 
%         [x,y,dx,dy] = LinearEx(B(iter2));
%         fprintf('LinearEx Sine TS; nbins = %i, B = %.3f\n',nbins(iter),B(iter2));
%         
%         lenvec = leaningALT(x,y,nbins(iter));
%         plotdataLxTSxy(iter2,iter) = mean_ignorezero(lenvec,tol);
%         
%         lenvec = leaningALT(dx,y,nbins(iter));
%         plotdataLxTSdxy(iter2,iter) = mean_ignorezero(lenvec,tol);
%         
%         lenvec = leaningALT(x,dy,nbins(iter));
%         plotdataLxTSxdy(iter2,iter) = mean_ignorezero(lenvec,tol);
%         
%         lenvec = leaningALT(dx,dy,nbins(iter));
%         plotdataLxTSdxdy(iter2,iter) = mean_ignorezero(lenvec,tol);
%         
%     end;
% end;

load leaning_plot.mat

figure(2);
hold on;
imagesc(B,nbins,plotdataLxTSxy)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect x DRIVES y (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;

figure(3);
hold on;
imagesc(B,nbins,plotdataLxTSdxy)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect dx DRIVES y (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;

figure(4);
hold on;
imagesc(B,nbins,plotdataLxTSxdy)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect x DRIVES dy (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;

figure(5);
hold on;
imagesc(B,nbins,plotdataLxTSdxdy)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect dx DRIVES dy (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;


figure(6);
hold on;
temp = plotdataLxTSxy;
temp(temp<0) = -1;
temp(temp>0) = 1;
cmap = colormap(flipud(gray(2)));
imagesc(B,nbins,temp)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect x DRIVES y (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;

figure(7);
hold on;
temp = plotdataLxTSdxy;
temp(temp<0) = -1;
temp(temp>0) = 1;
cmap = colormap(flipud(gray(2)));
imagesc(B,nbins,temp)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect dx DRIVES y (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;

figure(8);
hold on;
temp = plotdataLxTSxdy;
temp(temp<0) = -1;
temp(temp>0) = 1;
cmap = colormap(flipud(gray(2)));
imagesc(B,nbins,temp)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect x DRIVES dy (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;

figure(9);
hold on;
temp = plotdataLxTSdxdy;
temp(temp<0) = -1;
temp(temp>0) = 1;
cmap = colormap(flipud(gray(2)));
imagesc(B,nbins,temp)
axis([min(B) max(B) 2 max(nbins)]);
title('Sine TS (L = 2000); Expect dx DRIVES dy (positive number)');
xlabel('B');
ylabel('number of bins in histograms');
colorbar();
hold off;
