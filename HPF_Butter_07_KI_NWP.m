%% Section 1: load datasets
close all; clear all; clc;
addpath ../NWP_data/
load NWP_01-07.mat

addpath ../
load NWPeta.mat
% Time of earthquake origin
timeEQ=datenum('1-13-2007 04:23:21');

NWPeta=datenum('1-13-2007 05:40:00');

daymin=24*60;
sp=int64((timeEQ-Date(1))*daymin)/2-120/2;
ep=int64((NWPeta-Date(1))*daymin)/2+120/2;

Z=Bz(sp:ep);
X=Bx(sp:ep);
Y=By(sp:ep);
H=(X.^2+Y.^2).^.5;
F=(Z.^2+Y.^2+X.^2).^.5;
time=Date(sp:ep);

whos
%% Section 2: Highpass filter the data

maxperiod=1*60*30; % 0.5 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

Zf = filtfilt(B,A,Z);
Hf = filtfilt(B,A,H);
Ff = filtfilt(B,A,F);

disp('Section 2: Highpass filter all the data--- COMPLETE')
%% Plot high pass filter
h1=figure(1); %set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto');
plot(time,Ff); ylabel('F (nT)'); set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_Butter_NWP_F_07_KI.png
print -deps HPF_Butter_NWP_F_07_KI.eps

%%
h2=figure(2); 
plot(time,Hf); ylabel('H (nT)');set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_Butter_NWP_H_07_KI.png
print -deps HPF_Butter_NWP_H_07_KI.eps

%%
h3=figure(3);  
plot(time,Zf); ylabel('Z (nT)');set(gca,'FontSize',16,'LineWidth',2);
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[-1.5 2],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-1.5 2],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_Butter_NWP_Z_07_KI.png
print -deps HPF_Butter_NWP_Z_07_KI.eps