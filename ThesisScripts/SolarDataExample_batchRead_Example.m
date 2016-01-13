load SolarDataBatchedSetsLongSamp_20150924.mat

TEmean = mean(TEdata);
GCmean = mean(GCdata);
PAImean = mean(PAIdata);
Lmean = mean(Ldata);
LCCmean = mean(LCCdata);

TErmean = mean(TErdata);
GCrmean = mean(GCrdata);
PAIrmean = mean(PAIrdata);
Lrmean = mean(Lrdata);
LCCrmean = mean(LCCrdata);

TE_CI = [prctile(TEdata,5),prctile(TEdata,95)];
GC_CI = [prctile(GCdata,5),prctile(GCdata,95)];
PAI_CI = [prctile(PAIdata,5),prctile(PAIdata,95)];
L_CI = [prctile(Ldata,5),prctile(Ldata,95)];
LCC_CI = [prctile(LCCdata,5),prctile(LCCdata,95)];
TEr_CI = [prctile(TErdata,5),prctile(TErdata,95)];
GCr_CI = [prctile(GCrdata,5),prctile(GCrdata,95)];
PAIr_CI = [prctile(PAIrdata,5),prctile(PAIrdata,95)];
Lr_CI = [prctile(Lrdata,5),prctile(Lrdata,95)];
LCCr_CI = [prctile(LCCrdata,5),prctile(LCCrdata,95)];

% bootstrap
numsamps_boot = 1e5;

numsamps_origTE = length(TEdata);
numsamps_origGC = length(GCdata);
numsamps_origPAI = length(PAIdata);
numsamps_origL = length(Ldata);
numsamps_origLCC = length(LCCdata);
numsamps_origTEr = length(TErdata);
numsamps_origGCr = length(GCrdata);
numsamps_origPAIr = length(PAIrdata);
numsamps_origLr = length(Lrdata);
numsamps_origLCCr = length(LCCrdata);

bootstrap_meansTE = nan(numsamps_boot,1);
bootstrap_meansGC = nan(numsamps_boot,1);
bootstrap_meansPAI = nan(numsamps_boot,1);
bootstrap_meansL = nan(numsamps_boot,1);
bootstrap_meansLCC = nan(numsamps_boot,1);
bootstrap_meansTEr = nan(numsamps_boot,1);
bootstrap_meansGCr = nan(numsamps_boot,1);
bootstrap_meansPAIr = nan(numsamps_boot,1);
bootstrap_meansLr = nan(numsamps_boot,1);
bootstrap_meansLCCr = nan(numsamps_boot,1);

for run = 1:1:numsamps_boot
    
    fprintf(' -- bootstraping %i of %i [%.4f] ... ',run,numsamps_boot,run/numsamps_boot);
    tic;
    
    % TE
    rndindex = floor((numsamps_origTE-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = TEdata(rndindex);
    bootstrap_meansTE(run) = mean(bootstrap_samp);
    
    % GC
    rndindex = floor((numsamps_origGC-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = GCdata(rndindex);
    bootstrap_meansGC(run) = mean(bootstrap_samp);
    
    % PAI
    rndindex = floor((numsamps_origPAI-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = PAIdata(rndindex);
    bootstrap_meansPAI(run) = mean(bootstrap_samp);
    
    % L
    rndindex = floor((numsamps_origL-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = Ldata(rndindex);
    bootstrap_meansL(run) = mean(bootstrap_samp);
    
    % LCC
    rndindex = floor((numsamps_origLCC-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = LCCdata(rndindex);
    bootstrap_meansLCC(run) = mean(bootstrap_samp);

    % TE
    rndindex = floor((numsamps_origTEr-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = TErdata(rndindex);
    bootstrap_meansTEr(run) = mean(bootstrap_samp);
    
    % GC
    rndindex = floor((numsamps_origGCr-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = GCrdata(rndindex);
    bootstrap_meansGCr(run) = mean(bootstrap_samp);
    
    % PAI
    rndindex = floor((numsamps_origPAIr-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = PAIrdata(rndindex);
    bootstrap_meansPAIr(run) = mean(bootstrap_samp);
    
    % L
    rndindex = floor((numsamps_origLr-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = Lrdata(rndindex);
    bootstrap_meansLr(run) = mean(bootstrap_samp);
    
    % LCC
    rndindex = floor((numsamps_origLCCr-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = LCCrdata(rndindex);
    bootstrap_meansLCCr(run) = mean(bootstrap_samp);
    
    fprintf('done.  (%.4f s)\n',toc);
    
end;

TE_CIb = [prctile(bootstrap_meansTE,5),prctile(bootstrap_meansTE,95)];
GC_CIb = [prctile(bootstrap_meansGC,5),prctile(bootstrap_meansGC,95)];
PAI_CIb = [prctile(bootstrap_meansPAI,5),prctile(bootstrap_meansPAI,95)];
L_CIb = [prctile(bootstrap_meansL,5),prctile(bootstrap_meansL,95)];
LCC_CIb = [prctile(bootstrap_meansLCC,5),prctile(bootstrap_meansLCC,95)];
TEr_CIb = [prctile(bootstrap_meansTEr,5),prctile(bootstrap_meansTEr,95)];
GCr_CIb = [prctile(bootstrap_meansGCr,5),prctile(bootstrap_meansGCr,95)];
PAIr_CIb = [prctile(bootstrap_meansPAIr,5),prctile(bootstrap_meansPAIr,95)];
Lr_CIb = [prctile(bootstrap_meansLr,5),prctile(bootstrap_meansLr,95)];
LCCr_CIb = [prctile(bootstrap_meansLCCr,5),prctile(bootstrap_meansLCCr,95)];