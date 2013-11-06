x0 = 0;
%tspan=[0,20];
tspan = [0:0.5:50];

%V = zeros(size(tspan));
%V(15:20) = [0.1:0.1:0.6];
%V(21:25) = [0.5:-0.1:0.1];
%V(45:50) = [0.1:0.1:0.6];
%V(51:55) = [0.5:-0.1:0.1];
%V = sin(tspan);

rand('seed',100);
V = rand(size(tspan));

[t,x]=ode45(@RLcircuit,tspan,x0);

figure(1);
plot(tspan,V,'.',tspan,x,'o')
title('Voltage and Current Time Series for RL Circuit');
xlabel('t');
ylabel('V,I');
legend('V','I','Location','NorthEast');
grid on;

figure(2);
Edim = [2:1:10];
tau = 1;%[1:1:4];
plotdata = zeros(length(Edim),length(tau),2);
for taustep = 1:1:length(tau),
	for estep = 1:1:length(Edim),
		plotdata(estep,taustep,1) = CCM(V,x,Edim(estep),tau(taustep));
		plotdata(estep,taustep,2) = CCM(x,V,Edim(estep),tau(taustep));
    end;
end;

plot(Edim,plotdata(:,1,1),'.',Edim,plotdata(:,1,2),'o')
title('C_{VI} and C_{IV} for Trig V Signals');
xlabel('t');
ylabel('directed correlation');
legend('C_{IV}','C_{VI}','Location','SouthEast');
grid on;
%imagesc(plotdata(:,:,1))
%imagesc(plotdata(:,:,2))
