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

% Reshape the hour time steps into day time steps
Time_OMNI_9301 = Time_OMNI(262993:341880);
Time_OMNI_9301_reshape = reshape(Time_OMNI_9301,24,length(Time_OMNI_9301)/24);

% Find the daily average of Dst index
Dst_index_daily = OMNIDailyAverage(Dst_index);

% Find correlation
Dst_MeV_e_Flux = zeros(1,90);
for Lradius = 1:90,
    Dst_MeV_e_Flux(1,Lradius) = nancorr(Dst_index_daily,MeV_e_Flux(:,Lradius));
end

% Find the daily average of sunspot number
Sunspot_number_daily = OMNIDailyAverage(Sunspot_number);

% Find correlation
Sunspot_MeV_e_Flux = zeros(1,90);
for Lradius = 1:90,
    Sunspot_MeV_e_Flux(1,Lradius) = nancorr(Sunspot_number_daily,MeV_e_Flux(:,Lradius));
end

% Find the daily average of plasma bulk speed
Plasma_bulk_speed_daily = OMNIDailyAverage(Plasma_bulk_speed);

% Find corr
Plasma_MeV_e_Flux = zeros(1,90);
for Lradius = 1:90,
    Plasma_MeV_e_Flux(:,Lradius) = nancorr(Plasma_bulk_speed_daily,MeV_e_Flux(:,Lradius));
end

% Find the daily average of Bz
Bz_GSE_daily = OMNIDailyAverage(Bz_GSE);

% Find corr
Bz_MeV_e_Flux = zeros(1,90);
for Lradius = 1:90,
    Bz_MeV_e_Flux(:,Lradius) = nancorr(Bz_GSE_daily,MeV_e_Flux(:,Lradius));
end

% Build CCMs
Dst_e_Flux_CCM = zeros(90,2);
Sunspot_e_Flux_CCM = zeros(90,2);
Plasma_e_Flux_CCM = zeros(90,2);
Bz_e_Flux_CCM = zeros(90,2);
ParamDim = 30;
for Lradius = 1:90,
    Dst_e_Flux_CCM(Lradius,:) = CCM(Dst_index_daily,MeV_e_Flux(:,Lradius),ParamDim);
    Sunspot_e_Flux_CCM(Lradius,:) = CCM(Sunspot_number_daily,MeV_e_Flux(:,Lradius),ParamDim);
    Plasma_e_Flux_CCM(Lradius,:) = CCM(Plasma_bulk_speed_daily,MeV_e_Flux(:,Lradius),ParamDim);
    Bz_e_Flux_CCM(Lradius,:) = CCM(Bz_GSE_daily,MeV_e_Flux(:,Lradius),ParamDim);
end
Dst_Sunspot_CCM = CCM(Dst_index_daily,Sunspot_number_daily,ParamDim);   
Dst_Plasma_CCM = CCM(Dst_index_daily,Plasma_bulk_speed_daily,ParamDim);   
Dst_Bz_CCM = CCM(Dst_index_daily,Bz_GSE_daily,ParamDim);   


