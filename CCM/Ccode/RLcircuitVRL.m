function VRL = RLcircuitVRL(t)
%Coefficients for RLcircuit function

global tspan;
global Vv;
global RR;
global L;

V = interp1(tspan,Vv,t);
R = interp1(tspan,RR,t);

VRL = [V,R,L];