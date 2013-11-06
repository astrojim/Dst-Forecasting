L = 100;%[10:1:500];
Edim = 2;%[2:1:50];
tau = [1:1:25];

plotdata = zeros(length(L),length(Edim),length(tau),2);
for taustep = 1:length(tau),
	for estep = 1:length(Edim),
		for lstep = 1:length(L),
        	fprintf('%i,%i,%i\n',taustep,estep,lstep);
        	% fake data
			X = zeros(L(lstep),1);
			Y = X;
			X(1) = 0.4;
			Y(1) = 0.2;
			rx = 3.8;
			ry = 3.5;
			Bxy = 0.01;
			Byx = 0.2;
			for fstep = 1:(length(X)-1),
				X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    			Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
			end;  

			plotdata(lstep,estep,taustep,1) = CCM(Y,X,Edim(estep),tau(taustep));
			plotdata(lstep,estep,taustep,2) = CCM(X,Y,Edim(estep),tau(taustep));
		end;
	end;
end;

%{
% CxyCyxVL.png
plot(1:length(L),plotdata(:,1,1),'.',1:length(L),plotdata(:,1,2),'o')
title('C_{XY} and C_{YX} versus library length L')
ylabel('Directed Correlation');
xlabel('L');
legend('C_{XY}','C_{YX}','Location','SouthEast');
grid on;
%}

%{
% CxyCyxVE.png
plot(1:length(Edim),reshape(plotdata(1,:,1,1),length(Edim),1),'.',1:length(Edim),reshape(plotdata(1,:,1,2),length(Edim),1),'o')
title('C_{XY} and C_{YX} versus embedding dimension E')
ylabel('Directed Correlation');
xlabel('E');
legend('C_{XY}','C_{YX}','Location','NorthEast');
grid on;
%}


% CxyCyxVtau.png
plot(1:length(tau),reshape(plotdata(1,1,:,1),length(tau),1),'.',1:length(tau),reshape(plotdata(1,1,:,2),length(tau),1),'o')
title('C_{XY} and C_{YX} versus time step \tau')
ylabel('Directed Correlation');
xlabel('\tau');
legend('C_{XY}','C_{YX}','Location','NorthEast');
grid on;


%imagesc(plotdata(:,:,1,1))
%imagesc(plotdata(:,:,1,2))
