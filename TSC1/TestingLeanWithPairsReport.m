numtests = 10;
totalwin = nan(numtests,1);
tswin = nan(numtests,1);
testnum = 0;
ticvec = nan(numtests,1);

%test 1
tic;
testnum = testnum + 1;
lags = [0]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = lout;
ticvec(testnum,1) = toc;

%test 2
tic;
testnum = testnum + 1;
lags = [1]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 3
tic;
testnum = testnum + 1;
lags = [2]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 4
tic;
testnum = testnum + 1;
lags = [3]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 5
tic;
testnum = testnum + 1;
lags = [4]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 6
tic;
testnum = testnum + 1;
lags = [5]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 7
tic;
testnum = testnum + 1;
lags = [0 1 2]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 8
tic;
testnum = testnum + 1;
lags = [0 1 2 3 4 5]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 9
tic;
testnum = testnum + 1;
lags = [0 1 2 3 4 5 6 7 8 9 10]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%test 10
tic;
testnum = testnum + 1;
lags = [0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20]; 
lout = TestingLeanWithPairs(lags);
totalwin(testnum,1) = sum(lout);
tswin(testnum,1) = lout(42) + sum(lout(48:51)) + lout(55) ...
    + sum(lout(65:69)) + lout(72) + lout(73) + sum(lout(76:83)) + lout(87);
lout_saved = [lout_saved lout];
ticvec(testnum,1) = toc;

%report
for iter = 1:1:numtests,
    fprintf('Test %i: %i/%i (%.4f) correct [total]; %i/%i (%.4f) correct [TS]; (t = %.5f)\n',...
        iter,totalwin(iter,1),88,totalwin(iter,1)/88,tswin(iter,1),22,tswin(iter,1)/22,ticvec(iter,1));
end;