function [tsteps_struct,count] = histbin_extra(TSdata,binUpper,binLower,flag)
% flag = 1 -> check for inside bin
% flag = 0 -> check for outside bin

tsteps_struct.binUpper = binUpper;
tsteps_struct.binLower = binLower;
tsteps_struct.tcount = 0;
tsteps_struct.tsteps = nan;

count = 0;

if( flag ),
    for Xstep = 1:1:length(TSdata),

        if((TSdata(Xstep) >= binLower) && (TSdata(Xstep) < binUpper) ),
            tsteps_struct.tcount = tsteps_struct.tcount + 1;
            tsteps_struct.tsteps(tsteps_struct.tcount) = Xstep;
            count = count+1;
        end;

    end;
elseif( ~flag ),
    for Xstep = 1:1:length(TSdata),

        if((TSdata(Xstep) < binLower) || (TSdata(Xstep) >= binUpper) ),
            tsteps_struct.tcount = tsteps_struct.tcount + 1;
            tsteps_struct.tsteps(tsteps_struct.tcount) = Xstep;
            count = count+1;
        end;

    end;
else
    error('Flag set incorrectly.\n');        
end;
