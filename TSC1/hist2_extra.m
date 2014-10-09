function [tsteps_struct,counts] = hist2_extra(TSdataX,TSdataY,nbinsX,nbinsY)

Xmax = max(TSdataX);
X_stepsize = abs(Xmax-min(TSdataX))/nbinsX;

Ymax = max(TSdataY);
Y_stepsize = abs(Ymax-min(TSdataY))/nbinsY;

for iter = 1:1:nbinsX,
	for iter2 = 1:1:nbinsY,
		tsteps_struct(iter,iter2).binUpperX = nan;
    	tsteps_struct(iter,iter2).binLowerX = nan;
    	tsteps_struct(iter,iter2).tcountX = 0;
    	tsteps_struct(iter,iter2).tstepsX = nan;
        tsteps_struct(iter,iter2).binUpperY = nan;
    	tsteps_struct(iter,iter2).binLowerY = nan;
    	tsteps_struct(iter,iter2).tcountY = 0;
    	tsteps_struct(iter,iter2).tstepsY = nan;
    end;
end;
counts = zeros(nbinsX,nbinsY);

for Xstep = 1:1:length(TSdataX),
	for BstepX = 1:1:nbinsX,
    
    	if(TSdataX(Xstep) >= (Xmax-(BstepX*X_stepsize))),
    	
        	for Ystep = 1:1:length(TSdataY),
				for BstepY = 1:1:nbinsY,
		        	    
                	if(TSdataY(Ystep) >= (Ymax-(BstepY*Y_stepsize))),
        				tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).binUpperX = (Xmax-((BstepX-1)*X_stepsize));
            			tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).binLowerX = (Xmax-(BstepX*X_stepsize));
                        tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).binUpperY = (Ymax-((BstepY-1)*Y_stepsize));
            			tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).binLowerY = (Ymax-(BstepY*Y_stepsize));
            			tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).tcountX = tsteps_struct(nbinsX-BstepX+1,nbinsY-BstepY+1).tcountX + 1;
                        tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).tcountY = tsteps_struct(nbinsX-BstepX+1,nbinsY-BstepY+1).tcountY + 1;
            			tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).tstepsX(tsteps_struct(nbinsX-BstepX+1,nbinsY-BstepY+1).tcountX) = Xstep;
                        tsteps_struct(nbinsX-(BstepX-1),nbinsY-(BstepY-1)).tstepsY(tsteps_struct(nbinsX-BstepX+1,nbinsY-BstepY+1).tcountY) = Ystep;
            			counts(nbinsX-(BstepX-1),nbinsY-(BstepY-1)) = counts(nbinsX-(BstepX-1),nbinsY-(BstepY-1))+1;
            %printf(' ^^^ BINGO - (%i,%i).[%i,%i]\n',Xstep,Ystep,BstepX,BstepY);
            			break;
        			end;
                end;
            end;    
            
            break;
    	end;
    end;
end;
