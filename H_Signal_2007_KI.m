% Neesha Schnepf
% The magnetic field H value during the tsunami time period
% 2007 tsunami: 01/13/07 04:23:21

%% Section 1: Setting the initial times
clc
% clear all

% Initial time
IT=datenum('2007-01-13 04:00:00');
% Time of earthquake
EQT=datenum('2007-01-13 04:23:21.1');


eta18= 8143; % s, water elevation arrival time

dayseconds=24*60*60;
daymin=24*60;

% Expected time tsunami arrives at station
T18eta=EQT+eta18/dayseconds;
T18etas=(T18eta-IT)*daymin;

disp('Section 1: done')
%% Section 2: Load the data
addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011

load X18.mat % raw data
load t18.mat % the time
X18=X18(~isnan(X18));

load Y18.mat % raw data
load t18.mat % the time
Y18=Y18(~isnan(Y18));

disp('Section 2: done')

%% Section 3: Make & save H
H18=(X18.^2+Y18.^2).^(0.5);

disp('Section 3: done')

%% Section 4: Setting the start times for the tsunami relevant data

% Have the time match that of the land station
addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Tsunamis/2007_Kuril_Islands/KAK_CWA
load timeKI.mat

% sp18=int64((timeKI(1)-t18(1))*daymin)+1;
% ep18=int64((timeKI(end)-t18(1))*daymin)+1;

sp18=int64((IT-t18(1))*daymin)+1;
ep18=int64((T18ETA-t18(1))*daymin)+180;

disp('Section 4: done')
%% Section 5: Saving the relevant time frame for CWA
H18KI=H18(sp18:ep18);
% save H18KI.mat H18KI

disp('Section 5: done')