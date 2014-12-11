function [] = LIR_IMGplot(x,y,nbins)

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

figure();
title('LIR leanings (1:xy, 2:dxy, 3:dxdy, 4:xdy, 5:dxx, 6:dyy)');
ylabel('\Delta');
xlabel('see key in title');
axis([0 7 -2 2]);
grid on;
hold on;

xy = penchantsIMG(x,y,nbins);
yx = penchantsIMG(y,x,nbins);
diffIMG = nan(size(xy.data2D));
for iter1 = 1:1:nbins,
    for iter2 = 1:1:nbins,
        diffIMG(iter1,iter2) = xy.data2D(iter1,iter2) - yx.data2D(iter2,iter1);
    end;
end;
plot(ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo','MarkerSize',12)
plot(1,mean(reshape(diffIMG,nbins*nbins,1)),'bx','MarkerSize',12)
plot(1,min(reshape(diffIMG,nbins*nbins,1)),'bv','MarkerSize',12)
plot(1,max(reshape(diffIMG,nbins*nbins,1)),'b^','MarkerSize',12)

dxy = penchantsIMG(dx,y,nbins);
ydx = penchantsIMG(y,dx,nbins);
diffIMG = nan(size(dxy.data2D));
for iter1 = 1:1:nbins,
    for iter2 = 1:1:nbins,
        diffIMG(iter1,iter2) = dxy.data2D(iter1,iter2) - ydx.data2D(iter2,iter1);
    end;
end;
plot(2.*ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo','MarkerSize',12)
plot(2,mean(reshape(diffIMG,nbins*nbins,1)),'bx','MarkerSize',12)
plot(2,min(reshape(diffIMG,nbins*nbins,1)),'bv','MarkerSize',12)
plot(2,max(reshape(diffIMG,nbins*nbins,1)),'b^','MarkerSize',12)

dxdy = penchantsIMG(dx,dy,nbins);
dydx = penchantsIMG(dy,dx,nbins);
diffIMG = nan(size(dxdy.data2D));
for iter1 = 1:1:nbins,
    for iter2 = 1:1:nbins,
        diffIMG(iter1,iter2) = dxdy.data2D(iter1,iter2) - dydx.data2D(iter2,iter1);
    end;
end;
plot(3.*ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo','MarkerSize',12)
plot(3,mean(reshape(diffIMG,nbins*nbins,1)),'bx','MarkerSize',12)
plot(3,min(reshape(diffIMG,nbins*nbins,1)),'bv','MarkerSize',12)
plot(3,max(reshape(diffIMG,nbins*nbins,1)),'b^','MarkerSize',12)

xdy = penchantsIMG(x,dy,nbins);
dyx = penchantsIMG(dy,x,nbins);
diffIMG = nan(size(xdy.data2D));
for iter1 = 1:1:nbins,
    for iter2 = 1:1:nbins,
        diffIMG(iter1,iter2) = xdy.data2D(iter1,iter2) - dyx.data2D(iter2,iter1);
    end;
end;
plot(4.*ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo','MarkerSize',12)
plot(4,mean(reshape(diffIMG,nbins*nbins,1)),'bx','MarkerSize',12)
plot(4,min(reshape(diffIMG,nbins*nbins,1)),'bv','MarkerSize',12)
plot(4,max(reshape(diffIMG,nbins*nbins,1)),'b^','MarkerSize',12)

dxx = penchantsIMG(dx,x,nbins);
xdx = penchantsIMG(x,dx,nbins);
diffIMG = nan(size(xdx.data2D));
for iter1 = 1:1:nbins,
    for iter2 = 1:1:nbins,
        diffIMG(iter1,iter2) = dxx.data2D(iter1,iter2) - xdx.data2D(iter2,iter1);
    end;
end;
plot(5.*ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo','MarkerSize',12)
plot(5,mean(reshape(diffIMG,nbins*nbins,1)),'bx','MarkerSize',12)
plot(5,min(reshape(diffIMG,nbins*nbins,1)),'bv','MarkerSize',12)
plot(5,max(reshape(diffIMG,nbins*nbins,1)),'b^','MarkerSize',12)

dyy = penchantsIMG(dy,y,nbins);
ydy = penchantsIMG(y,dy,nbins);diffIMG = nan(size(dyy.data2D));
for iter1 = 1:1:nbins,
    for iter2 = 1:1:nbins,
        diffIMG(iter1,iter2) = dyy.data2D(iter1,iter2) - ydy.data2D(iter2,iter1);
    end;
end;
plot(6.*ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo','MarkerSize',12)
plot(6,mean(reshape(diffIMG,nbins*nbins,1)),'bx','MarkerSize',12)
plot(6,min(reshape(diffIMG,nbins*nbins,1)),'bv','MarkerSize',12)
plot(6,max(reshape(diffIMG,nbins*nbins,1)),'b^','MarkerSize',12)

% xdxy = penchants2(x,dx,y,nbins);
% yxdx = penchants2E(y,x,dx,nbins);
% diffIMG = nan(size(dxdy.data2D));
% for iter1 = 1:1:nbins,
%     for iter2 = 1:1:nbins,
%         diffIMG(iter1,iter2) = dxdy.data2D(iter1,iter2) - dydx.data2D(iter2,iter1);
%     end;
% end;
% plot(ones(nbins*nbins,1),reshape(diffIMG,nbins*nbins,1),'bo')
% plot(1,mean(reshape(diffIMG,nbins*nbins,1)),'bx')
% plot(1,min(reshape(diffIMG,nbins*nbins,1)),'bv')
% plot(1,max(reshape(diffIMG,nbins*nbins,1)),'b^')
% 
% ydyx = penchants2(y,dy,x,nbins);
% xydy = penchants2E(x,y,dy,nbins);
% LIRpens(1,8) = mean_ignorezero(ydyx,tol);
% LIRpens(2,8) = mean_ignorezero(xydy,tol);
% LIRleans(1,8) = LIRpens(1,8) - LIRpens(2,8);
% if( LIRleans(1,8) > 0 ), truth{8} = 'y&dy->x'; 
% elseif( LIRleans(1,8) < 0 ), truth{8} = 'x->y&dy'; 
% else truth{8} = '??'; end; 
% 
% xdxydy = penchants3(x,dx,y,dy,nbins);
% ydyxdx = penchants3(y,dy,x,dx,nbins);
% LIRpens(1,9) = mean_ignorezero(xdxydy,tol);
% LIRpens(2,9) = mean_ignorezero(ydyxdx,tol);
% LIRleans(1,9) = LIRpens(1,9)-LIRpens(2,9);
% if( LIRleans(1,9) > 0 ), truth{9} = 'x&dx->y&dy'; 
% elseif( LIRleans(1,9) < 0 ), truth{9} = 'y&dy->x&dx'; 
% else truth{9} = '??'; end; 
