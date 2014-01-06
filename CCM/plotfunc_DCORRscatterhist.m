function [] = plotfunc_DCORRscatterhist(X,Y,Xname,Yname,nBins)

scatterhist(X,Y,[nBins nBins]);
axis([0 1 0 1]);
axis square;
hold;
grid on;
plot(0:0.1:1,0:0.1:1,'-k');
Xstring = sprintf('%s -> %s',Xname,Yname);
Ystring = sprintf('%s -> %s',Yname,Xname);
xlabel(Xstring);
ylabel(Ystring);
titlestring = sprintf('Scatterplot of CCM Correlation Points (%s,%s) with individual CCM Correlation Histograms',Xname,Yname); 
title(titlestring);

return;

