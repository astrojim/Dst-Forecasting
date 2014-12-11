

% for iter = 2:1:20,
%     penIMG = penchantsIMG(x,y,iter);
%     imagesc(penIMG.CbincenterX,penIMG.EbincenterY,penIMG.data2D);
%     colorbar();
%     pause(3);
% end;
nbins = 3;
for B = 0,

    [x,y] = wTS(20,B,[1 5 15],[2 2 2]);

    penvecIMG1 = penchantsIMG(y,x,nbins);
    penvecIMG2 = penchantsIMG(x,y,nbins);
    diffIMG = nan(size(penvecIMG1.data2D));
    for iter1 = 1:1:nbins,
        for iter2 = 1:1:nbins,
            diffIMG(iter1,iter2) = penvecIMG1.data2D(iter1,iter2) - penvecIMG2.data2D(iter2,iter1);
        end;
    end;

    figure();
    subplot(1,3,1);
    imagesc(diffIMG);
    colorbar();
    xlabel('x bins');
    ylabel('y bins');
    title('\Delta_{yx}');
    
    subplot(1,3,2);
    imagesc(penvecIMG1.data2D);
    colorbar();
    xlabel('x bins');
    ylabel('y bins');
    title('\rho_{yx}');
        
    subplot(1,3,3);
    imagesc(penvecIMG2.data2D);
    colorbar();
    xlabel('y bins');
    ylabel('x bins');
    title('\rho_{xy}');
    
    penvecIMG1.data2D
    penvecIMG2.data2D
    diffIMG
    
    figure();
    plot(ones(9,1),reshape(diffIMG,9,1),'bo')
    hold on;
    plot(1,mean(reshape(diffIMG,9,1)),'bx')
    plot(1,min(reshape(diffIMG,9,1)),'bv')
    plot(1,max(reshape(diffIMG,9,1)),'b^')

end;
