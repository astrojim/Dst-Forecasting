function [] = plotfunc_DCORRhist3(X,Y,Xname,Yname,nBins)

hist3data = [X',Y'];
n = hist3(hist3data,[nBins nBins]);
n1 = n';
n1(size(n,1) + 1, size(n,2) + 1) = 0;
xb = linspace(min(hist3data(:,1)),max(hist3data(:,1)),size(n,1)+1);
yb = linspace(min(hist3data(:,2)),max(hist3data(:,2)),size(n,1)+1);
h = pcolor(xb,yb,n1);
set(h, 'zdata', ones(size(n1)) * -max(max(n)));
colormap(jet);
colorbar;
Xstring = sprintf('%s -> %s',Xname,Yname);
Ystring = sprintf('%s -> %s',Yname,Xname);
xlabel(Xstring);
ylabel(Ystring);
h1 = colorbar;
ylabel(h1, 'point count');
titlestring = sprintf('Point Density Histogram of CCM Correlation Points (%s,%s)',Xname,Yname); 
title(titlestring);

return;
