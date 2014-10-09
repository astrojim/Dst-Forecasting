LinearEx

binnum = 10;

[tsteps,counts] = hist2_extra(x,y,binnum,binnum);

[tsteps_inbin,count_outbin] = histbin_extra(y,tsteps(1).binUpperY,tsteps(1).binLowerY,0);
[tsteps_inbin,count_inbin] = histbin_extra(y,tsteps(1).binUpperY,tsteps(1).binLowerY,1);

XYjointProbMat = counts/(sum(sum(counts)))
YProb = count_inbin/length(y)
notYProb = count_outbin/length(y)
XgYcondProb = XYjointProbMat(1)/YProb
XgnotYcondProb = XYjointProbMat(1)/notYProb

[tsteps2,counts2] = hist2_extra(y,x,binnum,binnum);

[tsteps2_inbin,count2_outbin] = histbin_extra(x,tsteps2(1).binUpperY,tsteps2(1).binLowerY,0);
[tsteps2_inbin,count2_inbin] = histbin_extra(x,tsteps2(1).binUpperY,tsteps2(1).binLowerY,1);

%YXjointProbMat = counts2/(sum(sum(counts2)))
YXjointProbMat = XYjointProbMat;
XProb = count2_inbin/length(x)
notXProb = count2_outbin/length(x)
YgXcondProb = YXjointProbMat(1)/XProb
YgnotXcondProb = YXjointProbMat(1)/notXProb

TendencyXY = log((1-XgnotYcondProb)/(1-XgYcondProb))
TendencyYX = log((1-YgnotXcondProb)/(1-YgXcondProb))
