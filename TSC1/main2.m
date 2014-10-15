LinearEx

binnum = 2000;
fprintf('L = %i, BINNUM = %i\n',length(x),binnum);

tendXY = tendency(x,y,binnum);
tendYX = tendency(y,x,binnum);
tendYdy = tendency(y,yd,binnum);
tenddyY = tendency(yd,y,binnum);
tendXdx = tendency(x,xd,binnum);
tenddxX = tendency(xd,x,binnum);
tendXdy = tendency(x,yd,binnum);
tenddyX = tendency(yd,x,binnum);
tenddxY = tendency(xd,y,binnum);
tendYdx = tendency(y,xd,binnum);
tenddxdy = tendency(xd,yd,binnum);
tenddydx = tendency(yd,xd,binnum);

fprintf('No Shift Means:\n');
fprintf(' tendXY: %.20f\n',mean(mean(tendXY)));
fprintf(' tendYX: %.20f\n',mean(mean(tendYX)));
fprintf(' tendXdx: %.20f\n',mean(mean(tendXdx)));
fprintf(' tenddxX: %.20f\n',mean(mean(tenddxX)));
fprintf(' tendYdy: %.20f\n',mean(mean(tendYdy)));
fprintf(' tenddyY: %.20f\n',mean(mean(tenddyY)));
fprintf(' tendXdy: %.20f\n',mean(mean(tendXdy)));
fprintf(' tenddyX: %.20f\n',mean(mean(tenddyX)));
fprintf(' tenddxY: %.20f\n',mean(mean(tenddxY))); 
fprintf(' tendYdx: %.20f\n',mean(mean(tendYdx))); 
fprintf(' tenddxdy: %.20f\n',mean(mean(tenddxdy))); 
fprintf(' tenddydx: %.20f\n',mean(mean(tenddydx))); 

clear all;
LinearEx
binnum = 1000;

tendXYp1 = tendency(x(2:end),y(1:end-1),binnum);
tendYXp1 = tendency(y(2:end),x(1:end-1),binnum);
tendYdyp1 = tendency(y(2:end),yd(1:end-1),binnum);
tenddyYp1 = tendency(yd(2:end),y(1:end-1),binnum);
tendXdxp1 = tendency(x(2:end),xd(1:end-1),binnum);
tenddxXp1 = tendency(xd(2:end),x(1:end-1),binnum);
tendXdyp1 = tendency(x(2:end),yd(1:end-1),binnum);
tenddyXp1 = tendency(yd(2:end),x(1:end-1),binnum);
tenddxYp1 = tendency(xd(2:end),y(1:end-1),binnum);
tendYdxp1 = tendency(y(2:end),xd(1:end-1),binnum);
tenddxdyp1 = tendency(xd(2:end),yd(1:end-1),binnum);
tenddydxp1 = tendency(yd(2:end),xd(1:end-1),binnum);

fprintf('Cause Shift to Past by 1 Means:\n');
fprintf(' tendXYp1: %.20f\n',mean(mean(tendXYp1)));
fprintf(' tendYXp1: %.20f\n',mean(mean(tendYXp1)));
fprintf(' tendXdxp1: %.20f\n',mean(mean(tendXdxp1)));
fprintf(' tenddxXp1: %.20f\n',mean(mean(tenddxXp1)));
fprintf(' tendYdyp1: %.20f\n',mean(mean(tendYdyp1)));
fprintf(' tenddyYp1: %.20f\n',mean(mean(tenddyYp1)));
fprintf(' tendXdyp1: %.20f\n',mean(mean(tendXdyp1)));
fprintf(' tenddyXp1: %.20f\n',mean(mean(tenddyXp1)));
fprintf(' tenddxYp1: %.20f\n',mean(mean(tenddxYp1))); 
fprintf(' tendYdxp1: %.20f\n',mean(mean(tendYdxp1))); 
fprintf(' tenddxdyp1: %.20f\n',mean(mean(tenddxdyp1))); 
fprintf(' tenddydxp1: %.20f\n',mean(mean(tenddydxp1))); 

clear all;
LinearEx
binnum = 1000;

tendXYp2 = tendency(x(3:end),y(1:end-2),binnum);
tendYXp2 = tendency(y(3:end),x(1:end-2),binnum);
tendYdyp2 = tendency(y(3:end),yd(1:end-2),binnum);
tenddyYp2 = tendency(yd(3:end),y(1:end-2),binnum);
tendXdxp2 = tendency(x(3:end),xd(1:end-2),binnum);
tenddxXp2 = tendency(xd(3:end),x(1:end-2),binnum);
tendXdyp2 = tendency(x(3:end),yd(1:end-2),binnum);
tenddyXp2 = tendency(yd(3:end),x(1:end-2),binnum);
tenddxYp2 = tendency(xd(3:end),y(1:end-2),binnum);
tendYdxp2 = tendency(y(3:end),xd(1:end-2),binnum);
tenddxdyp2 = tendency(xd(3:end),yd(1:end-2),binnum);
tenddydxp2 = tendency(yd(3:end),xd(1:end-2),binnum);

