function OutputVector = BreakPointCheck1(X,eDims,tsteps)
%NN1

breakpoints = zeros(length(tsteps),1);

for tsteps_step = 1:1:length(tsteps),

	timestep_of_interest = tsteps(tsteps_step);    

	for Estep = 1:1:length(eDims),
		
        [distance,timesteps,weights] = NNcheck(X,eDims(Estep),1);

    	if( Estep == 1 ),
    		for paststep = 1:1:size(weights,2),
    			past_timesteps(paststep) = timesteps(timestep_of_interest,paststep+1);
            	past_weights(paststep) = weights(timestep_of_interest,paststep);
        	end;
    	end;

    	if( Estep > 1 ),
        	flagB = 0;
    		for paststep = 1:1:length(past_timesteps),
            	for coutstepB = 1:1:size(weights,2),
    				if( past_timesteps(paststep) == timesteps(timestep_of_interest,coutstepB+1) ),
            			flagB = flagB + 1;
                    end;
            	end;
        	end;
        	if( flagB < length(past_timesteps) && breakpoints(tsteps_step) == 0 ),
        		breakpoints(tsteps_step) = eDims(Estep);
        	end;
        	for paststep = 1:1:size(weights,2),
    			past_timesteps(paststep) = timesteps(timestep_of_interest,paststep+1);
            	past_weights(paststep) = weights(timestep_of_interest,paststep);
        	end;
    	end;
	end;
    
    clear past_timesteps past_weights distance timesteps weights;
end;

OutputVector = breakpoints;