function [LLR,tide,timestamps_unique] = moontidedata()

% load parsed data
load moontidedata/parseLLRdata.mat
load moontidedata/parseTideCVS.mat

% find tide data to match LLR measurements
tide_temp = nan(length(range_km),1);
for iter = 1:1:length(tide_temp),
    tempidx = find(tidedata(:,1) == timestamps(iter,1));
    
    if( ~isempty(tempidx) ),
        tide_temp(iter,1) = tidedata(tempidx,2);
    end;
end;

% pass through LLR data
LLR_temp = range_km;

% only keep unique time steps
step = 1;
tide(step,1) = tide_temp(1,1);
LLR(step,1) = LLR_temp(1,1);
timestamps_unique(step,1) = timestamps(1,1);
step = step + 1;
for iter = 2:1:length(timestamps),
    
    if( timestamps(iter,1) ~= timestamps(iter-1,1) ),
        tide(step,1) = tide_temp(iter,1);
        LLR(step,1) = LLR_temp(iter,1);
        timestamps_unique(step,1) = timestamps(iter,1);
        step = step + 1;
    end;
    
end;