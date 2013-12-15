number_of_samples = 2500;
%seed_value_rx = 12;
%seed_value_ry = 34;
%seed_value_Xo = 56;
%seed_value_Yo = 78;
mean_rx = 3.8;%3.8;
mean_ry = 3.5;%3.5;
mean_Xo = 0.4;%0.4;
mean_Yo = 0.2;%0.2;
var_rx = 0.05;
var_ry = 0.05;
var_Xo = 0.2;
var_Yo = 0.2;
library_length = 1000;

Bxy = 0.02;%0.02;
Byx = 0.1;%0.1;

plotdataCCM = zeros(number_of_samples,1);

for sampstep = 1:1:number_of_samples,

	X = zeros(library_length,1);
	Y = X;
	X(1) = abs(normrnd(mean_Xo,var_Xo,1,1));
	Y(1) = abs(normrnd(mean_Yo,var_Yo,1,1));
	rx = abs(normrnd(mean_rx,var_rx,1,1));
	ry = abs(normrnd(mean_ry,var_ry,1,1));
            
	for fstep = 1:(length(X)-1),
		X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    	Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
	end;
    
    %{
    X
    Y
    plot(X)
    plot(Y)
    %}
    
    fprintf('%i : %f,%f,%f,%f -- %f,%f\n',sampstep,X(1),Y(1),rx,ry,mean(X),mean(Y));
    CCM_XY = CCM(Y,X,3,1);
    CCM_YX = CCM(X,Y,3,1);
    plotdataCCM(sampstep,1) = CCM_YX-CCM_XY;

end;

%plotdataCCM

figure(1);
subplot(2,1,1);
plot(1:1:number_of_samples,plotdataCCM,'.',1:1:number_of_samples,mean(plotdataCCM),'-',1:1:number_of_samples,mean(plotdataCCM)+std(plotdataCCM),'.-',1:1:number_of_samples,mean(plotdataCCM)-std(plotdataCCM),'.-');
subplot(2,1,2);
hist(plotdataCCM,100)