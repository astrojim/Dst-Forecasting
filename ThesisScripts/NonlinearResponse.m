function [x,y] = NonlinearResponse(liblength,stepsize,a,b,c,d,e,f,g)

% build impulse signal
t = 0:stepsize:liblength;
x = a.*sin(b.*t+c)+d*randn(size(t));

% build noisy response
y = zeros(1,length(x));
for iter = 2:1:length(y),
    y(iter) = e*x(iter-1)*(1-f*x(iter-1)) + g*randn();
end;
