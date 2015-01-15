printnum = 4;

if( printnum == 1),
    load TestingLeanWithPairsReport_pt01tol.mat;
    tol = '1e-2';
    tag = '01';
elseif( printnum == 2), 
    load TestingLeanWithPairsReport_pt001tol.mat;
    tol = '1e-3';
    tag = '001';
elseif( printnum == 3),
    load TestingLeanWithPairsReport_pt0001tol.mat;
    tol = '1e-4';
    tag = '0001';
elseif( printnum == 4),
    load TestingLeanWithPairsReport_pt00001tol.mat;
    tol = '1e-5';
    tag = '00001';
else
   ferror('Wrong printnum');
end;

width = 8;
height = 4;

figure('Units', 'inches', ...
'Position', [0 0 width height],...
'PaperPositionMode','auto');

hold on;
numColors = 2;
cmap = colormap(flipud(gray(numColors)));

% hImg = imagesc(lout_saved);
hImg = pcolor(lout_saved);
set(gca,'YDir','normal');

xlim([1 10]);
ylim([1 88]);
caxis([0 1]);
cbar = colorbar();
set(cbar,'Visible','off');

hXLabel = xlabel('Test #');
hYLabel = ylabel('Data Pair #');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

htitle = title(sprintf('Does guess match truth for a given test and data pair? (1 = yes, black) [tol = %s]',tol));
set(htitle,'FontName','Times');
set(htitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
fn = sprintf('./tempTestingLeanPairs_tol%s.eps',tag);
print('-depsc2',fn);
close;