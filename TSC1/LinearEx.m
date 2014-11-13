function [x,y,xd,yd] = LinearEx(B),

t = [0:0.05:100];
x = sin(t);

A = 1.0;
%B = 0.01;

y = zeros(length(x),1);
for iter = 2:1:length(x),
    y(iter) = A*x(iter-1) + B*rand();
end

xd = zeros(length(x),1);
for iter = 2:1:(length(x)),
    xd(iter,1) = x(iter)-x(iter-1);
end;

yd = zeros(length(y),1);
for iter = 2:1:(length(y)),
    yd(iter,1) = y(iter)-y(iter-1);
end;