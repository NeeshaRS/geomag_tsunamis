% Complez wavelet analysis
% 2007 tsunami: 01/13/07 04:23:21
% X component

%% Section 1: Load the data
clear all
clc

addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011/
addpath /Users/NeeshaSchnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2007_Kuril_Islands/H/
load H18.mat % raw data
load t18.mat % the time

% Time of earthquake
EQT=datenum('2007-01-13 04:23:21.1');
% Initial time
IT=EQT-15;
% End time
ET=EQT+15;

eta18= 8143; % s, water elevation arrival time

dayseconds=24*60*60;
daymin=24*60;

% Expected time tsunami arrives at station
T18ETA=EQT+eta18/dayseconds;
save T18ETA.mat T18ETA
T18ETAs=(T18ETA-IT)*daymin;

H18=H18(~isnan(H18));

startp=int64((IT-t18(1))*daymin)+1;
endp=int64((ET-t18(1))*daymin)+1;

F=H18(startp:endp);
fday=t18(startp:endp);
ts1 = F-nanmean(F);

disp('Section 1 complete')
%% Section 2: Fit Splines

b1 = min(fday):(1/24):max(fday);

sp=spline(b1,ts1(:)'/spline(b1,eye(length(b1)),fday(:)'));

ts=ts1-ppval(fday,sp);

disp('Section 2 complete')
%% Section 3: Plot
figure(1)
hold on
plot(fday,ts);
datetick('x',1);
perdiod_in_minutes = [1:100];
set(gca,'FontSize',16)
line([T18ETA T18ETA],[-.4 .4],'Color',[1 0 0])
axis([-inf inf -inf inf]);
xlabel('Time (2007-01-12 to 2007-01-13)')
ylabel('Field Magnitude (nT)')
title('H Component')

disp('Section 3 complete')
%% Section 4: Complex wavelet transform

% waven  = 'morl';
waven = 'cgau4';

% Sc = scal2frq(1./(fliplr(perdiod_in_minutes)*60),waven,1); %to get desired scales for a set of frequencies
Sc = scal2frq(logspace(-3,-1,10),waven,1); %to get desired scales for a set of frequencies
% Sc = [100:10:1000];

ch = cwt(ts,fliplr(Sc),waven);%Complex wavelet transform
perd = 1./scal2frq(Sc,waven,1);

save ch.mat ch

disp('Section 4 complete')
%% Section 5: Plot of complex wavelet transform
% imagesc(fday,fliplr(perd)/60,abs(c));
figure(1)
imagesc(fday,fliplr(perd)/60,abs(ch(:,1:10:end)));
set(gca,'FontSize',16)

caxis([0,2.5]);
axis([733054.5 733055.5 0 16]);
set(gca,'XTickLabel',{'1/12 12:00','1/12 18:00','1/13 00:00', '1/13 06:00', '1/13 12:00'},...
    'XTick',[733054.5 733054.75 733055 733055.25 733055.5])
line([T18ETA T18ETA],[0 16],'LineStyle','--','Color',[1 1 1],'LineWidth',1)


% axis([733047 733063 0 16]);
% set(gca,'XTickLabel',{'1/5','1/7','1/9','1/11','1/13',...
%     '1/15','1/17','1/19','1/21'},...
%     'XTick',[733047 733049 733051 733053 733055 733057 733059 733061 733063])
% caxis([0,7]);
colorbar
xlabel('Date')
ylabel('Period (min)')
title('2007 Kuril Islands-- T18 H wavelet analysis (1/5-21/2007)')

disp('Section 5 complete')
