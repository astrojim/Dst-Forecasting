%function xprime = Lorenz(t,x,p);
function xprime = Lorenz(x,t);
%LORENZ: Computes the derivatives involved in solving the Lorenz equations.
%p=[10 8/3 28];
p=[10 0.01 28];
sig = p(1); 
beta = p(2); 
rho = p(3);
xprime=[-sig*x(1) + sig*x(2); rho*x(1) - x(2) - x(1)*x(3); -beta*x(3) + x(1)*x(2)];
