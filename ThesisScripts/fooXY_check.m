g2XY = nan(20,20);
g2YX = nan(20,20);

for row = 1:1:20,
    for col = 1:1:20,
        tempvec = g_storedXY(row,col,:);
        g2XY(row,col) = sum(tempvec.*tempvec);
        
        tempvec = g_storedYX(row,col,:);
        g2YX(row,col) = sum(tempvec.*tempvec);
    end;
end;