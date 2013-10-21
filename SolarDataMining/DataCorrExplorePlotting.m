% Compare correlation and electron flux data
figure(1);
subplot(2,1,1);
imagesc(log10(MeV_e_Flux));
ylabel('time');
subplot(2,1,2);
plot(1:90,abs(Dst_MeV_e_Flux),1:90,abs(Sunspot_MeV_e_Flux),...
    1:90,abs(Plasma_MeV_e_Flux),1:90,abs(Bz_MeV_e_Flux));
xlabel('L radius');
ylabel('correlation');
legend('Dst','sunspot','plasma bulk speed','Bz_{GSE}');

figure(2);
subplot(3,1,1);
imagesc(log10(MeV_e_Flux)');
ylabel('L radius');
subplot(3,1,2);
plot(Sunspot_number_daily);
xlabel('time');
ylabel('coount');
subplot(3,1,3);
plot(Plasma_bulk_speed_daily);
xlabel('time');
ylabel('coount');

figure(3);
subplot(2,2,1);
plot(1:90,Dst_e_Flux_CCM(:,1),1:90,Dst_e_Flux_CCM(:,2));
xlabel('L radius');
ylabel('Correlation');
legend('Dst\rightarrow eFlux','eFlux\rightarrow Dst');
subplot(2,2,2);
plot(1:90,Sunspot_e_Flux_CCM(:,1),1:90,Sunspot_e_Flux_CCM(:,2));
xlabel('L radius');
ylabel('Correlation');
legend('Sunspot\rightarrow eFlux','eFlux\rightarrow Sunspot');
subplot(2,2,3);
plot(1:90,Plasma_e_Flux_CCM(:,1),1:90,Plasma_e_Flux_CCM(:,2));
xlabel('L radius');
ylabel('Correlation');
legend('Plasma bulk speed\rightarrow eFlux','eFlux\rightarrow Plasma bulk speed');
subplot(2,2,4);
plot(1:90,Bz_e_Flux_CCM(:,1),1:90,Bz_e_Flux_CCM(:,2));
xlabel('L radius');
ylabel('Correlation');
legend('Bz\rightarrow eFlux','eFlux\rightarrow Bz');

fprintf('Dst -> Sunspot: %d\n',Dst_Sunspot_CCM(1));
fprintf('Sunspot - > Dst: %d\n',Dst_Sunspot_CCM(2));

fprintf('Dst -> Plasma Bulk Speed: %d\n',Dst_Plasma_CCM(1));
fprintf('Plasma Bulk Speed - > Dst: %d\n',Dst_Plasma_CCM(2));

fprintf('Dst -> Bz_GSE: %d\n',Dst_Bz_CCM(1));
fprintf('Bz_GSE - > Dst: %d\n',Dst_Bz_CCM(2));

