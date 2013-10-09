function [OutputVector] = OMNIDailyAverage(InputVector)

    % Pull out the Jan 01 1993 to Dec 31 2001 
    InputVector_9301 = InputVector(262993:341880);
    
    % Find daily (24 hour) averages
    InputVector_9301_reshaped = reshape(InputVector_9301,24,length(InputVector_9301)/24);
    InputVector_9301_Avg = zeros(size(InputVector_9301_reshaped,2),1);
    for x = 1:size(InputVector_9301_reshaped,2) 
        InputVector_9301_Avg(x) = nanmean(InputVector_9301_reshaped(:,x)); 
    end;
    
    OutputVector = InputVector_9301_Avg;
    
end