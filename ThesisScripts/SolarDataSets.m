function [Bz,Dst,Time] = SolarDataSets()

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

%% Time

% Reshape the hour time steps into day time steps
Time_OMNI_9301 = Time_OMNI(262993:341880);
Time_OMNI_9301_reshape = reshape(Time_OMNI_9301,24,length(Time_OMNI_9301)/24);

% Pack the time data
Time.hourly = Time_OMNI;
Time.daily9301 = Time_OMNI_9301_reshape;

%% Dst

% Find the daily average of Dst index
Dst_index_daily = OMNIDailyAverage(Dst_index);

% Pack the Dst data
Dst.hourly = Dst_index;
Dst.daily9301 = Dst_index_daily;

%% Bz

% Find the daily average of Bz
Bz_GSE_daily = OMNIDailyAverage(Bz_GSE);

% Pack the data
Bz.hourly = Bz_GSE;
Bz.daily = Bz_GSE_daily;