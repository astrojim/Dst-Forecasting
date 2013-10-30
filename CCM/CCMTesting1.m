L = 500;
Edim = 2;
tau = 1;
Bxy_vec = [0.01:0.005:1.0];
Byx_vec = [0.01:0.005:1.0];

plotdata = zeros(length(Byx_vec),length(Bxy_vec),2);
for bxystep = 1:length(Bxy_vec),
	for byxstep = 1:length(Byx_vec),
		
        fprintf('%i,%i\n',bxystep,byxstep);
        % fake data
		X = zeros(L,1);
		Y = X;
		X(1) = 0.4;
		Y(1) = 0.2;
		rx = 3.8;
		ry = 3.5;
		Bxy = Bxy_vec(bxystep);
		Byx = Byx_vec(byxstep);
		for fstep = 1:(length(X)-1),
			X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    		Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
		end;  

		plotdata(byxstep,bxystep,1) = CCM(Y,X,Edim,tau);
		plotdata(byxstep,bxystep,2) = CCM(X,Y,Edim,tau);

	end;
end;

Delta = plotdata(:,:,1)-plotdata(:,:,2);

% CxyCyxVByxBxy_diff.png
imagesc(Delta)
title('\Delta versus \beta_{yx} and \beta_{xy}')
ylabel('\beta_{yx}');
xlabel('\beta_{xy}');


%{
% CxyCyxVByx_raw.png
plot(Byx_vec,reshape(plotdata(:,1,1),length(Byx_vec),1),'.',Byx_vec,reshape(plotdata(:,1,2),length(Byx_vec),1),'o')
title('C_{XY} and C_{YX} versus \beta_{yx}')
ylabel('Directed Correlation');
xlabel('\beta_{yx}');
legend('C_{XY}','C_{YX}','Location','SouthEast');
grid on;

% CxyCyxVByx_diff.png
plot(Byx_vec,Delta,'^')
title('\Delta = C_{XY} - C_{YX} versus \beta_{yx}')
ylabel('\Delta');
xlabel('\beta_{yx}');
grid on;
%}