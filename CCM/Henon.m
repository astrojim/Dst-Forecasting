function OutputVector = Henon(x0,y0,AParam,BParam,NumIterations)

Data = zeros(2,NumIterations);
Data(1,1) = x0;
Data(2,1) = y0;
for nstep = 2:1:length(Data),
	Data(1,nstep) = 1 - AParam*Data(1,nstep-1)^2+Data(2,nstep-1);
    Data(2,nstep) = BParam*Data(1,nstep-1);
end;

OutputVector = Data;
