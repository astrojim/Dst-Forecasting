function tend = tendency(x,y,binnum)

%Find joint histogram
[tsteps,counts] = hist2_extra(x,y,binnum,binnum);
XYjointProbMat = counts/(sum(sum(counts)));

% Allocate return variables
tend = zeros(size(XYjointProbMat));

%Find inidividual counts and tendencies
for iter = 1:1:binnum,
    
    [tsteps_outbin,count_outbin] = histbin_extra(y,tsteps(1,iter).binUpperY,tsteps(1,iter).binLowerY,0);
    [tsteps_inbin,count_inbin] = histbin_extra(y,tsteps(1,iter).binUpperY,tsteps(1,iter).binLowerY,1);

    YProb = count_inbin/length(y);
    notYProb = count_outbin/length(y);
    
    for iter2 = 1:1:binnum,
        XgYcondProb = XYjointProbMat(iter2,iter)/YProb;
        XgnotYcondProb = XYjointProbMat(iter2,iter)/notYProb;
        tend(iter2,iter) = log((1-XgnotYcondProb)/(1-XgYcondProb));
    end;
end;

