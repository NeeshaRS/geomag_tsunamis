function [CWA_plot, zoom_plot, maxamp, maxtime] = F_CWA_plot(a, maxT, time, etaT, CWAp)
% Inputs
% a : the periods for the periodogram's y axis
% maxT: the max period allowed. Given in seconds.
% time : the date/time info corresponding to the periodogram's x axis
% etaT: the estimated time of arrival of the tsunami wave
% CWAp: the periodogram matrix resulting from the cross wavelet analysis

% Outputs
% CWA_plot: the periodogram for the entire timespan
% zoom_plot: periodogram for 3 hours encompassing the tsunami's arrival
% maxamp: the max magnetic signal
% maxtime: the time of the max magnetic signal

% The first periodogram
CWA_plot=figure(); 
set(CWA_plot,'Position',[100 100 1100 200],'PaperPositionMode','auto');
colormap(jet);
imagesc(time,a,CWAp);  
set(gca, 'FontSize', 16); 
datetick('x');
line([etaT etaT],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
xlim([time(1) time(end)]);
ylim([0 2*maxT/60]); 
h=colorbar;
set(h,'fontsize',14); 
set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Time (HH:MM)'); 
ylabel('Period (min)'); 

% The zoomed in periodogram
zoom_plot=figure(); 
colormap(jet);
imagesc(time,a,CWAp);  
set(gca, 'FontSize', 16); 
line([etaT etaT],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
xlim([(etaT-1.5/24) (etaT+2/24)]);

xticks=linspace((etaT-1.5/24),(etaT+2/24),4);
xlabels=datestr(linspace((etaT-1.5/24),(etaT+2/24),4));
set(gca,'XTickLabel',{xlabels(1,13:17),xlabels(2,13:17),xlabels(3,13:17),xlabels(4,13:17)},...
    'XTick',[xticks(1),xticks(2),xticks(3),xticks(4)])

ylim([0 2*maxT/60]); 
h=colorbar;
set(h,'fontsize',14); 
set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Time (HH:MM)'); 
ylabel('Period (min)'); 

% Find the max amp & time
flatten=max(CWAp);
[maxamp,i]=max(flatten);
maxtime=time(i);

