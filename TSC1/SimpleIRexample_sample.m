numSamp = 50000;

tic;
SimpleIRexample

leans_runSum = leans_stored;
tally = ones(length(B),length(xytol));

for iter = 1:1:numSamp,
    fprintf('Sample %i\n',iter);
    SimpleIRexample
    
    [leans_runSum,tally] = SumMatwTally(leans_stored,leans_runSum,tally);
    
end;
fprintf('%i samples took %.3f seconds\n',numSamp,toc);
leans_nmean = leans_runSum./tally;