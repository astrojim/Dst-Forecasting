function [x,y] = NoisyCyclicImpulseResponse(liblength,stepsize,a,b,c,d,e)

% build impulse signal
t = 0:stepsize:liblength;
x = a.*sin(b.*t+c)+d*randn(size(t));

% build noisy response
y = zeros(1,length(x));
for iter = 2:1:length(y),
    y(iter) = x(iter-1) + e*randn();
end;
