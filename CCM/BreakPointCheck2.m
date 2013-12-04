function OutputVector = BreakPointCheck2(X,eDims,tsteps,delta)
%NN2

breakpoints = zeros(length(tsteps),1);

for tsteps_step = 1:1:length(tsteps),

	timestep_of_interest = tsteps(tsteps_step);    

	for Estep = 1:1:length(eDims),
		
        [distance,timesteps,weights] = NNcheck(X,eDims(Estep),1);

		flag_notfound = 1;
    	for paststep = 1:1:size(weights,2),
    		if( weights(timestep_of_interest,paststep) < delta ),
        		flag_notfound = flag_notfound*0;
            end;
        end;

    	if( flag_notfound == 0 ),
        	breakpoints(tsteps_step) = eDims(Estep);
            break;
        end;        
	end;
    
    clear distance timesteps weights;
end;

OutputVector = breakpoints;