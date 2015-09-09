function [x,y] = CoupledLogisticMap(liblength,xo,yo,rx,ry,Bxy,Byx)

x = zeros(liblength,1);
y = x;

x(1) = xo;
y(1) = yo;
for fstep = 1:(length(x)-1),
    x(fstep+1) = x(fstep)*(rx-rx*x(fstep)-Bxy*y(fstep));
    y(fstep+1) = y(fstep)*(ry-ry*y(fstep)-Byx*x(fstep));
end;

x = x';
y = y';