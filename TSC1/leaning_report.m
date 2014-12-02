function [] = leaning_report(x,y,nbins,tol,lags)

lenvec = laggedlean(x,y,nbins,tol,lags);
[truth,LIRpens,LIRleans] = LIR(x,y,nbins,tol);

fprintf('\n-------------------------\n');
fprintf('Lagged Leanings:\n');
fprintf('  [lag,leaning] :: guess\n');
for iter = 1:1:length(lags),
    fprintf('  %i,%.7f :: ',lags(iter),lenvec(iter,1));
    if( lenvec(iter,1) > 0 ),
        fprintf('x_{t+%i}->y\n',lags(iter));
    elseif( lenvec(iter,1) < 0 ),
        fprintf('y->x_{t+%i}\n',lags(iter));
    else
        fprintf('??\n');
    end;
end;

fprintf('\n-------------------------\n');
fprintf('LIR Leanings:\n');
fprintf('  [ID,leaning] :: guess\n');
fprintf('  (x,y),%.7f :: %s\n',LIRleans(1,1),truth{1});
fprintf('  (dx,y),%.7f :: %s\n',LIRleans(1,2),truth{2});
fprintf('  (dx,dy),%.7f :: %s\n',LIRleans(1,3),truth{3});
fprintf('  (x,dy),%.7f :: %s\n',LIRleans(1,4),truth{4});
fprintf('  (dx,x),%.7f :: %s\n',LIRleans(1,5),truth{5});
fprintf('  (dy,y),%.7f :: %s\n',LIRleans(1,6),truth{6});
fprintf('  (x&dx,y),%.7f :: %s\n',LIRleans(1,7),truth{7});
fprintf('  (y&dy,x),%.7f :: %s\n',LIRleans(1,8),truth{8});
fprintf('  (x&dx,y&dy),%.7f :: %s\n',LIRleans(1,9),truth{9});
