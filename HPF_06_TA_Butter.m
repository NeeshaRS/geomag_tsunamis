%% Section 1: load datasets
clear all; clc

addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Tsunamis/2006_Tonga/H
load H15.mat;
load H13.mat;
load H14.mat;
addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011
load Z15.mat;
load Z13.mat;
load Z14.mat;

addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011
load Fc15.mat;
load Fc13.mat;
load Fc14.mat;

load timeTA.mat

% for plotting
addpath /Users/NeeshaSchnepf/RESEARCH/Ocean_mag/Tsunamis/2006_Tonga/KAK_CWA
load TAeta.mat

t13a=T13eta-timeTA(1)
t14a=T14eta-timeTA(1)
t15a=T15eta-timeTA(1)

disp('Section 1: done')
%% Section 2: Setting the start times for the tsunami relevant data
daymin=24*60;

addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011
load t13.mat;
load t14.mat;
load t15.mat;

sp13=int64((timeTA(1)-t13(1))*daymin)+1;
ep13=int64((timeTA(end)-t13(1))*daymin)+1;
Z13=Z13(sp13:ep13);
F13=Fc13(sp13:ep13);
t13=t13(sp13:ep13);

sp14=int64((timeTA(1)-t14(1))*daymin)+1;
ep14=int64((timeTA(end)-t14(1))*daymin)+1;
Z14=Z14(sp14:ep14);
F14=Fc14(sp14:ep14);
t14=t14(sp14:ep14);

sp15=int64((timeTA(1)-t15(1))*daymin)+1;
ep15=int64((timeTA(end)-t15(1))*daymin)+1;
Z15=Z15(sp15:ep15);
F15=Fc15(sp15:ep15);
t15=t15(sp15:ep15);

clc
disp('Section 2: done')
whos
%% Section 3: Highpass filter the data

maxperiod=1*60*30; % 0.5 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

Zf13 = filtfilt(B,A,Z13);
Zf14 = filtfilt(B,A,Z14);
Zf15 = filtfilt(B,A,Z15);

Hf13 = filtfilt(B,A,H13);
Hf14 = filtfilt(B,A,H14);
Hf15 = filtfilt(B,A,H15);

disp('Section 3: Highpass filter all the data--- COMPLETE')

%% Section 4: Plot the filtered data
n=length(timeTA);
fday = [1:n]./daymin; % time axis in decimal days

% Time of earthquake
EQo=datenum('2006-05-03 15:26:40.2');
EQT=EQo-timeTA(1);

figure(4)%------------- FIGURE 1
plot(fday, Zf13,'LineWidth',1,'Color',[0 0 0])
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
axis([(EQT-0.0208) (t15a+0.0625) -.1 .1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([t13a t13a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
xlabel('Date')
ylabel('Z Amplitude (nT)')
% title('Highpass filtered data for the 5/3/2006 Tonga event- T13 Z component')

print -dpng  'HPF_Butter_T13_Z_06_TA.png';
%%
figure(5)%------------- FIGURE 2
plot(fday, Zf14)
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'4/30','5/4','5/8'},...
  'XTick',[4  8  12])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([t13a t13a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T14 Z component')

%%
figure(6)%------------- FIGURE 3
plot(fday, Zf15)
set(gca,'FontSize',16)
set(gca,'XTickLabel',{'4/30','5/4','5/8'},...
  'XTick',[4  8  12])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
line([t13a t13a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',2)
xlabel('Date')
ylabel('Z Amplitude (nT)')
title('Highpass filtered data for the 5/3/2006 Tonga event- T15 Z component')