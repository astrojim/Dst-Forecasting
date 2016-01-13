load moontidedata/importLLRdatfile.mat

timestamps = nan(length(OMCD8814),1);
traveltime_Em13s = nan(length(OMCD8814),1);
range_km = nan(length(OMCD8814),1);
c_mps = 299792458;
for iter = 1:1:length(OMCD8814),
    
    day = OMCD8814{iter}(1,9:10);
    month = OMCD8814{iter}(1,7:8);
    year = OMCD8814{iter}(1,3:6);
    date_temp_str = sprintf('%s/%s/%s',month,day,year);
    timestamps(iter,1) = datenum(date_temp_str);
    
    traveltime_Em13s(iter,1) = str2double(OMCD8814{iter}(1,24:38));
    range_km(iter,1) = (c_mps*(traveltime_Em13s(iter,1)*(1e-14)))/(2*1000); 
end;