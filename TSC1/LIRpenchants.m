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

LIRvec = nan(6,6);
truth = cell(6,1);

xy = penchants(x,y,nbins);
yx = penchants(y,x,nbins);
xyL = leaning(x,y,nbins);
yxL = leaning(y,x,nbins);
LIRvec(1,1) = mean(xy);
LIRvec(2,1) = mean(yx);
LIRvec(3,1) = mean(xyL);
LIRvec(4,1) = mean(yxL);
LIRvec(5,1) = mean(xy)-mean(yx);
LIRvec(6,1) = mean(yx)-mean(xy);
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
dxyL = leaning(dx,y,nbins);
ydxL = leaning(y,dx,nbins);
LIRvec(1,2) = mean(dxy);
LIRvec(2,2) = mean(ydx);
LIRvec(3,2) = mean(dxyL);
LIRvec(4,2) = mean(ydxL);
LIRvec(5,2) = mean(dxy)-mean(ydx);
LIRvec(6,2) = mean(ydx)-mean(dxy);
if( mean(dxy) > mean(ydx) ), truth{2} = 'dx->y'; 
else if( mean(dxy) < mean(ydx) ), truth{2} = 'y->dx'; 
else truth{2} = '??'; end; end;

dxdy = penchants(dx,dy,nbins);
dydx = penchants(dy,dx,nbins);
dxdyL = leaning(dx,dy,nbins);
dydxL = leaning(dy,dx,nbins);
LIRvec(1,3) = mean(dxdy);
LIRvec(2,3) = mean(dydx);
LIRvec(3,3) = mean(dxdyL);
LIRvec(4,3) = mean(dydxL);
LIRvec(5,3) = mean(dxdy)-mean(dydx);
LIRvec(6,3) = mean(dydx)-mean(dxdy);
if( mean(dxdy) > mean(dydx) ), truth{3} = 'dx->dy'; 
else if( mean(dxdy) < mean(dydx) ), truth{3} = 'dy->dx'; 
else truth{3} = '??'; end; end;

xdy = penchants(x,dy,nbins);
dyx = penchants(dy,x,nbins);
xdyL = leaning(x,dy,nbins);
dyxL = leaning(dy,x,nbins);
LIRvec(1,4) = mean(xdy);
LIRvec(2,4) = mean(dyx);
LIRvec(3,4) = mean(xdyL);
LIRvec(4,4) = mean(dyxL);
LIRvec(5,4) = mean(xdy)-mean(dyx);
LIRvec(6,4) = mean(dyx)-mean(xdy);
if( mean(xdy) > mean(dyx) ), truth{4} = 'x->dy'; 
else if( mean(xdy) < mean(dyx) ), truth{4} = 'dy->x'; 
else truth{4} = '??'; end; end;

dxx = penchants(dx,x,nbins);
xdx = penchants(x,dx,nbins);
dxxL = leaning(dx,x,nbins);
xdxL = leaning(x,dx,nbins);
LIRvec(1,5) = mean(dxx);
LIRvec(2,5) = mean(xdx);
LIRvec(3,5) = mean(dxxL);
LIRvec(4,5) = mean(xdxL);
LIRvec(5,5) = mean(dxx)-mean(xdx);
LIRvec(6,5) = mean(xdx)-mean(dxx);
if( mean(dxx) > mean(xdx) ), truth{5} = 'dx->x'; 
else if( mean(dxx) < mean(xdx) ), truth{5} = 'x->dx'; 
else truth{5} = '??'; end; end;

dyy = penchants(dy,y,nbins);
ydy = penchants(y,dy,nbins);
dyyL = leaning(dy,y,nbins);
ydyL = leaning(y,dy,nbins);
LIRvec(1,6) = mean(dyy);
LIRvec(2,6) = mean(ydy);
LIRvec(3,6) = mean(dyyL);
LIRvec(4,6) = mean(ydyL);
LIRvec(5,6) = mean(dyy)-mean(ydy);
LIRvec(6,6) = mean(ydy)-mean(dyy);
if( mean(dyy) > mean(ydy) ), truth{6} = 'dy->y'; 
else if( mean(dyy) < mean(ydy) ), truth{6} = 'y->dy'; 
else truth{6} = '??'; end; end;
%{
xdxy = penchants(dy,y,nbins);
yxdx = penchants(y,dy,nbins);
dyyL = leaning(dy,y,nbins);
ydyL = leaning(y,dy,nbins);
LIRvec(1,6) = mean(dyy);
LIRvec(2,6) = mean(ydy);
LIRvec(3,6) = mean(dyyL);
LIRvec(4,6) = mean(ydyL);
LIRvec(5,6) = mean(dyy)-mean(ydy);
LIRvec(6,6) = mean(ydy)-mean(dyy);
if( mean(dyy) > mean(ydy) ), truth{6} = 'dy->y'; 
else if( mean(dyy) < mean(ydy) ), truth{6} = 'y->dy'; 
else truth{6} = '??'; end; end;
%}