number_of_samples = 30;
bootstrap_library_length = 100;
population_library_length = 1000;
eDim = 3;
tau = 1;
plotdataDelta = zeros(number_of_samples,3);

population_data = SantaFeData(population_library_length);

for lstep = 1:1:number_of_samples,

    rnd_starting_point = floor(1+rand()*(population_library_length-bootstrap_library_length));
    
    bootstrap_data = population_data(rnd_starting_point:(rnd_starting_point+bootstrap_library_length),:);
	heart_rate = bootstrap_data(:,1);
	chest_volume = bootstrap_data(:,2);
	blood_oxygen = bootstrap_data(:,3);

	hc = CCM(heart_rate,chest_volume,eDim,tau);
	ch = CCM(chest_volume,heart_rate,eDim,tau);
	cb = CCM(chest_volume,blood_oxygen,eDim,tau);
	bc = CCM(blood_oxygen,chest_volume,eDim,tau);
	hb = CCM(heart_rate,blood_oxygen,eDim,tau);
	bh = CCM(blood_oxygen,heart_rate,eDim,tau);

	plotdataDelta(lstep,1) = hc-ch;
    plotdataDelta(lstep,2) = cb-bc;
    plotdataDelta(lstep,3) = hb-bh;
 
end;

figure(1);
subplot(2,3,1);
plot(1:1:number_of_samples,plotdataDelta(:,1),'.',1:1:number_of_samples,mean(plotdataDelta(:,1)),'-',1:1:number_of_samples,mean(plotdataDelta(:,1))+std(plotdataDelta(:,1)),'.-',1:1:number_of_samples,mean(plotdataDelta(:,1))-std(plotdataDelta(:,1)),'.-');
subplot(2,3,4);
hist(plotdataDelta(:,1),25)
subplot(2,3,2);
plot(1:1:number_of_samples,plotdataDelta(:,2),'.',1:1:number_of_samples,mean(plotdataDelta(:,2)),'-',1:1:number_of_samples,mean(plotdataDelta(:,2))+std(plotdataDelta(:,2)),'.-',1:1:number_of_samples,mean(plotdataDelta(:,2))-std(plotdataDelta(:,2)),'.-');
subplot(2,3,5);
hist(plotdataDelta(:,2),25)
subplot(2,3,3);
plot(1:1:number_of_samples,plotdataDelta(:,3),'.',1:1:number_of_samples,mean(plotdataDelta(:,3)),'-',1:1:number_of_samples,mean(plotdataDelta(:,3))+std(plotdataDelta(:,3)),'.-',1:1:number_of_samples,mean(plotdataDelta(:,3))-std(plotdataDelta(:,3)),'.-');
subplot(2,3,6);
hist(plotdataDelta(:,3),25)