X = zeros(100,1);
Y = X;
X(1) = 0.4;
Y(1) = 0.2;
rx = 3.8;
ry = 3.5;
Bxy = 0.01;
Byx = 0.2;

for fstep = 1:(length(X)-1),
	X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
end;

eDims = 2:1:10;
tsteps_to_check = 1:1:50;
delta = [1e-5,1e-4,1e-3,1e-2];
breakpoints = zeros(length(delta),length(tsteps_to_check));
breakpoint_modes = zeros(length(delta),1);

%{
for dstep = 1:1:length(delta),
	breakpoints(dstep,:) = BreakPointCheck1(X,eDims,tsteps_to_check,delta);
	breakpoint_modes(dstep) = mode(breakpoints(dstep,:));
end;
%}

%imagesc(breakpoint_modes);
%breakpoint_modes

eDims = 2:1:10;
%tsteps_to_check = 1:1:50;
Tmax = 50;
breakpoint_modes_Tmax = zeros(Tmax,1);
for tstep = 1:1:Tmax,
    breakpoints = BreakPointCheck1(X,eDims,tsteps_to_check);
    breakpoint_modes_Tmax = mode(breakpoints);
end;

plot(breakpoints_modes_Tmax,'.');