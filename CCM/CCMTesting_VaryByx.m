L = [100];
%Edim = 3;
EdimX = [2:1:10];
EdimY = [2:1:10];
%tau = 1;%[1:1:5];
tauX = [1:1:5];
tauY = [1:1:10];

plotdataEdimsTaus = zeros(length(EdimX),length(EdimY),length(tauX),length(tauY),2);
plotdataEdims_fft = zeros(length(EdimX),length(EdimY),2);
plotdataEdimvTau = zeros(length(EdimX),length(tauX),2);

Byx_vec = [0.0001,0.001,0.01,0.1,0.2,0.5,1.0];
plotByxDiff = zeros(length(EdimX),length(Byx_vec));

%for lstep = 1:length(L),
%printf('============= L = %i ==\n',L(lstep));
lstep = 1;

for bstep = 1:1:length(Byx_vec),

X = zeros(L(lstep),1);
Y = X;
X(1) = 0.4;
Y(1) = 0.2;
rx = 3.8;%3.1;%
ry = 3.5;%3.9;%
Bxy = 0.01;%0.2;%
%Byx = 0.2;%0.002;%
Byx = Byx_vec(bstep);

for fstep = 1:(length(X)-1),
	X(fstep+1) = X(fstep)*(rx-rx*X(fstep)-Bxy*Y(fstep));
    Y(fstep+1) = Y(fstep)*(ry-ry*Y(fstep)-Byx*X(fstep));
end;

for estepX = 1:length(EdimX),
	XY = CCM(Y,X,EdimX(estepX),1);
	YX = CCM(X,Y,EdimX(estepX),1);
    plotByxDiff(estepX,bstep) = XY-YX;
end;

end;

plotByxDiff
plot(EdimX,plotByxDiff(:,1),'.',EdimX,plotByxDiff(:,2),'o',EdimX,plotByxDiff(:,3),'x',...
     EdimX,plotByxDiff(:,4),'v',EdimX,plotByxDiff(:,5),'^',EdimX,plotByxDiff(:,6),'>');
xlabel('E');
ylabel('\Delta');
legend('\beta_{yx} = 0.0001','\beta_{yx} = 0.001','\beta_{yx} = 0.01',...
       '\beta_{yx} = 0.1','\beta_{yx} = 0.2','\beta_{yx} = 0.5',...
       '\beta_{yx} = 1.0');
grid on;

%{
for tstepX = 1:length(tauX),
	for tstepY = 1:length(tauY),
		for estepX = 1:length(EdimX),
			for estepY = 1:length(EdimY),
    			plotdataEdimsTaus(estepX,estepY,tstepX,tstepY,1) = CCM(Y,X,EdimY(estepY),tauY(tstepY));
        		plotdataEdimsTaus(estepX,estepY,tstepX,tstepY,2) = CCM(X,Y,EdimX(estepX),tauX(tstepX));
            end;
        end;
    end;
end;
diffMat = plotdataEdimsTaus(:,:,:,:,1)-plotdataEdimsTaus(:,:,:,:,2); 
diffMat_diag = diag(reshape(diffMat(1,1,:,:),length(tauX),length(tauY)));
plot(diffMat_diag,'.');
%imagesc(diffMat);
%}

%{
for tstepX = 1:length(tauX),
	for estepX = 1:length(EdimX),
 			plotdataEdimvTau(estepX,tstepX,1) = CCM(Y,X,EdimX(estepX),tauX(tstepX));
            plotdataEdimvTau(estepX,tstepX,2) = CCM(X,Y,EdimX(estepX),tauX(tstepX));
    end;
end;
diffMat = plotdataEdimvTau(:,:,1)-plotdataEdimvTau(:,:,2); 
diffMat
%}

%{
fX = fft(X);
fY = fft(Y);
fX_clipped = abs(fX).^2;
fY_clipped = abs(fY).^2;
%fX_clipped = fX_clipped(2:(length(X)/2));
%fY_clipped = fY_clipped(2:(length(Y)/2));

for estepX = 1:length(EdimX),
	for estepY = 1:length(EdimY),
    	plotdataEdims(estepX,estepY,1) = CCM(Y,X,EdimY(estepY),1);
        plotdataEdims(estepX,estepY,2) = CCM(X,Y,EdimX(estepX),1);
        plotdataEdims_fft(estepX,estepY,1) = CCM(fY_clipped,fX_clipped,EdimY(estepY),1);
        plotdataEdims_fft(estepX,estepY,2) = CCM(fX_clipped,fY_clipped,EdimX(estepX),1);
    end;
end;

diffMat = plotdataEdims(:,:,1)-plotdataEdims(:,:,2); 
diffMat_fft = plotdataEdims_fft(:,:,1)-plotdataEdims_fft(:,:,2);
%plot(diag(diffMat),'.');
%plot(diag(diffMat_fft),'.');
%imagesc(diffMat)
%imagesc(diffMat_fft)
diffMat
diffMat_fft
%}
%end;

