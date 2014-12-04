[x,y] = wTS(20,0.3,[1 5 15],[2 2 2]);
tol = 1e-16;
lags = [-2 -1 0 1 2];

nbinsV = 2:1:20;
lenV = nan(length(nbinsV),length(lags));

for iter = 1:1:length(nbinsV),
    lenvec = laggedlean(x,y,nbinsV(iter),tol,lags);
    lenV(iter,:) = lenvec;
end;

figure(1);
hold on;
plot(nbinsV,lenV(:,1),'bo','MarkerSize',12);
plot(nbinsV,lenV(:,2),'rx','MarkerSize',12);
plot(nbinsV,lenV(:,3),'g.','MarkerSize',12);
plot(nbinsV,lenV(:,4),'kv','MarkerSize',12);
plot(nbinsV,lenV(:,5),'y^','MarkerSize',12);
title('Clean Impulse TS (L = 20, B = 0.3); \Delta_{y_t x_{t+i}}');
xlabel('number of bins in histograms');
ylabel('leanings');
l1 = sprintf('i = -2');
l2 = sprintf('i = -1');
l3 = sprintf('i = 0');
l4 = sprintf('i = 1');
l5 = sprintf('i = 2');
legend(l1,l2,l3,l4,l5);
grid on;
hold off;
