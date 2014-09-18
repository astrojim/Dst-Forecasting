tvec = [0:pi/1000:4*pi];
theta = sin(tvec);
vfout = MovingRamp(theta,0.001);
figure(1);plot(1:length(vfout),vfout,'rx');
figure(2);plot(1:length(theta),theta,'b.');
binnum = 500;
smallhistbinnum = 500;

thetadiff = zeros(length(theta)-1,1);
for iter = 1:1:(length(theta)-1),
	thetadiff(iter,1) = theta(iter+1)-theta(iter);
end;

vfoutdiff = zeros(length(vfout)-1,1);
for iter = 1:1:(length(vfout)-1),
	vfoutdiff(iter,1) = vfout(iter+1)-vfout(iter);
end;

[vfout_tstruct,vfout_cnts] = hist_extra(vfout(1:end-1),binnum);
[thetadiff_tstruct,thetadiff_cnts] = hist_extra(thetadiff(1:end-1),binnum);

for iter = 1:1:length(vfout_tstruct),
	[thetadiffbin_tstruct,thetadiffbin_cnts] = hist_extra(thetadiff(vfout_tstruct(iter).tsteps),smallhistbinnum);
    if( thetadiffbin_tstruct(1).tcount ~= 0 ),
    	figure(3);plot(thetadiffbin_tstruct(1).tsteps+1,vfout(thetadiffbin_tstruct(1).tsteps+1),'rx')
    end;
    if( thetadiffbin_tstruct(15).tcount ~= 0 ),
    	figure(3);plot(thetadiffbin_tstruct(15).tsteps+1,vfout(thetadiffbin_tstruct(15).tsteps+1),'rx')
    end;
    if( thetadiffbin_tstruct(35).tcount ~= 0 ),
    	figure(3);plot(thetadiffbin_tstruct(35).tsteps+1,vfout(thetadiffbin_tstruct(35).tsteps+1),'rx')
    end;
end;