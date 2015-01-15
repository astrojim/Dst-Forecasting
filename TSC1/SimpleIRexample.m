B = [0:0.01:1.0];
xytol = [0:0.01:2];

leans_stored = nan(length(B),length(xytol));
for outer = 1:1:length(xytol),
    for step = 1:1:length(B),

        x = [0,2,0,0,0,0,0,2,0,0];
        y = zeros(1,length(x));

        for iter = 2:1:length(y),
            y(iter) = x(iter-1) + B(step)*randn();
        end;

        leans_temp = leans_lagged(x,y,0,xytol(outer),1);
        leans_stored(step,outer) = leans_temp(1,2);

    end;
end;

figure('Units', 'inches', ...
'Position', [0 0 8 4],...
'PaperPositionMode','auto');

hold on;
cmap = colormap(flipud(gray(16)));

hImage1 = imagesc(xytol,B,leans_stored);
set(gca,'YDir','normal');
hold on;

hCont2 = contour(xytol,B,leans_stored,...
            [0.00 0.00],'r','LineWidth',2);

xlim([0 2]);
ylim([0 1]);
% 
% caxis([-0.8 0.8]);
cbar = colorbar();
set(cbar,'Visible','on');

hXLabel = xlabel('\delta_y [y tolerance]');
hYLabel = ylabel('B [noise level]');

set([hXLabel, hYLabel],'FontName','Times');
set([hXLabel, hYLabel],'FontSize', 15);

hSubtitle = title('');
set(hSubtitle,'FontName','Times');
set(hSubtitle,'FontSize', 15);
set(gca,'fontsize',15);

hold off;
print -depsc2 ./SimpleIRexample_plot.eps
close;
