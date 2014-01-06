function [] = plotfunc_DCORRvec(X,Y,Xname,Yname)

addpath('../utils');
theta = atan(Y/X);       
magnitude = sqrt(X^2+Y^2);
axis([0 1 0 1]);
axis square;
arrow([0 0],[X Y]);
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

