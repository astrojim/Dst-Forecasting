B = [0:0.01:1.0];
xytol = [0:0.01:1];

leans_stored = nan(length(B),length(xytol));
tcolorp = nan(length(B),length(xytol));

x = [0,2,0,0,0,0,0,2,0,0];

for outer = 1:1:length(xytol),
    for step = 1:1:length(B),
        
        y = zeros(1,length(x));
        for iter = 2:1:length(y),
            y(iter) = x(iter-1) + B(step)*randn();
        end;

        leans_temp = leans_lagged(x,y,0,xytol(outer),1);
        leans_stored(step,outer) = leans_temp(1,2);
        if( leans_stored(step,outer) > 0 ),
            tcolorp(step,outer) = 1;
        elseif( leans_stored(step,outer) < 0 ),
            tcolorp(step,outer) = -1; 
        else
            tcolorp(step,outer) = 0;
        end;
        
%         if( isnan(leans_stored(step,outer)) ),
%             pause
%         end;
        
    end;
end;

