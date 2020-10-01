% Neesha Schnepf
% Read in the Dst Indices for the year encompassing the tsunami event

% Dst indices from: http://wdc.kugi.kyoto-u.ac.jp/wdc/Sec3.html

% Explaination of .dat files at: http://wdc.kugi.kyoto-u.ac.jp/dstae/format/dstformat.html

clc

% Load the complete .dat file
KI07=load('WWW_dstae00027292.dat');

% Save the last 2 digits of the year
year=KI07(:,1);
% Save the month info
month=KI07(:,2);
% Save the day info
day=KI07(:,3);


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
Dst_07_KI=zeros(24*length(year),1);
a=1;
for i=1:length(KI07)
    for j=0:23
        Dst_07_KI(a)=KI07(i,6+j); 
        a=a+1;
    end
end

%% Plot the Dst indices
TsuTime=datenum('2007-01-13 04:23:21');

figure(1)
plot(time,Dst_07_KI)
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'06/01/06', '09/08/06', '12/16/06', '03/25/07', '7/01/07'},...
    'XTick',[time(1) time(2377) time(4753) time(7129) time(end)])
axis([time(1) time(end) -170 40]);
xlabel('Date')
ylabel('Dst Index (nT)')
title('Global Dst Indices')
line([TsuTime TsuTime],[-170 40],'LineStyle','--','Color',[0 0 0],'LineWidth',2)
line([time(1) time(end)],[-50 -50],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([time(1) time(end)],[0 0],'LineStyle','--','Color',[0 1 0],'LineWidth',2)

save Dst_07_KI.mat Dst_07_KI

%% Plot the Dst indices with the wavelet peaks
load ZPeaks_T18_07_KI

figure(2)
plot(time,Dst_07_KI)
set(gca,'FontSize',16)
axis([733047 733063 -40 10]);
set(gca,'XTickLabel',{'1/5','1/7','1/9','1/11','1/13',...
    '1/15','1/17','1/19','1/21'},...
    'XTick',[733047 733049 733051 733053 733055 733057 733059 733061 733063])
xlabel('Date')
ylabel('Dst Index (nT)')
title('Global Dst Indices')
line([TsuTime TsuTime],[-170 40],'LineStyle','--','Color',[0 0 0],'LineWidth',2)
line([time(1) time(end)],[-50 -50],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([time(1) time(end)],[0 0],'LineStyle','--','Color',[0 1 0],'LineWidth',2)

for i=1:length(ZPeaks_T18_07_KI)
   line([ZPeaks_T18_07_KI(i) ZPeaks_T18_07_KI(i)],[-100 40],'LineStyle','--','Color',[0 0 0],'LineWidth',1) 
end