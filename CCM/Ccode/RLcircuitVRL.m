function VRL = RLcircuitVRL(t)
%Coefficients for RLcircuit function

global tspan;
global Omega;

L = 10;

Vv = sin(tspan);

A = 0.5;
R0 = 0.5;
Phi = 0.0;
RR = A.*sin(Omega.*tspan+Phi)+R0;

V = interp1(tspan,Vv,t);
R = interp1(tspan,RR,t);

VRL = [V,R,L];