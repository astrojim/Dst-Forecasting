figure(1);
plot(1:90,Dst_e_Flux_CCM_3(:,1)-Dst_e_Flux_CCM_3(:,2),...
     1:90,Dst_e_Flux_CCM_5(:,1)-Dst_e_Flux_CCM_5(:,2),...
     1:90,Dst_e_Flux_CCM_10(:,1)-Dst_e_Flux_CCM_10(:,2),...
     1:90,Dst_e_Flux_CCM_25(:,1)-Dst_e_Flux_CCM_25(:,2),...
     1:90,Dst_e_Flux_CCM_100(:,1)-Dst_e_Flux_CCM_100(:,2));
xlabel('L radius');
ylabel('Directed Correlation Difference');
legend('C_{Dst,eFlux} - C_{eFlux,Dst} E=3',...
       'C_{Dst,eFlux} - C_{eFlux,Dst} E=5',...
       'C_{Dst,eFlux} - C_{eFlux,Dst} E=10',...
       'C_{Dst,eFlux} - C_{eFlux,Dst} E=25',...
       'C_{Dst,eFlux} - C_{eFlux,Dst} E=100');

figure(2);
plot(1:90,Sunspot_e_Flux_CCM_3(:,1)-Sunspot_e_Flux_CCM_3(:,2),...
     1:90,Sunspot_e_Flux_CCM_5(:,1)-Sunspot_e_Flux_CCM_5(:,2),...
     1:90,Sunspot_e_Flux_CCM_10(:,1)-Sunspot_e_Flux_CCM_10(:,2),...
     1:90,Sunspot_e_Flux_CCM_25(:,1)-Sunspot_e_Flux_CCM_25(:,2),...
     1:90,Sunspot_e_Flux_CCM_100(:,1)-Sunspot_e_Flux_CCM_100(:,2));
xlabel('L radius');
ylabel('Directed Correlation Difference');
legend('C_{Sunspot,eFlux}-C_{eFlux,Sunspot} E=3',...
       'C_{Sunspot,eFlux}-C_{eFlux,Sunspot} E=5',...
       'C_{Sunspot,eFlux}-C_{eFlux,Sunspot} E=10',...
       'C_{Sunspot,eFlux}-C_{eFlux,Sunspot} E=25',...
       'C_{Sunspot,eFlux}-C_{eFlux,Sunspot} E=100');
