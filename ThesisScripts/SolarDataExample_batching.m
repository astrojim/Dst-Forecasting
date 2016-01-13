
% set number of batches
numbatch = 150;

% start batch number 
startbatch = 1;

% set number samples
numsamps = 100;

% set save directory
savedir = 'SolarDataBatches';

% run batches
for batch = startbatch:1:(startbatch+numbatch),
    
    SolarDataExample_sampling
    
    save(sprintf('%s/SolarDataBatchLongSamp_%i.mat',savedir,batch));
    
    clearvars -except batch numsamps numbatch savedir
    
end;