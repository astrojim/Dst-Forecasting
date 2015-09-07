function [x,y_an,y_num] = RLCircuitResponse(endtime,stepsize,R,LL)
% make sure globals are set before calling this function
global tspan;
global Vv;
global RR;
global L;

% build impulse signal
t = 0:stepsize:endtime;
Vv = sin(t);
RR = R.*ones(length(t),1);
x = Vv;
L = LL;

% build analytical response
tspan = t;
Denom = L^2+RR(1)^2;
Eterm = (L/Denom).*exp((-RR(1)/L).*tspan);
Sterm = (RR(1)/Denom).*sin(tspan);
Cterm = (L/Denom).*cos(tspan);
Ian = Eterm+Sterm-Cterm;
y_an = Ian;

% build numerical response
Ix0 = 0;
[tx Ix45] = ode45('RLcircuit',t,Ix0);
y_num = Ix45';