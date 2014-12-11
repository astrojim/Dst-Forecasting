function [tsteps_struct,counts] = hist_extra(TSdata,nbins)

Xmax = max(TSdata)+1e-12;
X_stepsize = abs(Xmax-min(TSdata))/nbins;

for iter = 1:1:nbins,
	tsteps_struct(iter).binUpper = nan;
    tsteps_struct(iter).binLower = nan;
    tsteps_struct(iter).tcount = 0;
    tsteps_struct(iter).tsteps = nan;
end;
counts = zeros(1,nbins);

for Bstep = 1:1:nbins;
  	tsteps_struct(nbins-(Bstep-1)).binUpper = (Xmax-((Bstep-1)*X_stepsize));
    tsteps_struct(nbins-(Bstep-1)).binLower = (Xmax-(Bstep*X_stepsize));
end;

for Xstep = 1:1:length(TSdata),
	for Bstep = 1:1:nbins,
		
        if(TSdata(Xstep) >= (Xmax-(Bstep*X_stepsize))),
        	%tsteps_struct(nbins-(Bstep-1)).binUpper = (Xmax-((Bstep-1)*X_stepsize));
            %tsteps_struct(nbins-(Bstep-1)).binLower = (Xmax-(Bstep*X_stepsize));
            tsteps_struct(nbins-(Bstep-1)).tcount = tsteps_struct(nbins-Bstep+1).tcount + 1;
            tsteps_struct(nbins-(Bstep-1)).tsteps(tsteps_struct(nbins-Bstep+1).tcount) = Xstep;
            counts(1,nbins-(Bstep-1)) = counts(nbins-(Bstep-1))+1;

            break;
        end;
    
    end;

end;

