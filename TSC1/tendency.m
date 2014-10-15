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
        if( YProb == 0 ),
            XgYcondProb = 0;
        else
            XgYcondProb = XYjointProbMat(iter2,iter)/YProb;
        end;
        if( notYProb == 0 ),
            XgnotYcondProb = 0;
        else
            XgnotYcondProb = XYjointProbMat(iter2,iter)/notYProb;
        end;
        %tend(iter2,iter) = log((1-XgnotYcondProb)/(1-XgYcondProb));
        tend(iter2,iter) =  XgYcondProb - XgnotYcondProb;
    end;
end;

