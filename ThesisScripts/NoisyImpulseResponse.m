[x,y] = NoisyImpulseResponse(liblength,hitspace,hitpeak,C,B)
% C - impulse noise level
% B - response noise level
% liblength - signal length (library length)
% hitspace - spacing for impulses
% hitpeak - impulse peak

% build impulse signal
hititer = 0;
x = randn(1,liblength).*C;
x(2) = hitpeak;
for xiter = 2:1:liblength,
    if( hititer > hitspace ),
        x(xiter) = hitpeak;
        hititer = 0;
    end;
    hititer = hititer + 1;
end;

% build noisy response
y = zeros(1,length(x));
for iter = 2:1:length(y),
    y(iter) = x(iter-1) + B*randn();
end;
