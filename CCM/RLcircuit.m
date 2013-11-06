function Iprime = RLcircuit(t,I)
% RLcircuit: Computes the RHS of the RL circuit ODE

tspan = [0:0.5:50];

%vV = zeros(size(tspan));
%vV(15:20) = [0.1:0.1:0.6];
%vV(21:25) = [0.5:-0.1:0.1];
%vV(45:50) = [0.1:0.1:0.6];
%vV(51:55) = [0.5:-0.1:0.1];
%vV = sin(tspan);

rand('seed',100);
vV = rand(size(tspan));


V = interp1(tspan,vV,t);
R = 0.5;
L = 10;

Iprime = (V/L) - (I*(R/L));
