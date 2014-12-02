function [truth,LIRpens,LIRleans] = LIR(x,y,nbins,tol)

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

LIRpens = nan(2,9);
LIRleans = nan(1,9);
truth = cell(9,1);

xy = penchants(x,y,nbins);
yx = penchants(y,x,nbins);
LIRpens(1,1) = mean_ignorezero(xy,tol);
LIRpens(2,1) = mean_ignorezero(yx,tol);
LIRleans(1,1) = LIRpens(1,1) - LIRpens(2,1);
if( LIRleans(1,1) > 0 ), 
    truth{1} = 'x->y'; 
elseif( LIRleans(1,1) < 0 ), 
        truth{1} = 'y->x';
else
    truth{1} = '??'; 
end;

dxy = penchants(dx,y,nbins);
ydx = penchants(y,dx,nbins);
LIRpens(1,2) = mean_ignorezero(dxy,tol);
LIRpens(2,2) = mean_ignorezero(ydx,tol);
LIRleans(1,2) = LIRpens(1,2) - LIRpens(2,2);
if( LIRleans(1,2) > 0 ), truth{2} = 'dx->y'; 
elseif( LIRleans(1,2) < 0 ), truth{2} = 'y->dx'; 
else truth{2} = '??'; end; 

dxdy = penchants(dx,dy,nbins);
dydx = penchants(dy,dx,nbins);
LIRpens(1,3) = mean_ignorezero(dxdy,tol);
LIRpens(2,3) = mean_ignorezero(dydx,tol);
LIRleans(1,3) = LIRpens(1,3) - LIRpens(2,3);
if( LIRleans(1,3) > 0 ), truth{3} = 'dx->dy'; 
elseif( LIRleans(1,3) < 0 ), truth{3} = 'dy->dx'; 
else truth{3} = '??'; end;

xdy = penchants(x,dy,nbins);
dyx = penchants(dy,x,nbins);
LIRpens(1,4) = mean_ignorezero(xdy,tol);
LIRpens(2,4) = mean_ignorezero(dyx,tol);
LIRleans(1,4) = LIRpens(1,4) - LIRpens(2,4);
if( LIRleans(1,4) > 0 ), truth{4} = 'x->dy'; 
elseif( LIRleans(1,4) < 0 ), truth{4} = 'dy->x'; 
else truth{4} = '??'; end;

dxx = penchants(dx,x,nbins);
xdx = penchants(x,dx,nbins);
LIRpens(1,5) = mean_ignorezero(dxx,tol);
LIRpens(2,5) = mean_ignorezero(xdx,tol);
LIRleans(1,5) = LIRpens(1,5) - LIRpens(2,5);
if( LIRleans(1,5) > 0 ), truth{5} = 'dx->x'; 
elseif( LIRleans(1,5) < 0 ), truth{5} = 'x->dx'; 
else truth{5} = '??'; end; 

dyy = penchants(dy,y,nbins);
ydy = penchants(y,dy,nbins);
LIRpens(1,6) = mean_ignorezero(dyy,tol);
LIRpens(2,6) = mean_ignorezero(ydy,tol);
LIRleans(1,6) = LIRpens(1,6) - LIRpens(2,6);
if( LIRleans(1,6) > 0 ), truth{6} = 'dy->y'; 
elseif( LIRleans(1,6) < 0 ), truth{6} = 'y->dy'; 
else truth{6} = '??'; end;

xdxy = penchants2(x,dx,y,nbins);
LIRpens(1,7) = mean_ignorezero(xdxy,tol);
LIRpens(2,7) = nan;
LIRleans(1,7) = nan;
if( LIRpens(1,7) > 0 ), truth{7} = 'x&dx->y'; 
elseif( LIRpens(1,7) < 0 ), truth{7} = 'y->x&dx'; 
else truth{7} = '??'; end; 

ydyx = penchants2(y,dy,x,nbins);
LIRpens(1,8) = mean_ignorezero(ydyx,tol);
LIRpens(2,8) = nan;
LIRleans(1,8) = nan;
if( LIRpens(1,8) > 0 ), truth{8} = 'x&dx->y'; 
elseif( LIRpens(1,8) < 0 ), truth{8} = 'y->x&dx'; 
else truth{8} = '??'; end; 

xdxydy = penchants3(x,dx,y,dy,nbins);
ydyxdx = penchants3(y,dy,x,dx,nbins);
LIRpens(1,9) = mean_ignorezero(xdxydy,tol);
LIRpens(2,9) = mean_ignorezero(ydyxdx,tol);
LIRleans(1,9) = LIRpens(1,9)-LIRpens(2,9);
if( LIRpens(1,9) > 0 ), truth{9} = 'x&dx->y&dy'; 
elseif( LIRpens(1,8) < 0 ), truth{9} = 'y&dy->x&dx'; 
else truth{9} = '??'; end; 
