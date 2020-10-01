% Neesha Schnepf
% Read in the Dst Indices for the year encompassing the tsunami event

% Dst indices from: http://wdc.kugi.kyoto-u.ac.jp/wdc/Sec3.html

% Explaination of .dat files at: http://wdc.kugi.kyoto-u.ac.jp/dstae/format/dstformat.html

clc

% Load the complete .dat file
TA06=load('WWW_dstae00027263.dat');

% Save the last 2 digits of the year
year=TA06(:,1);
% Save the month info
month=TA06(:,2);
% Save the day info
day=TA06(:,3);


% Use these to create time points
time=zeros(24*length(year),1);
a=1;
for i=1:length(year)
    for j=0:23
        time(a)=datenum(['200' num2str(year(i,1)) '-' num2str(month(i,1)) '-' num2str(day(i,1)) ' ' num2str(j) ':00']);
        a=a+1;
    end
end

% Load the Dst 
Dst_06_TA=zeros(24*length(year),1);
a=1;
for i=1:length(TA06)
    for j=0:23
        Dst_06_TA(a)=TA06(i,6+j); 
        a=a+1;
    end
end

%% Plot the Dst indices
TsuTime=datenum('2006-05-03 15:26:40');

figure(1)
plot(time,Dst_06_TA)
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'11/01/05', '02/08/06', '05/18/06', '08/25/06', '12/01/06'},...
    'XTick',[time(1) time(2377) time(4753) time(7129) time(end)])
axis([time(1) time(end) -100 40]);
xlabel('Date')
ylabel('Dst Index (nT)')
title('Global Dst Indices')
line([TsuTime TsuTime],[-100 40],'LineStyle','--','Color',[0 0 0],'LineWidth',2)
line([time(1) time(end)],[-50 -50],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([time(1) time(end)],[0 0],'LineStyle','--','Color',[0 1 0],'LineWidth',2)

%% Plot the Dst indices with the wavelet peaks
load ZPeaks_T13_06_TA
load ZPeaks_T14_06_TA
load ZPeaks_T15_06_TA

figure(2)
plot(time,Dst_06_TA)
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'4/26', '4/28', '4/30','5/2','5/4','5/6',...
    '5/8','5/10','5/12'},...
    'XTick',[732793 732795 732797 732799 732801 732803 ...
    732805 732807 732809])
axis([732793 732809 -60 40]);

line([TsuTime TsuTime],[-100 40],'LineStyle','--','Color',[0 0 0],'LineWidth',2)
line([time(1) time(end)],[-50 -50],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([time(1) time(end)],[0 0],'LineStyle','--','Color',[0 1 0],'LineWidth',2)

xlabel('Date')
ylabel('Dst Index (nT)')
title('Global Dst Indices')

% for i=1:length(ZPeaks_T13_06_TA)
%    line([ZPeaks_T13_06_TA(i) ZPeaks_T13_06_TA(i)],[-100 40],'LineStyle','--','Color',[0 0 0],'LineWidth',1) 
% end
% for i=1:length(ZPeaks_T14_06_TA)
%    line([ZPeaks_T14_06_TA(i) ZPeaks_T14_06_TA(i)],[-100 40],'LineStyle','--','Color',[0 0 0],'LineWidth',1) 
% end
for i=1:length(ZPeaks_T15_06_TA)
   line([ZPeaks_T15_06_TA(i) ZPeaks_T15_06_TA(i)],[-100 40],'LineStyle','--','Color',[0 0 0],'LineWidth',1) 
end

save Dst_06_TA.mat Dst_06_TA