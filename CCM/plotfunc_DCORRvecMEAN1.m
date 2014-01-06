function [] = plotfunc_DCORRvecMEAN1(X,Y,Xname,Yname)

addpath('../utils');
xmean = nanmean(X);
ymean = nanmean(Y);
theta = atan(ymean/xmean);       
magnitude = sqrt(xmean^2+ymean^2);
axis([0 1 0 1]);
axis square;
arrow([0 0],[xmean ymean]);
hold;
grid on;
plot(0:0.1:1,0:0.1:1,'--k');
Xstring = sprintf('%s -> %s',Xname,Yname);
Ystring = sprintf('%s -> %s',Yname,Xname);
xlabel(Xstring);
ylabel(Ystring);
titlestring = sprintf('Directed Corrletion of (|D|,D_{angle}) = (%f,%f) for %s and %s',magnitude,theta,Xname,Yname); 
title(titlestring);

return;

