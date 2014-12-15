function penout = pen(x,y)

pEyesC_count = 1;
for iterYcompare = 2:1:length(y),
    for iterYcheck = 3:1:length(y),
        if( (y(iterYcheck) == y(iterYcompare)) && (x(iterYcheck-1) == x(iterYcompare-1)) ),
            pEyesC_count = pEyesC_count + 1;
        end;
    end;
    
    %save these individually somehow
end;

for iterX = 1:1:(length(x)-1),
    % count the number of times x(iterYcheck-1)
end;

%find prob y(iterYcheck)

%find prob x(iterYcheck-1)