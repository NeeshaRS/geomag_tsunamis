function [CWA_plot, zoom_plot, maxamp, maxtime] = F_CWA_plot(a, maxT, time, etaT, CWAp, fname)
% Inputs
% a : the periods for the periodogram's y axis
% maxT: the max period allowed. Given in seconds.
% time : the date/time info corresponding to the periodogram's x axis
% etaT: the estimated time of arrival of the tsunami wave
% CWAp: the periodogram matrix resulting from the cross wavelet analysis
% fname: string for auto-saving the figure as a png

% Outputs
% CWA_plot: the periodogram for the entire timespan
% zoom_plot: periodogram for 3 hours encompassing the tsunami's arrival
% maxamp: the max magnetic signal
% maxtime: the time of the max magnetic signal

% the color map
for i=1
    map= [1.0000    1.0000    1.0000
    1.0000    1.0000    0.8333
    1.0000    1.0000    0.6667
    1.0000    1.0000    0.5000
    1.0000    1.0000    0.3333
    1.0000    1.0000    0.1667
    1.0000    1.0000         0
    1.0000    0.9333         0
    1.0000    0.8667         0
    1.0000    0.8000         0
    1.0000    0.7333         0
    1.0000    0.6667         0
    1.0000    0.6000         0
    1.0000    0.5333         0
    1.0000    0.4667         0
    1.0000    0.4000         0
    1.0000    0.3333         0
    1.0000    0.2667         0
    1.0000    0.2000         0
    1.0000    0.1333         0
    1.0000    0.0667         0
    1.0000         0         0
    1.0000         0    0.0909
    1.0000         0    0.1818
    1.0000         0    0.2727
    1.0000         0    0.3636
    1.0000         0    0.4545
    1.0000         0    0.5455
    1.0000         0    0.6364
    1.0000         0    0.7273
    1.0000         0    0.8182
    1.0000         0    0.9091
    1.0000         0    1.0000];
end

% The first periodogram
CWA_plot=figure(); 
set(CWA_plot,'Position',[100 100 1100 200],'PaperPositionMode','auto');
colormap(map);
imagesc(time,a,CWAp);  
set(gca, 'FontSize', 16); 
datetick('x');
if ~isnan(etaT)
    line([etaT etaT],[0 400],'LineStyle','--','Color',[0 0 0],'LineWidth',0.25)
end
xlim([time(1) time(end)]);
ylim([0 2*maxT/60]);  
h=colorbar;
set(h,'fontsize',14); 
set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Time (HH:MM)'); 
ylabel('Period (min)'); 

fname1= [fname '.png'];
saveas(CWA_plot,fname1)
disp([fname1 ' saved.'])

% The zoomed in periodogram
if ~isnan(etaT)
    zoom_plot=figure();
    colormap(map);
    imagesc(time,a,CWAp);
    set(gca, 'FontSize', 16);
    line([etaT etaT],[0 400],'LineStyle','--','Color',[0 0 0],'LineWidth',0.25)
    xlim([(etaT-1.5/24) (etaT+2/24)]);
    
    xticks=linspace((etaT-1.5/24),(etaT+2/24),4);
    xlabels=datestr(linspace((etaT-1.5/24),(etaT+2/24),4));
    set(gca,'XTickLabel',{xlabels(1,13:17),xlabels(2,13:17),xlabels(3,13:17),xlabels(4,13:17)},...
        'XTick',[xticks(1),xticks(2),xticks(3),xticks(4)])
    
    ylim([0 20]); % max of 2*maxT/60
    h=colorbar;
    set(h,'fontsize',14);
    set(get(h,'ylabel'),'string','nT','fontsize',14);
    xlabel('Time (HH:MM)');
    ylabel('Period (min)');
    
    % Find the max amp & time
    flatten=max(CWAp);
    [maxamp,i]=max(flatten);
    maxtime=time(i);
    
    fname2= [fname '_zoom.png'];
    saveas(zoom_plot,fname2)
    disp([fname2 ' saved.'])
else
    zoom_plot= NaN;
    maxamp= NaN;
    maxtime= NaN;
end