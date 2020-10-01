% Neesha Schnepf
% Kuril Islands 2007 tsunami: 1/13/07 4:23:21

clc
clear all

%% Section 1: Relevant parameters

dayseconds=24*60*60;
dayminutes=24*60;

% Time of earthquake origin
EQT=datenum('2007-1-13 04:23:21');

% Using Chao An's water elevation profiles,
% these are the estimated times of arrival
% in seconds after the earthquake origin:
eta18= 9078; 

% The tsunami's estimated time of arrival for each station
T18ETA=EQT+eta18/dayseconds;	% Station T18

disp(datestr(T18ETA))

disp('Section 1: Relevant parameters--- COMPLETE')

%% Section 2: Load in the data
% The directory containing all the data
addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011
addpath /Users/NeeshaSchnepf/RESEARCH/Ocean_mag/Research/Matlab_stuff

% Station T18
load Z18.mat % raw data
load t18.mat % the time
Z18=Z18(~isnan(Z18));

disp('Section 2: Load in the data--- COMPLETE')

%% Section 3: Save the tsunami relevant time frame

% Start of time frame
IT=datenum('2007-1-12 00:00:00');
ET=datenum('2007-1-14 00:00:00');

% Calculate the arrival time of the tsunami in
% minutes after the start of the time frame
T18etas=(T18ETA-IT)*dayminutes; % Station T18

% Set the start and end points within the data
sp18=int64((IT-t18(1))*dayminutes)+1;   % Station T18
ep13=int64((ET-t18(1))*dayminutes)+1; % Station T18

% Save the data series within the relevant time frame
Zr18=Z18(sp18:ep13);    % Station T18

% Save the time series within the relevant time frame
tr8=t18(sp18:ep13); % Station T18

% Save the number of minutes from the start of the 
% time frame until the end
m18=[0:1:length(tr8)-1]';    % Station T18

disp('Section 3: Save the tsunami relevant time frame--- COMPLETE')

%% Section 4: Highpass filter the data, 2 day window

% maxperiod=60*60; % 1 hour is the max period
maxperiod=20*60; % 20 min is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

Z2f18 = filtfilt(B,A,Zr18);

disp('Section 4: Highpass filter the data, 2 day window--- COMPLETE')

%% Section 5: Plot the filtered data-- 2 day window

figure(1)%------------- FIGURE 1
plot(tr8, Z2f18,'LineWidth',1)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
line([T18ETA T18ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/6) (T18ETA+1/8) -.1 .1])
set(gca,'XTickLabel',{'01/13/2007 00:30','01/13/2007 03:30', '01/13/2007 06:30', '01/13/2007 09:30'},...
    'XTick',[7.330550208333334e+05 7.330551458333334e+05 7.330552708333334e+05 7.330553958333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 1/13/2007 Kuril Islands event- T18 Z component')

%% Section 6: Highpass filter all the data

% maxperiod=60*60; % 1 hour is the max period
maxperiod=20*60; % 20 min is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

Zf18 = filtfilt(B,A,Z18);

disp('Section 4: Highpass filter all the data--- COMPLETE')

%% Section 7: Plot the filtered data

figure(4)%------------- FIGURE 1
plot(t18, Zf18,'LineWidth',1)
line([EQT EQT],[-1 1],'LineStyle','--','Color',[1 0 1],'LineWidth',1)
line([T18ETA T18ETA],[-1 1],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([(EQT-1/6) (T18ETA+1/8) -.15 .15])
set(gca,'XTickLabel',{'01/13/2007 00:30','01/13/2007 03:30', '01/13/2007 06:30', '01/13/2007 09:30'},...
    'XTick',[7.330550208333334e+05 7.330551458333334e+05 7.330552708333334e+05 7.330553958333334e+05])
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 1/13/2007 Kuril Islands event- T18 Z component')