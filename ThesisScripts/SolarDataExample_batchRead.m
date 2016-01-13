
% set number of batches
numbatch = 58;

% start batch number 
startbatch = 1;

% set save directory
savedir = 'SolarDataBatches';

% read in batches
allstep = 1;
TEdatastep = 1;
GCdatastep = 1;
PAIdatastep = 1;
Ldatastep = 1;
LCCdatastep = 1;
TErdatastep = 1;
GCrdatastep = 1;
PAIrdatastep = 1;
Lrdatastep = 1;
LCCrdatastep = 1;
for batch = startbatch:1:(startbatch+numbatch-1),
    
    tempdata = open(sprintf('%s/SolarDataBatchLongSamp_%i.mat',savedir,batch));
    
    TEtemp = tempdata.TEsamp;
    GCtemp = tempdata.GCsamp;
    PAItemp = tempdata.PAIsamp;
    Ltemp = tempdata.Lsamp;
    LCCtemp = tempdata.LCCsamp;
    TErtemp = tempdata.TErsamp;
    GCrtemp = tempdata.GCrsamp;
    PAIrtemp = tempdata.PAIrsamp;
    Lrtemp = tempdata.Lrsamp;
    LCCrtemp = tempdata.LCCrsamp;
    
    for iter = 1:1:length(TEtemp),
        
        TEall(allstep) = TEtemp(iter);
        GCall(allstep) = GCtemp(iter);
        PAIall(allstep) = PAItemp(iter);
        Lall(allstep) = Ltemp(iter);
        LCCall(allstep) = LCCtemp(iter);
        TErall(allstep) = TErtemp(iter);
        GCrall(allstep) = GCrtemp(iter);
        PAIrall(allstep) = PAIrtemp(iter);
        Lrall(allstep) = Lrtemp(iter);
        LCCrall(allstep) = LCCrtemp(iter);
        
        allstep = allstep + 1;
        
        if( ~isnan(TEtemp(iter)) ), 
            TEdata(TEdatastep) = TEtemp(iter); 
            TEdatastep = TEdatastep + 1;
        end;
        if( ~isnan(GCtemp(iter)) ), 
            GCdata(GCdatastep) = GCtemp(iter); 
            GCdatastep = GCdatastep + 1;
        end;
        if( ~isnan(PAItemp(iter)) ), 
            PAIdata(PAIdatastep) = PAItemp(iter); 
            PAIdatastep = PAIdatastep + 1;
        end;
        if( ~isnan(Ltemp(iter)) ), 
            Ldata(Ldatastep) = Ltemp(iter);
            Ldatastep = Ldatastep + 1;
        end;
        if( ~isnan(LCCtemp(iter)) ), 
            LCCdata(LCCdatastep) = LCCtemp(iter); 
            LCCdatastep = LCCdatastep + 1;
        end;
        if( ~isnan(TErtemp(iter)) ), 
            TErdata(TErdatastep) = TErtemp(iter); 
            TErdatastep = TErdatastep + 1;
        end;
        if( ~isnan(GCrtemp(iter)) ), 
            GCrdata(GCrdatastep) = GCrtemp(iter); 
            GCrdatastep = GCrdatastep + 1;
        end;
        if( ~isnan(PAIrtemp(iter)) ), 
            PAIrdata(PAIrdatastep) = PAIrtemp(iter); 
            PAIrdatastep = PAIrdatastep + 1;
        end;
        if( ~isnan(Lrtemp(iter)) ), 
            Lrdata(Lrdatastep) = Lrtemp(iter); 
            Lrdatastep = Lrdatastep + 1;
        end;
        if( ~isnan(LCCrtemp(iter)) ), 
            LCCrdata(LCCrdatastep) = LCCrtemp(iter); 
            LCCrdatastep = LCCrdatastep + 1;
        end;
        
        
    end;
    
end;
        