function [Bz,Bzr,Dst,Time] = SolarDataSets(subset_start,subset_stop)

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

if( isempty(subset_start) ),
    error('Error in SolarDataSets: start time index for daily average subsets not set.');
end;

if( isempty(subset_stop) ),
    error('Error in SolarDataSets: stop time index for daily average subsets not set.');
end;

%% Time

% Reshape the hour time steps into day time steps
Time_OMNI_subset = Time_OMNI(subset_start:subset_stop);
Time_OMNI_subset_reshape = reshape(Time_OMNI_subset,24,length(Time_OMNI_subset)/24);

% Pack the time data
Time.hourly = Time_OMNI;
Time.dailysubset = Time_OMNI_subset_reshape;

%% Dst

% Find the daily average of Dst index
Dst_index_daily = OMNIDailyAverage(Dst_index,subset_start,subset_stop);

% Pack the Dst data
Dst.hourly = Dst_index;
Dst.dailysubset = Dst_index_daily;

%% Bz

% Find the daily average of Bz
Bz_GSE_daily = OMNIDailyAverage(Bz_GSE,subset_start,subset_stop);

% Pack the data
Bz.hourly = Bz_GSE;
Bz.dailysubset = Bz_GSE_daily;

% find Bzr
tempHourly = nan(size(Bz_GSE));
for hiter = 1:1:length(tempHourly),
    if( Bz_GSE(hiter) > 0 )
        tempHourly(hiter) = 0;
    else
        tempHourly(hiter) = Bz_GSE(hiter);
    end;
end;

tempDaily = nan(size(Bz_GSE_daily));
for diter = 1:1:length(tempDaily),
    if( Bz_GSE_daily(diter) > 0 )
        tempDaily(diter) = 0;
    else
        tempDaily(diter) = Bz_GSE_daily(diter);
    end;
end;

Bzr.hourly = tempHourly;
Bzr.dailysubset = tempDaily;