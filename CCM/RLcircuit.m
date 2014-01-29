function Iprime = RLcircuit(t,I)
% RLcircuit: Computes the RHS of the RL circuit ODE

VRL = [5.0 0.5 10.0];
%V = VRL(1);
tspan = [0:0.5:50];
%{
Vv = zeros(size(tspan));
Vv(15:20) = [0.1:0.1:0.6];
Vv(21:25) = [0.5:-0.1:0.1];
Vv(45:50) = [0.1:0.1:0.6];
Vv(51:55) = [0.5:-0.1:0.1];
%}
Vv = sin(tspan);
%rng(1);
%rand('seed',100);
%Vv = rand(size(tspan));

R0 = 1;
RR = zeros(size(tspan))+R0;
RR(10:24) = [1.0:-0.05:0.3];
RR(25:38) = [0.35:0.05:1.0];
RR(40:54) = [1.0:-0.05:0.3];
RR(55:68) = [0.35:0.05:1.0];

%RR = 0.5*sin(0.5*tspan)+0.5;

V = interp1(tspan,Vv,t);
R = interp1(tspan,RR,t);
L = VRL(3);

Iprime = (V/L) - (I*(R/L));

