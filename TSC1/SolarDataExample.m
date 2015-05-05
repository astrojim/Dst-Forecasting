if ~exist('./data/OMNI_OMNI2_merged_20120213-v1.mat.zip')
    fprintf('Downloading and unzipping OMNI2\n');
    urlwrite('ftp://virbo.org/OMNI/OMNI2/merged/OMNI_OMNI2_merged_20120213-v1.mat.zip','./data/OMNI_OMNI2_merged_20120213-v1.mat.zip');
    unzip('./data/OMNI_OMNI2_merged_20120213-v1.mat.zip','./data');
end
load ./data/OMNI_OMNI2_merged_20120213-v1.mat
Time_OMNI = Time;

if ~exist('./data/Kanekal_SAMPEX_merged_20011231-v0.mat.zip')
    fprintf('Downloading and unzipping SAMPEX\n');
    urlwrite('ftp://virbo.org/Kanekal/SAMPEX/merged/Kanekal_SAMPEX_merged_20011231-v0.mat.zip','./data/Kanekal_SAMPEX_merged_20011231-v0.mat.zip');
    unzip('./data/Kanekal_SAMPEX_merged_20011231-v0.mat.zip','./data');
end
load ./data/Kanekal_SAMPEX_merged_20011231-v0.mat
To = Time;

addpath('../utils');
addpath('../CCM');

% Reshape the hour time steps into day time steps
Time_OMNI_9301 = Time_OMNI(262993:341880);
Time_OMNI_9301_reshape = reshape(Time_OMNI_9301,24,length(Time_OMNI_9301)/24);

% Find the daily average of Dst index
Dst_index_daily = OMNIDailyAverage(Dst_index);

% Find the daily average of sunspot number
Sunspot_number_daily = OMNIDailyAverage(Sunspot_number);

% Find the daily average of plasma bulk speed
Plasma_bulk_speed_daily = OMNIDailyAverage(Plasma_bulk_speed);

% Find the daily average of Bz
Bz_GSE_daily = OMNIDailyAverage(Bz_GSE);

% Find the daily average of Bz
By_GSE_daily = OMNIDailyAverage(By_GSE);

% Find the daily average of Bz
Bx_GSE_daily = OMNIDailyAverage(Bx_GSE);

% Subsetting to get set of leans
sublength = 2500;
numsubs = floor(length(Dst_index)/sublength);

leansBzDstSubset = nan(numsubs,1);
leansByDstSubset = nan(numsubs,1);
leansBxDstSubset = nan(numsubs,1);

fs = 0.05;

for iter = 1:1:numsubs,
    
    tic;
    fprintf('[1 of 3] Subsetting TS %i/%i [%.4f] ... ',iter,numsubs,iter/numsubs);
    
    maxStartIndex = length(Dst_index)-sublength;
    tIndex = iter:1:(iter+sublength-1);
    
    DstTol = fs*nanstd(abs(Dst_index(tIndex)-nanmean(Dst_index(tIndex))));
    BzTol = fs*nanstd(abs(Bz_GSE(tIndex)-nanmean(Bz_GSE(tIndex))));
    ByTol = fs*nanstd(abs(By_GSE(tIndex)-nanmean(By_GSE(tIndex))));
    BxTol = fs*nanstd(abs(Bx_GSE(tIndex)-nanmean(Bx_GSE(tIndex))));

    temp = leans_lagged(Bz_GSE(tIndex),Dst_index(tIndex),BzTol,DstTol,1);
    leansBzDstSubset(iter,1) = temp(1,2);
    
    temp = leans_lagged(By_GSE(tIndex),Dst_index(tIndex),ByTol,DstTol,1);
    leansByDstSubset(iter,1) = temp(1,2);
    
    temp = leans_lagged(Bx_GSE(tIndex),Dst_index(tIndex),BxTol,DstTol,1);
    leansBxDstSubset(iter,1) = temp(1,2);
    
    fprintf('done. [%.4f] \n',toc);
end;

% Sampling to get set of leans
sublength = 500;
numsubs = floor(length(Dst_index)/sublength);
numsamps = 1e4;

leansBzDstSamp = nan(numsamps,1);
leansByDstSamp = nan(numsamps,1);
leansBxDstSamp = nan(numsamps,1);

for iter = 1:1:numsamps,
    
    tic;
    fprintf('[2 of 3] Sampling TS %i/%i [%.4f] ... ',iter,numsamps,iter/numsamps);
    
    maxStartIndex = length(Dst_index)-sublength;
    rndStartIndex = floor(rand(1)*maxStartIndex)+1;
    tIndex = rndStartIndex:1:(rndStartIndex+sublength-1);
    
    DstTol = fs*nanstd(abs(Dst_index(tIndex)-nanmean(Dst_index(tIndex))));
    BzTol = fs*nanstd(abs(Bz_GSE(tIndex)-nanmean(Bz_GSE(tIndex))));
    ByTol = fs*nanstd(abs(By_GSE(tIndex)-nanmean(By_GSE(tIndex))));
    BxTol = fs*nanstd(abs(Bx_GSE(tIndex)-nanmean(Bx_GSE(tIndex))));

    temp = leans_lagged(Bz_GSE(tIndex),Dst_index(tIndex),BzTol,DstTol,1);
    leansBzDstSamp(iter,1) = temp(1,2);
    
    temp = leans_lagged(By_GSE(tIndex),Dst_index(tIndex),ByTol,DstTol,1);
    leansByDstSamp(iter,1) = temp(1,2);
    
    temp = leans_lagged(Bx_GSE(tIndex),Dst_index(tIndex),BxTol,DstTol,1);
    leansBxDstSamp(iter,1) = temp(1,2);
    
    fprintf('done. [%.4f] \n',toc);
end;

% Daily averages
fprintf('[3 of 3] Daily Averages ... ');
tic;

DstTol = fs*nanstd(abs(Dst_index_daily-nanmean(Dst_index_daily)));
BzTol = fs*nanstd(abs(Bz_GSE_daily-nanmean(Bz_GSE_daily)));
ByTol = fs*nanstd(abs(By_GSE_daily-nanmean(By_GSE_daily)));
BxTol = fs*nanstd(abs(Bx_GSE_daily-nanmean(Bx_GSE_daily)));

Bz_daily_temp = Bz_GSE_daily(~isnan(Bz_GSE_daily));
Dst_daily_temp = Dst_index_daily(~isnan(Bz_GSE_daily));
temp = leans_lagged(Bz_daily_temp,Dst_daily_temp,BzTol,DstTol,1);
leansBzDstDaily = temp(1,2);

By_daily_temp = By_GSE_daily(~isnan(By_GSE_daily));
Dst_daily_temp = Dst_index_daily(~isnan(By_GSE_daily));
temp = leans_lagged(By_daily_temp,Dst_daily_temp,ByTol,DstTol,1);
leansByDstDaily = temp(1,2);

Bx_daily_temp = Bx_GSE_daily(~isnan(Bx_GSE_daily));
Dst_daily_temp = Dst_index_daily(~isnan(Bx_GSE_daily));
temp = leans_lagged(Bx_daily_temp,Dst_daily_temp,BxTol,DstTol,1);
leansBxDstDaily = temp(1,2);

fprintf('done. [%.4f] \n',toc);