fprintf('Cause Shift to Past by 2 Means:\n');
fprintf(' tendXYp2: %.20f\n',mean(mean(tendXYp2)));
fprintf(' tendYXp2: %.20f\n',mean(mean(tendYXp2)));
fprintf(' tendXdxp2: %.20f\n',mean(mean(tendXdxp2)));
fprintf(' tenddxXp2: %.20f\n',mean(mean(tenddxXp2)));
fprintf(' tendYdyp2: %.20f\n',mean(mean(tendYdyp2)));
fprintf(' tenddyYp2: %.20f\n',mean(mean(tenddyYp2)));
fprintf(' tendXdyp2: %.20f\n',mean(mean(tendXdyp2)));
fprintf(' tenddyXp2: %.20f\n',mean(mean(tenddyXp2)));
fprintf(' tenddxYp2: %.20f\n',mean(mean(tenddxYp2))); 
fprintf(' tendYdxp2: %.20f\n',mean(mean(tendYdxp2))); 
fprintf(' tenddxdyp2: %.20f\n',mean(mean(tenddxdyp2))); 
fprintf(' tenddydxp2: %.20f\n',mean(mean(tenddydxp2))); 

clear all;
LinearEx
binnum = 1000;

tendXYf1 = tendency(x(1:end-1),y(2:end),binnum);
tendYXf1 = tendency(y(1:end-1),x(2:end),binnum);
tendYdyf1 = tendency(y(1:end-1),yd(2:end),binnum);
tenddyYf1 = tendency(yd(1:end-1),y(2:end),binnum);
tendXdxf1 = tendency(x(1:end-1),xd(2:end),binnum);
tenddxXf1 = tendency(xd(1:end-1),x(2:end),binnum);
tendXdyf1 = tendency(x(1:end-1),yd(2:end),binnum);
tenddyXf1 = tendency(yd(1:end-1),x(2:end),binnum);
tenddxYf1 = tendency(xd(1:end-1),y(2:end),binnum);
tendYdxf1 = tendency(y(1:end-1),xd(2:end),binnum);
tenddxdyf1 = tendency(xd(1:end-1),yd(2:end),binnum);
tenddydxf1 = tendency(yd(1:end-1),xd(2:end),binnum);

fprintf('Cause Shift to Future by 1 Means:\n');
fprintf(' tendXYf1: %.20f\n',mean(mean(tendXYf1)));
fprintf(' tendYXf1: %.20f\n',mean(mean(tendYXf1)));
fprintf(' tendXdxf1: %.20f\n',mean(mean(tendXdxf1)));
fprintf(' tenddxXf1: %.20f\n',mean(mean(tenddxXf1)));
fprintf(' tendYdyf1: %.20f\n',mean(mean(tendYdyf1)));
fprintf(' tenddyYf1: %.20f\n',mean(mean(tenddyYf1)));
fprintf(' tendXdyf1: %.20f\n',mean(mean(tendXdyf1)));
fprintf(' tenddyXf1: %.20f\n',mean(mean(tenddyXf1)));
fprintf(' tenddxYf1: %.20f\n',mean(mean(tenddxYf1))); 
fprintf(' tendYdxf1: %.20f\n',mean(mean(tendYdxf1))); 
fprintf(' tenddxdyf1: %.20f\n',mean(mean(tenddxdyf1))); 
fprintf(' tenddydxf1: %.20f\n',mean(mean(tenddydxf1))); 

clear all;
LinearEx
binnum = 1000;

tendXYf2 = tendency(x(1:end-2),y(3:end),binnum);
tendYXf2 = tendency(y(1:end-2),x(3:end),binnum);
tendYdyf2 = tendency(y(1:end-2),yd(3:end),binnum);
tenddyYf2 = tendency(yd(1:end-2),y(3:end),binnum);
tendXdxf2 = tendency(x(1:end-2),xd(3:end),binnum);
tenddxXf2 = tendency(xd(1:end-2),x(3:end),binnum);
tendXdyf2 = tendency(x(1:end-2),yd(3:end),binnum);
tenddyXf2 = tendency(yd(1:end-2),x(3:end),binnum);
tenddxYf2 = tendency(xd(1:end-2),y(3:end),binnum);
tendYdxf2 = tendency(y(1:end-2),xd(3:end),binnum);
tenddxdyf2 = tendency(xd(1:end-2),yd(3:end),binnum);
tenddydxf2 = tendency(yd(1:end-2),xd(3:end),binnum);

fprintf('Cause Shift to Future by 2 Means:\n');
fprintf(' tendXYf2: %.20f\n',mean(mean(tendXYf2)));
fprintf(' tendYXf2: %.20f\n',mean(mean(tendYXf2)));
fprintf(' tendXdxf2: %.20f\n',mean(mean(tendXdxf2)));
fprintf(' tenddxXf2: %.20f\n',mean(mean(tenddxXf2)));
fprintf(' tendYdyf2: %.20f\n',mean(mean(tendYdyf2)));
fprintf(' tenddyYf2: %.20f\n',mean(mean(tenddyYf2)));
fprintf(' tendXdyf2: %.20f\n',mean(mean(tendXdyf2)));
fprintf(' tenddyXf2: %.20f\n',mean(mean(tenddyXf2)));
fprintf(' tenddxYf2: %.20f\n',mean(mean(tenddxYf2))); 
fprintf(' tendYdxf2: %.20f\n',mean(mean(tendYdxf2))); 
fprintf(' tenddxdyf2: %.20f\n',mean(mean(tenddxdyf2))); 
fprintf(' tenddydxf2: %.20f\n',mean(mean(tenddydxf2))); 
