load IRTolCheck_L500_lowtol.mat;

rows = size(ytolDist,1);
cols = size(ytolDist,2);
rowstep = 4;
colstep = 100;
rowvec = 1:rowstep:rows;
colvec = 1:colstep:cols;

varmat = zeros(rows,cols);
for rit = 1:1:rows,
    for cit = 1:1:cols,
        varmat(rit,cit) = var(ytolDist{rit,cit});
    end;
end;


figure();

step = 1;
for iter1 = rowvec,
    for iter2 = colvec,

        subplot(length(rowvec),length(colvec),step);
        step = step + 1;
        hist(ytolDist{iter1,iter2},20);
        hold on;
        title(sprintf('ytol = %f, pen num = %i',xytol(iter1),iter2));
                
    end;
end;