function [truth,LIRvec] = LIRpenchants(x,y,nbins)

dx = zeros(1,length(x));
dx(1) = 0;
for iter = 2:1:length(x),
    dx(iter) = x(iter)-x(iter-1);
end;

dy = zeros(1,length(y));
dy(1) = 0;
for iter = 2:1:length(y),
    dy(iter) = y(iter)-y(iter-1);
end;

LIRvec = zeros(2,6);
truth = cell(6,1);

xy = penchants(x,y,nbins);
yx = penchants(y,x,nbins);
LIRvec(1,1) = mean(xy);
LIRvec(2,1) = mean(yx);
if( mean(xy) > mean(yx) ), 
    truth{1} = 'x->y'; 
else if( mean(xy) < mean(yx) ), 
        truth{1} = 'y->x';
    else
        truth{1} = '??'; 
    end;
end;

dxy = penchants(dx,y,nbins);
ydx = penchants(y,dx,nbins);
LIRvec(1,2) = mean(dxy);
LIRvec(2,2) = mean(ydx);
if( mean(dxy) > mean(ydx) ), truth{2} = 'dx->y'; 
else if( mean(dxy) < mean(ydx) ), truth{2} = 'y->dx'; 
else truth{2} = '??'; end; end;

dxdy = penchants(dx,dy,nbins);
dydx = penchants(dy,dx,nbins);
LIRvec(1,3) = mean(dxdy);
LIRvec(2,3) = mean(dydx);
if( mean(dxdy) > mean(dydx) ), truth{3} = 'dx->dy'; 
else if( mean(dxdy) < mean(dydx) ), truth{3} = 'dy->dx'; 
else truth{3} = '??'; end; end;

xdy = penchants(x,dy,nbins);
dyx = penchants(dy,x,nbins);
LIRvec(1,4) = mean(xdy);
LIRvec(2,4) = mean(dyx);
if( mean(xdy) > mean(dyx) ), truth{4} = 'x->dy'; 
else if( mean(xdy) < mean(dyx) ), truth{4} = 'dy->x'; 
else truth{4} = '??'; end; end;

dxx = penchants(dx,x,nbins);
xdx = penchants(x,dx,nbins);
LIRvec(1,5) = mean(dxx);
LIRvec(2,5) = mean(xdx);
if( mean(dxx) > mean(xdx) ), truth{5} = 'dx->x'; 
else if( mean(dxx) < mean(xdx) ), truth{5} = 'x->dx'; 
else truth{5} = '??'; end; end;

dyy = penchants(dy,y,nbins);
ydy = penchants(y,dy,nbins);
LIRvec(1,6) = mean(dyy);
LIRvec(2,6) = mean(ydy);
if( mean(dyy) > mean(ydy) ), truth{6} = 'dy->y'; 
else if( mean(dyy) < mean(ydy) ), truth{6} = 'y->dy'; 
else truth{6} = '??'; end; end;
