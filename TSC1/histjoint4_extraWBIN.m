function [tsteps_struct,counts] = histjoint4_extraWBIN(TSdataX,TSdataY,TSdatadX,TSdatadY,...
    binUpperX,binLowerX,binUpperY,binLowerY,binUpperdX,binLowerdX,binUpperdY,binLowerdY)
% It is assumed that X and Y are the same length

nbins = length(binUpperX);

for iter = 1:1:nbins,
    tsteps_struct(iter).binUpperX = nan;
    tsteps_struct(iter).binLowerX = nan;
    tsteps_struct(iter).binUpperY = nan;
    tsteps_struct(iter).binLowerY = nan;
    tsteps_struct(iter).binUpperdX = nan;
    tsteps_struct(iter).binLowerdX = nan;
    tsteps_struct(iter).binUpperdY = nan;
    tsteps_struct(iter).binLowerdY = nan;
    tsteps_struct(iter).tsteps = nan;
    tsteps_struct(iter).tcount = 0;
end;
counts = zeros(nbins,nbins,nbins,nbins);

for BstepX = 1:1:length(binUpperX),
    for BstepY = 1:1:length(binUpperY),
        for BstepdX = 1:1:length(binUpperdX),
            for BstepdY = 1:1:length(binUpperdY),

                for Xstep = 1:1:length(TSdataX),

                    if((TSdataX(Xstep) >= binLowerX(BstepX)) && (TSdataX(Xstep) < binUpperX(BstepX))...
                     && (TSdataY(Xstep) >= binLowerY(BstepY)) && (TSdataY(Xstep) <  binUpperY(BstepY))...
                     && (TSdatadX(Xstep) >= binLowerdX(BstepdX)) && (TSdatadX(Xstep) < binUpperdX(BstepdX))...
                     && (TSdatadY(Xstep) >= binLowerdY(BstepdY)) && (TSdatadY(Xstep) < binUpperdY(BstepdY))),

                        tsteps_struct(nbins-(BstepX-1)).binUpperX = binUpperX(BstepX);
                        tsteps_struct(nbins-(BstepX-1)).binLowerX = binLowerX(BstepX);
                        tsteps_struct(nbins-(BstepX-1)).binUpperY = binUpperY(BstepY);
                        tsteps_struct(nbins-(BstepX-1)).binLowerY = binLowerY(BstepY);
                        tsteps_struct(nbins-(BstepX-1)).binUpperdX = binUpperdX(BstepdX);
                        tsteps_struct(nbins-(BstepX-1)).binLowerdX = binLowerdX(BstepdX);
                        tsteps_struct(nbins-(BstepX-1)).binUpperdY = binUpperdY(BstepdY);
                        tsteps_struct(nbins-(BstepX-1)).binLowerdY = binLowerdY(BstepdY);

                        tsteps_struct(nbins-(BstepX-1)).tcount = tsteps_struct(nbins-BstepX+1).tcount + 1;
                        tsteps_struct(nbins-(BstepX-1)).tsteps(tsteps_struct(nbins-BstepX+1).tcount) = Xstep;
                        counts(nbins-(BstepX-1),nbins-(BstepY-1),nbins-(BstepdX-1),nbins-(BstepdY-1)) = counts(nbins-(BstepX-1),nbins-(BstepY-1),nbins-(BstepdX-1),nbins-(BstepdY-1))+1;

                    end;
                end;
            end;
        end;
   end;
end;