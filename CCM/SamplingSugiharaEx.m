number_of_samples = 3000;
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
var_Xo = 0.1;
var_Yo = 0.1;
library_length = [1000];

Bxy = 0.02;%0.02;
Byx = 0.1;%0.1;

plotdataCCM = zeros(length(library_length),number_of_samples);

for llstep = 1:1:length(library_length),
    for sampstep = 1:1:number_of_samples,

        X = zeros(library_length(llstep),1);
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

        fprintf('(%i) %i : %f,%f,%f,%f -- %f,%f',library_length(llstep),...
                 sampstep,X(1),Y(1),rx,ry,mean(X),mean(Y));
        CCM_XY = CCM(Y,X,3,1);
        CCM_YX = CCM(X,Y,3,1);
        Delta = CCM_YX-CCM_XY;
        plotdataCCM(llstep,sampstep) = Delta;
        fprintf(' => %f\n',Delta);
        
    end;
end;

%plotdataCCM

tolerance = 1E-12;
plotdata_filtered = plotdataCCM(1,abs(plotdataCCM(1,:)) >= tolerance);
figure(1);
subplot(2,1,1);
plot(1:1:number_of_samples,plotdata_filtered,'.',...
     1:1:number_of_samples,mean(plotdata_filtered),'-',...
     1:1:number_of_samples,mean(plotdata_filtered)+std(plotdata_filtered),'.-',...
     1:1:number_of_samples,mean(plotdata_filtered)-std(plotdata_filtered),'.-');
title('Samples shown with Mean and Mean+Std Bounds');
xlabel('sample number');
ylabel('\Delta');
subplot(2,1,2);
hist(plotdata_filtered,100)
title('Histogram of 3000 samples with L = 1000');
xlabel('\Delta bins');
ylabel('counts');


%imagesc(plotdataCCM);
%{
tolerance = 1E-2;
histimageplot = zeros(19,100);
temp = plotdataCCM(20,abs(plotdataCCM(20,:)) >= tolerance);
[histimageplot(19,:),centers] = hist(temp,100);
for stepstep = 1:18,
    temp = plotdataCCM(stepstep+1,abs(plotdataCCM(stepstep+1,:)) >= tolerance);
    [histimageplot(stepstep,:),centers] = hist(temp,centers);
end;
%}