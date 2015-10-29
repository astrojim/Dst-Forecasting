load SolarDataExample_ttest.mat

% t-tests
[h,p,ci,stats] = ttest(leans_noNaN,0,0.05,'both')
[h,p,ci,stats] = ttest(leans_noNaN,0,0.05,'left')
[h,p,ci,stats] = ttest(leans_noNaN,0,0.05,'right')

% bootstrap
numsamps_boot = 1e6;
numsamps_orig = length(leans_noNaN);
bootstrap_means = nan(numsamps_boot,1);
for run = 1:1:numsamps_boot
    
%     bootstrap_samp = nan(size(leans_noNaN));
    rndindex = floor((numsamps_orig-1).*rand(numsamps_boot,1) + 1);
    bootstrap_samp = leans_noNaN(rndindex);
    bootstrap_means(run) = mean(bootstrap_samp);
end;

num_positive = sum(bootstrap_means > 0)
siglevel = num_positive/numsamps_boot