%addpath('./SolarDataMining');

load L1000with3000samples.mat;

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