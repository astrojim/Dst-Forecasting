function [tendXY tendYX] = CompTend(x,y,binnum)

%Find joint histogram
[tsteps,counts] = hist2_extra(x,y,binnum,binnum);
XYjointProbMat = counts/(sum(sum(counts)));

% Allocate return variables
tendXY = zeros(size(XYjointProbMat));
tendYX = tendXY;

%Find inidividual counts and tendencies
for iter = 1:1:binnum,
    
    [tsteps_outbin,count_outbin] = histbin_extra(y,tsteps(1,iter).binUpperY,tsteps(1,iter).binLowerY,0);
    [tsteps_inbin,count_inbin] = histbin_extra(y,tsteps(1,iter).binUpperY,tsteps(1,iter).binLowerY,1);
    [tsteps2_outbin,count2_outbin] = histbin_extra(x,tsteps(1,iter).binUpperY,tsteps(1,iter).binLowerY,0);
    [tsteps2_inbin,count2_inbin] = histbin_extra(x,tsteps(1,iter).binUpperY,tsteps(1,iter).binLowerY,1);

    YProb = count_inbin/length(y);
    notYProb = count_outbin/length(y);
    XProb = count2_inbin/length(x);
    notXProb = count2_outbin/length(x);
    
    for iter2 = 1:1:binnum,
        XgYcondProb = XYjointProbMat(iter2,iter)/YProb;
        XgnotYcondProb = XYjointProbMat(iter2,iter)/notYProb;
        YgXcondProb = XYjointProbMat(iter2,iter)/XProb;
        YgnotXcondProb = XYjointProbMat(iter2,iter)/notXProb;

        tendXY(iter2,iter) = log((1-XgnotYcondProb)/(1-XgYcondProb));
        tendYX(iter2,iter) = log((1-YgnotXcondProb)/(1-YgXcondProb));
    end;
end;

