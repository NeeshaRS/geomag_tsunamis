% Complez wavelet analysis
% 2006 tsunami: 5/3/06 15:26:40.2
% F component

%% Section 1: Load the data
clear all
clc

addpath /Users/NeeshaSchnepf/RESEARCH/Summer/Hollings/Research/Matlab_stuff

% Initial time
IT=datenum('2006-04-26 12:00:00');
% IT=datenum('2006-05-03 12:00:00');
% End time
ET=datenum('2006-05-12 12:00:00');
% ET=datenum('2006-05-05 12:00:00');
% Time of tsunami arrival
EQT13=datenum('2006-05-04 0:58:40');
EQT14=datenum('2006-05-04 1:07:40');
EQT15=datenum('2006-05-04 0:52:10');

eta13=34320; %s, water elevation arrival time
eta14= 34860; %s
eta15= 33930; % s

dayminutes=24*60*60;
dayseconds=24*60*60;
daymin=24*60;

% Expected time tsunami arrives at each station
% T13
T13eta=EQT13+eta13/dayminutes;
T13etas=(T13eta-IT)*daymin;
% T14
T14eta=EQT14+eta14/dayminutes;
T14etas=(T14eta-IT)*daymin;
% T15
T15eta=EQT15+eta15/dayminutes;
T15etas=(T15eta-IT)*daymin;

disp('Section 1 complete')
%% Section 2: Load the data
% Station T13
load Fc13.mat % raw data
load t13.mat % the time
Fc13=Fc13(~isnan(Fc13));

% Station T14
load Fc14.mat % raw data
load t14.mat % the time
Fc14=Fc14(~isnan(Fc14));

% Station T15
load Fc15.mat % raw data
load t15.mat % the time
Fc15=Fc15(~isnan(Fc15));

disp('Section 2: done')

%% Section 3: Setting the start times for the tsunami relevant data

sp13=int64((IT-t13(1))*daymin)+1;
ep13=int64((ET-t13(1))*daymin);

sp14=int64((IT-t14(1))*daymin)+1;
ep14=int64((ET-t14(1))*daymin);

sp15=int64((IT-t15(1))*daymin)+1;
ep15=int64((ET-t15(1))*daymin);

disp('Section 3: done')
%% Section 4: Saving the relevant time frame
F13=Fc13(sp13:ep13);
clear Fc13
t3=t13(sp13:ep13);
clear t13

F14=Fc14(sp14:ep14);
clear Fc14
t4=t14(sp14:ep14);
clear t14

F15=Fc15(sp15:ep15);
clear Fc15
t5=t15(sp15:ep15);
clear t15

ts13 = F13-nanmean(F13);
ts14 = F14-nanmean(F14);
ts15 = F15-nanmean(F15);

m13=[0:1:length(t3)-1]';
m14=[0:1:length(t4)-1]';
m15=[0:1:length(t5)-1]';

disp('Section 4: done')
%% Section 5: Fit Splines

b13 = min(t3):(1/24):max(t3);
sp13=spline(b13,ts13(:)'/spline(b13,eye(length(b13)),t3(:)'));
ts3=ts13-ppval(t3,sp13);

b14 = min(t4):(1/24):max(t4);
sp14=spline(b14,ts14(:)'/spline(b14,eye(length(b14)),t4(:)'));
ts4=ts14-ppval(t4,sp14);

b15 = min(t5):(1/24):max(t5);
sp15=spline(b15,ts15(:)'/spline(b15,eye(length(b15)),t5(:)'));
ts5=ts15-ppval(t5,sp15);

disp('Section 5: done')
%% Section 6: Plot
figure(1)
hold on
% plot(t3,ts3);
plot(t4,ts4);
% plot(t5,ts5);
datetick('x',1);
perdiod_in_minutes = [1:100];
set(gca,'FontSize',16)
line([T13eta T13eta],[-.4 .4],'Color',[1 0 0])
axis([-inf inf -inf inf]);
xlabel('Time (2006-05-02 to 2006-05-04)')
ylabel('Field Magnitude (nT)')
title('F Field Magnitude')

disp('Section 6: done')
%% Section 7: Complex wavelet transform

% waven  = 'morl';
waven = 'cgau4';

% Sc = scal2frq(1./(fliplr(perdiod_in_minutes)*60),waven,1); %to get desired scales for a set of frequencies
Sc = scal2frq(logspace(-3,-1,10),waven,1); %to get desired scales for a set of frequencies
% Sc = [100:10:1000];

c13 = cwt(ts3,fliplr(Sc),waven);%Complex wavelet transform
c14 = cwt(ts4,fliplr(Sc),waven);
c15 = cwt(ts5,fliplr(Sc),waven);
perd = 1./scal2frq(Sc,waven,1);

disp('Section 7: done')
%% Section 8: Plot of complex wavelet transform
figure(1)
% imagesc(fday,fliplr(perd)/60,abs(c));
% imagesc(t3,fliplr(perd)/60,abs(c13(:,1:10:end)));
% imagesc(t4,fliplr(perd)/60,abs(c14(:,1:10:end)));
imagesc(t5,fliplr(perd)/60,abs(c15(:,1:10:end)));
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'4/27','4/28','4/29','4/30','5/1','5/2','5/3','5/4','5/5','5/6','5/7','5/8','5/9','5/10','5/11'},...
    'XTick',[732794 732795 732796 732797 732798 732799 732800 732801 732802 732803 732804 732805 732806 732807 732808])
% set(gca,'XTickLabel',{'5/3 12:00','5/4 00:00','5/4 12:00','5/5 00:00','5/5 12:00'},...
%     'XTick',[7.328005000000000e+05 732801 7.328015000000000e+05 732802 732802.5])
axis([-inf inf 0 16]);
% caxis([0,20]);
% caxis([0,2.5]);
colorbar%('horiz');
xlabel('Date')
ylabel('Period (min)')
title('2006 Tonga-- F Field Magnitude at T15 (4/26-5/12/2006)')
% title('2006 Tonga-- F Field Magnitude at T13 (5/3-5/2006)')

disp('Section 8: done')

%% Section 9: Cross-Spectra
% T13 & T14
F34 = c13.* conj(c14);
cc34 = abs(max(max(abs(F34))) - abs(F34) );
w34 = (cc34./max(max(cc34)));

% T13 & T15
F35 = c13.* conj(c15);
cc35 = abs(max(max(abs(F35))) - abs(F35) );
w35 = (cc35./max(max(cc35)));

figure(2)
% imagesc(t3,perd/60,abs(c13).*w34);
imagesc(t3,perd/60,log10(abs(F34)));
set(gca,'FontSize',16)
datetick('x',0);
axis([-inf inf 0 16]);
set(gca,'XTickLabel',{'4/27/2006','','','','','','5/3/2006','','','','','','','','5/11/2006'},...
    'XTick',[732794 732795 732796 732797 732798 732799 732800 732801 732802 732803 732804 732805 732806 732807 732808])
% caxis([0,50]);
% caxis([0,2.5]);
colorbar%('vert');
xlabel('Date')
ylabel('Period (min)')
title('2006 Tonga-- F Field Magnitude Cross-Wavelet (4/26-5/11/2006)')

disp('Section 8: done')

