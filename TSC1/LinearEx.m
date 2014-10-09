t = [0:0.1:100];
x = sin(t);

A = 1.0;
B = 0.1;

y = zeros(length(x),1);
for iter = 2:1:length(x),
    y(iter) = A*x(iter-1) + B*rand();
end

xd = zeros(length(x)-1,1);
for iter = 1:1:(length(x)-1),
    xd(iter,1) = x(iter+1)-x(iter);
end;

yd = zeros(length(y)-1,1);
for iter = 1:1:(length(y)-1),
    yd(iter,1) = y(iter+1)-y(iter);
end;