function [sumMat,cntMat] = SumMatwTally(sumIn,runningSum,Tally)
% add a matrix of values to a running sum matrix and deal with NaN

% if( size(sumIn) ~= size(runningSum) || size(sumIn) ~= size(Tally) || size(Tally) ~= size(runningSum) )
%     warning('All input arrays should be the same size.\n');
% end;

for iter1 = 1:1:size(sumIn,1),
    for iter2 = 1:1:size(sumIn,2)
        
        if( ~isnan(sumIn(iter1,iter2)) ),
            runningSum(iter1,iter2) = runningSum(iter1,iter2) + sumIn(iter1,iter2);
            Tally(iter1,iter2) = Tally(iter1,iter2) + 1;
        end;
        
    end;
end;

sumMat = runningSum;
cntMat = Tally;
