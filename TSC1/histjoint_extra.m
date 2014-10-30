function [tsteps_struct,counts] = histjoint_extra(TSdataX,TSdataY,nbins)
% It is assumed that X and Y are the same length

Xmax = max(TSdataX)+1e-12;
Ymax = max(TSdataY)+1e-12;
X_stepsize = abs(Xmax-min(TSdataX))/nbins;
Y_stepsize = abs(Ymax-min(TSdataY))/nbins;

for iter = 1:1:nbins,
    tsteps_struct(iter).binUpperX = nan;
  	tsteps_struct(iter).binLowerX = nan;
    tsteps_struct(iter).binUpperY = nan;
  	tsteps_struct(iter).binLowerY = nan;
  	tsteps_struct(iter).tsteps = nan;
    tsteps_struct(iter).tcount = 0;
end;
counts = zeros(nbins,nbins);

for BstepX = 1:1:nbins,
    for BstepY = 1:1:nbins,
        for Xstep = 1:1:length(TSdataX),
        %printf('>> %i,%i,%.3f,%.3f,%.3f,%.3f,%.3f,%.3f\n',BstepX,Xstep,TSdataX(Xstep),TSdataY(Xstep),Xmax-(BstepX*X_stepsize),Xmax-((BstepX-1)*X_stepsize),Ymax-(BstepY*Y_stepsize),Ymax-((BstepY-1)*Y_stepsize));
        
            if((TSdataX(Xstep) >= (Xmax-(BstepX*X_stepsize))) && (TSdataX(Xstep) < (Xmax-((BstepX-1)*X_stepsize)))...
             && (TSdataY(Xstep) >= (Ymax-(BstepY*Y_stepsize))) && (TSdataY(Xstep) < (Ymax-((BstepY-1)*Y_stepsize)))),

                tsteps_struct(nbins-(BstepX-1)).binUpperX = (Xmax-((BstepX-1)*X_stepsize));
                tsteps_struct(nbins-(BstepX-1)).binLowerX = (Xmax-(BstepX*X_stepsize));
                tsteps_struct(nbins-(BstepX-1)).binUpperY = (Ymax-((BstepY-1)*Y_stepsize));
                tsteps_struct(nbins-(BstepX-1)).binLowerY = (Ymax-(BstepY*Y_stepsize));
                tsteps_struct(nbins-(BstepX-1)).tcount = tsteps_struct(nbins-BstepX+1).tcount + 1;
                tsteps_struct(nbins-(BstepX-1)).tsteps(tsteps_struct(nbins-BstepX+1).tcount) = Xstep;
                counts(nbins-(BstepX-1),nbins-(BstepY-1)) = counts(nbins-(BstepX-1))+1;
                
                %printf('Here: %i,%i,%.3f,%.3f\n',BstepX,Xstep,TSdataX(Xstep),TSdataY(Xstep));
                %printf('  --%.3f,%.3f,%.3f,%.3f\n',Xmax-(BstepX*X_stepsize),Xmax-((BstepX-1)*X_stepsize),Ymax-(BstepY*Y_stepsize),Ymax-((BstepY-1)*Y_stepsize));

            end;
        end;
    end;
end;      