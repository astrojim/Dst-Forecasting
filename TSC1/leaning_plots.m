% x = [0,1,2,1,0];
% y = [0,0,1,2,1];
% dx = [0,1,1,-1,-1];
% dy = [0,0,1,1,-1];

x = [0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0];
y = [0,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1,0,1,2,1];
dx = [0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1];
dy = [0,0,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,-1,1,1,-1,];

nbins = 2:1:length(x);
plotdataNTSxy = zeros(2,length(nbins));
plotdataNTSdxy = zeros(2,length(nbins));
plotdataNTSxdy = zeros(2,length(nbins));
plotdataNTSdxdy = zeros(2,length(nbins));
for iter = 1:1:length(nbins),
    
    fprintf('Notional TS; nbins = %i\n',nbins(iter));
    
    lenvec = leaning(x,y,nbins(iter));
    plotdataNTSxy(1,iter) = nbins(iter);
    plotdataNTSxy(2,iter) = mean(lenvec);
    
    lenvec = leaning(dx,y,nbins(iter));
    plotdataNTSdxy(1,iter) = nbins(iter);
    plotdataNTSdxy(2,iter) = mean(lenvec);
    
    lenvec = leaning(x,dy,nbins(iter));
    plotdataNTSxdy(1,iter) = nbins(iter);
    plotdataNTSxdy(2,iter) = mean(lenvec);
    
    lenvec = leaning(dx,dy,nbins(iter));
    plotdataNTSdxdy(1,iter) = nbins(iter);
    plotdataNTSdxdy(2,iter) = mean(lenvec);
    
end;

figure(1);
hold on;
plot(plotdataNTSxy(1,:),plotdataNTSxy(2,:),'bo','MarkerSize',12);
plot(plotdataNTSdxy(1,:),plotdataNTSdxy(2,:),'rx','MarkerSize',12);
plot(plotdataNTSxdy(1,:),plotdataNTSxdy(2,:),'g.','MarkerSize',12);
plot(plotdataNTSdxdy(1,:),plotdataNTSdxdy(2,:),'kv','MarkerSize',12);
title('Notional TS (L = 25); Expect dx DRIVES dy');
xlabel('number of bins in histograms');
ylabel('leanings');
l1 = sprintf('xy; final = %.5f, max = %.5f',plotdataNTSxy(2,end),max(plotdataNTSxy(2,:)));
l2 = sprintf('dxy; final = %.5f, max = %.5f',plotdataNTSdxy(2,end),max(plotdataNTSdxy(2,:)));
l3 = sprintf('xdy; final = %.5f, max = %.5f',plotdataNTSxdy(2,end),max(plotdataNTSxdy(2,:)));
l4 = sprintf('dxdy; final = %.5f, max = %.5f',plotdataNTSdxdy(2,end),max(plotdataNTSdxdy(2,:)));
legend(l1,l2,l3,l4);
grid on;
hold off;

clear nbins x y dx dy

nbins = 2:1:150;
B = 0.001:0.05:0.99;
plotdataLxTSxy = zeros(3,length(nbins));
plotdataLxTSdxy = zeros(3,length(nbins));
plotdataLxTSxdy = zeros(3,length(nbins));
plotdataLxTSdxdy = zeros(3,length(nbins));
for iter = 1:1:length(nbins),
    for iter2 = 1:1:length(B),

        [x,y,dx,dy] = LinearEx(B(iter2));
        fprintf('LinearEx Sine TS; nbins = %i, B = %.3f\n',nbins(iter),B(iter2));
        
        lenvec = leaning(x,y,nbins(iter));
        plotdataLxTSxy(1,iter) = nbins(iter);
        plotdataLxTSxy(2,iter) = B(iter2);
        plotdataLxTSxy(3,iter) = mean(lenvec);
        
        lenvec = leaning(dx,y,nbins(iter));
        plotdataLxTSdxy(1,iter) = nbins(iter);
        plotdataLxTSdxy(2,iter) = B(iter2);
        plotdataLxTSdxy(3,iter) = mean(lenvec);
        
        lenvec = leaning(x,dy,nbins(iter));
        plotdataLxTSxdy(1,iter) = nbins(iter);
        plotdataLxTSxdy(2,iter) = B(iter2);
        plotdataLxTSxdy(3,iter) = mean(lenvec);
        
        lenvec = leaning(dx,dy,nbins(iter));
        plotdataLxTSdxdy(1,iter) = nbins(iter);
        plotdataLxTSdxdy(2,iter) = B(iter2);
        plotdataLxTSdxdy(3,iter) = mean(lenvec);
        
    end;
end;