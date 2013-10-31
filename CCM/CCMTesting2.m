x0=[-8 8 27];
%tspan=[0,20];
tspan = [0:0.5:20];
p=[10 8/3 28];
%[t,x]=ode45(@Lorenz,tspan,x0,[],p);
x = lsode("Lorenz",x0,tspan);
%plot(t,x(1,:))
%x

CCM(x(:,1),x(:,2),2,1)
CCM(x(:,2),x(:,1),2,1)
CCM(x(:,1),x(:,3),2,1)
CCM(x(:,3),x(:,1),2,1)
CCM(x(:,2),x(:,3),2,1)
CCM(x(:,3),x(:,2),2,1)

%{
B = [0:0.001:0.5];
L = 1000;
plotdataX = zeros(L,length(B));
plotdataY = zeros(L,length(B));
for bstep = 1:1:length(B),
	data = Henon(0,0,1.4,B(bstep),L);
    plotdataX(:,bstep) = data(1,:);
    plotdataY(:,bstep) = data(2,:);
end;
imagesc(plotdataX)
%imagesc(plotdataY)
%}
