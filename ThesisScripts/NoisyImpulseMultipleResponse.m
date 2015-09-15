function [x,y,z1,z2,z3] = NoisyImpulseMultipleResponse(liblength,hitspace,hitpeak,A,B)
% A - impulse noise level
% B - response noise level
% liblength - signal length (library length)
% hitspace - spacing for impulses
% hitpeak - impulse peak

% build impulse signal
hititer = 0;
x = randn(1,liblength).*A;
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
z1 = zeros(1,length(x));
z2 = zeros(1,length(x));
z3 = zeros(1,length(x));
for iter = 2:1:length(y),
    y(iter) = x(iter-1) + B*randn();
    z1(iter) = y(iter-1);
    z2(iter) = y(iter-1) + y(iter);
    z3(iter) = y(iter-1) + x(iter-1) + z3(iter-1);
end;
