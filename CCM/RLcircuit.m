function Iprime = RLcircuit(t,I)
% RLcircuit: Computes the RHS of the RL circuit ODE

VRL = RLcircuitVRL(t);

V = VRL(1);
R = VRL(2);
L = VRL(3);

Iprime = (V/L) - (I*(R/L));

