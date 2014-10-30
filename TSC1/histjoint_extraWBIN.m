function [tsteps_struct,counts] = histjoint_extraWBIN(TSdataX,TSdataY,binUpperX,binLowerX,binUpperY,binLowerY)
% It is assumed that X and Y are the same length

nbins = length(binUpperX);

for iter = 1:1:nbins,
    tsteps_struct(iter).binUpperX = nan;
    tsteps_struct(iter).binLowerX = nan;
    tsteps_struct(iter).binUpperY = nan;
    tsteps_struct(iter).binLowerY = nan;
    tsteps_struct(iter).tsteps = nan;
    tsteps_struct(iter).tcount = 0;
end;
counts = zeros(nbins,nbins);

for BstepX = 1:1:length(binUpperX),
    for BstepY = 1:1:length(binUpperY),
        for Xstep = 1:1:length(TSdataX),
        %fprintf('>> %i,%i,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',BstepX,Xstep,TSdataX(Xstep),TSdataY(Xstep),Xmax-(BstepX*X_stepsize),Xmax-((BstepX-1)*X_stepsize),Ymax-(BstepY*Y_stepsize),Ymax-((BstepY-1)*Y_stepsize));
        %fprintf('  -> %.3f,%.3f,%.3f,%.3f\n',binUpperX(BstepX),binLowerX(BstepX),binUpperY(BstepY),binLowerY(BstepY));
        
            if((TSdataX(Xstep) >= binLowerX(BstepX)) && (TSdataX(Xstep) < binUpperX(BstepX))...
             && (TSdataY(Xstep) >= binLowerY(BstepY)) && (TSdataY(Xstep) <  binUpperY(BstepY))),

                tsteps_struct(nbins-(BstepX-1)).binUpperX = binUpperX(BstepX);
                tsteps_struct(nbins-(BstepX-1)).binLowerX = binLowerX(BstepX);
                tsteps_struct(nbins-(BstepX-1)).binUpperY = binUpperY(BstepY);
                tsteps_struct(nbins-(BstepX-1)).binLowerY = binLowerY(BstepY);
                tsteps_struct(nbins-(BstepX-1)).tcount = tsteps_struct(nbins-BstepX+1).tcount + 1;
                tsteps_struct(nbins-(BstepX-1)).tsteps(tsteps_struct(nbins-BstepX+1).tcount) = Xstep;
                counts(nbins-(BstepX-1),nbins-(BstepY-1)) = counts(nbins-(BstepX-1))+1;
                
%                 fprintf('Here: %i,%i,%.3f,%.3f\n',BstepX,Xstep,TSdataX(Xstep),TSdataY(Xstep));
%                 fprintf('  --%.3f,%.3f,%.3f,%.3f\n',binUpperX(BstepX),binLowerX(BstepX),binUpperY(BstepY),binLowerY(BstepY));

            end;
        end;
   end;
end;