% Complez wavelet analysis
% 2006 tsunami: 5/3/06 15:26:40.2
% Z component

%% Section 1: Load the data
clear all
clc

addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011

% Time of earthquake
EQT=datenum('2006-05-03 15:26:40.2');
% Initial time
IT=EQT-15;
% End time
ET=EQT+15;

% Time of tsunami arrival
EQT13=datenum('2006-05-04 0:58:40');
EQT14=datenum('2006-05-04 1:07:40');
EQT15=datenum('2006-05-04 0:52:10');
daymin=24*60;
disp('Section 1 complete')
%% Section 2: Load the data
addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011/
addpath /Users/NeeshaSchnepf/RESEARCH/Ocean_mag/Research/Matlab_stuff/
% Station T13
load Z13.mat % raw data
load t13.mat % the time
Z13=Z13(~isnan(Z13));

% Station T14
load Z14.mat % raw data
load t14.mat % the time
Z14=Z14(~isnan(Z14));

% Station T15
load Z15.mat % raw data
load t15.mat % the time
Z15=Z15(~isnan(Z15));

disp('Section 2: done')

%% Section 3: Setting the start times for the tsunami relevant data

% Have the time match that of the land station
addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/Land_Stations/06_TA_matlab_files
load time_06_TA.mat

sp13=int64((time(1)-t13(1))*daymin)+1;
ep13=int64((time(end)-t13(1))*daymin)+1;

sp14=int64((time(1)-t14(1))*daymin)+1;
ep14=int64((time(end)-t14(1))*daymin)+1;

sp15=int64((time(1)-t15(1))*daymin)+1;
ep15=int64((time(end)-t15(1))*daymin)+1;

disp('Section 3: done')
%% Section 4: Saving the relevant time frame
Z13=Z13(sp13:ep13);
t3=t13(sp13:ep13);
clear t13

Z14=Z14(sp14:ep14);
t4=t14(sp14:ep14);
clear t14

Z15=Z15(sp15:ep15);
t5=t15(sp15:ep15);
clear t15

ts13 = Z13-nanmean(Z13);
ts14 = Z14-nanmean(Z14);
ts15 = Z15-nanmean(Z15);

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

%% Section 7: Complex wavelet transform

% waven  = 'morl';
waven = 'cgau4';

% Sc = scal2frq(1./(fliplr(perdiod_in_minutes)*60),waven,1); %to get desired scales for a set of frequencies
Sc = scal2frq(logspace(-3,-1,10),waven,1); %to get desired scales for a set of frequencies
% Sc = [100:10:1000];

c13z = cwt(ts3,fliplr(Sc),waven);%Complex wavelet transform
c14z = cwt(ts4,fliplr(Sc),waven);
c15z = cwt(ts5,fliplr(Sc),waven);
save c13z.mat c13z
save c14z.mat c14z
save c15z.mat c15z

perd = 1./scal2frq(Sc,waven,1);

disp('Section 7: done')
%%
addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/Cross_Wavelet_Analysis/Cross_Wavelet_Amp

load T13ETA.mat
load T14ETA.mat
load T15ETA.mat
%% Section 8: Plot of complex wavelet transform
figure(1)
% imagesc(fday,fliplr(perd)/60,abs(c));
% imagesc(t3,fliplr(perd)/60,abs(c13z(:,1:10:end)));
imagesc(t4,fliplr(perd)/60,abs(c14z(:,1:10:end)));
% imagesc(t5,fliplr(perd)/60,abs(c15z(:,1:10:end)));
set(gca,'FontSize',16)

axis([732797 732807 0 16]);
set(gca,'XTickLabel',{'4/30','5/2','5/4','5/6',...
    '5/8','5/10'},...
    'XTick',[732797 732799 732801 732803 ...
    732805 732807])

% axis([732800.5 732801.5 0 16]);
% set(gca,'XTickLabel',{'5/3 12:00','5/3 18:00','5/4 00:00','5/4 06:00','5/4 12:00'},...
%     'XTick',[732800.5 732800.75 732801 732801.25 732801.5])
% caxis([0,2]);
line([T15ETA T15ETA],[0 16],'LineStyle','--','Color',[1 1 1],'LineWidth',1)

% caxis([0,5]);

colorbar%('horiz');
xlabel('Date')
ylabel('Period (min)')
% title('2006 Tonga-- Z Component at T14 (4/20-5/20/2006)')
% title('2006 Tonga-- Z Component at T13 (5/3-5/2006)')

disp('Section 8: done')