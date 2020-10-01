% Neesha Schnepf
% Tonga 2006 tsunami: 5/3/06 15:26:40.2

clc
clear all

%% Section 1: Relevant parameters

dayseconds=24*60*60;
daymin=24*60;

% Time of earthquake origin
EQT=datenum('2006-05-03 15:26:40.2');

% Using Chao An's water elevation profiles,
% these are the estimated times of arrival
% in seconds after the earthquake origin:
eta13= 34298; 
eta14= 33374; 
eta15= 33832; 

% The tsunami's estimated time of arrival for each station
T13ETA=EQT+eta13/dayseconds;	% Station T13
T14ETA=EQT+eta14/dayseconds;    % Station T14
T15ETA=EQT+eta15/dayseconds;    % Station T15

disp(datestr(T13ETA))
disp(datestr(T14ETA))
disp(datestr(T15ETA))

disp('Section 1: Relevant parameters--- COMPLETE')

%% Section 2: Load in the data
% The directory containing all the data
addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011
addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/KAK_CWA/Data_files_CWA_06_TA

% Station T13
load Z13.mat % raw data
load t13.mat % the time

% Station T14
load Z14.mat % raw data
load t14.mat % the time

% Station T15
load Z15.mat % raw data
load t15.mat % the time

disp('Section 2: Load in the data--- COMPLETE')

%% Section 3: Save the tsunami relevant time frame

addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/KAK_CWA
load timeTA.mat

% Start of time frame
IT=datenum('2006-05-03 00:00:00');
ET=datenum('2006-05-05 00:00:00');

% Calculate the arrival time of the tsunami in
% minutes after the start of the time frame
T13etas=(T13ETA-IT)*daymin; % Station T13
T14etas=(T14ETA-IT)*daymin; % Station T14
T15etas=(T15ETA-IT)*daymin; % Station T15

% Set the start and end points within the data
sp13=int64((timeTA(1)-t13(1))*daymin)+1;
ep13=int64((timeTA(end)-t13(1))*daymin)+1;

sp14=int64((timeTA(1)-t14(1))*daymin)+1;
ep14=int64((timeTA(end)-t14(1))*daymin)+1;

sp15=int64((timeTA(1)-t15(1))*daymin)+1;
ep15=int64((timeTA(end)-t15(1))*daymin)+1;

% Save the time series within the relevant time frame
tr3=t13(sp13:ep13); % Station T13
tr4=t14(sp14:ep14); % Station T14
tr5=t15(sp15:ep15); % Station T15

% Save the number of minutes from the start of the 
% time frame until the end
m13=[0:1:length(tr3)-1]';    % Station T13
m14=[0:1:length(tr4)-1]';    % Station T14
m15=[0:1:length(tr5)-1]';    % Station T15

disp('Section 3: Save the tsunami relevant time frame--- COMPLETE')

%% Section 4: Highpass filter the data, 2 day window

maxperiod=1*60*60; % 1 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

Z2f13 = filtfilt(B,A,Z13);
Z2f14 = filtfilt(B,A,Z14);
Z2f15 = filtfilt(B,A,Z15);

disp('Section 4: Highpass filter the data, 2 day window--- COMPLETE')

%% Section 5: Plot the filtered data-- 2 day window

figure(1)%------------- FIGURE 1
plot(tr3, Z2f13,'LineWidth',1)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
line([T13ETA T13ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/12) (T13ETA+1/8) -.2 .2])
set(gca,'XTickLabel',{'05/03/2006 13:30','05/03/2006 20:30', '05/04/2006 03:30'},...
    'XTick',[7.328005625000000e+05  7.328008541666666e+05 7.328011458333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T13 Z component')

figure(2)%------------- FIGURE 2
plot(tr4, Z2f14)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
line([T14ETA T14ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/12) (T14ETA+1/8) -.2 .2])
set(gca,'XTickLabel',{'05/03/2006 13:30','05/03/2006 20:30', '05/04/2006 03:30'},...
    'XTick',[7.328005625000000e+05  7.328008541666666e+05 7.328011458333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T14 Z component')

figure(3)%------------- FIGURE 3
plot(tr5, Z2f15)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
line([T15ETA T15ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/12) (T15ETA+1/8) -.4 .3])
set(gca,'XTickLabel',{'05/03/2006 13:30','05/03/2006 20:30', '05/04/2006 03:30'},...
    'XTick',[7.328005625000000e+05  7.328008541666666e+05 7.328011458333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T15 Z component')

%% Section 6: Highpass filter all the data

maxperiod=1*60*60; % 1 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

Zf13 = filtfilt(B,A,Z13);
Zf14 = filtfilt(B,A,Z14);
Zf15 = filtfilt(B,A,Z15);

disp('Section 4: Highpass filter all the data--- COMPLETE')

%% Section 7: Plot the filtered data

figure(4)%------------- FIGURE 1
plot(t13, Zf13,'LineWidth',1)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
line([T13ETA T13ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/12) (T13ETA+1/8) -.2 .2])
set(gca,'XTickLabel',{'05/03/2006 13:30','05/03/2006 20:30', '05/04/2006 03:30'},...
    'XTick',[7.328005625000000e+05  7.328008541666666e+05 7.328011458333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T13 Z component')

%%
figure(5)%------------- FIGURE 2
plot(t14, Zf14)
line([T14ETA T14ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/12) (T14ETA+1/8) -.2 .2])
set(gca,'XTickLabel',{'05/03/2006 13:30','05/03/2006 20:30', '05/04/2006 03:30'},...
    'XTick',[7.328005625000000e+05  7.328008541666666e+05 7.328011458333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T14 Z component')

%%
figure(6)%------------- FIGURE 3
plot(t15, Zf15)
line([T15ETA T15ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/12) (T15ETA+1/8) -.2 .2])
set(gca,'XTickLabel',{'05/03/2006 13:30','05/03/2006 20:30', '05/04/2006 03:30'},...
    'XTick',[7.328005625000000e+05  7.328008541666666e+05 7.328011458333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T15 Z component')