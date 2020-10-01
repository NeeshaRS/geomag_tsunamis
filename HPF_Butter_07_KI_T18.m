%% Section 1: load datasets
close all; clear all; clc;

addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Tsunamis/2007_Kuril_Islands/T18/H/
addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011/
load Z18.mat;
load X18.mat;
load Y18.mat;
load t18.mat;

% Time of earthquake origin
timeEQ=datenum('1-13-2007 04:23:21');

addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Tsunamis/2007_Kuril_Islands/T18/KAK_CWA/
load timeKI.mat
load T18ETA.mat
t18a=T18ETA-timeKI(1)

EQo=datenum('2007-01-13 04:23:21.1');
EQT=EQo-timeKI(1);

daymin=24*60;

sp18=int64((timeEQ-t18(1))*daymin)-120;
ep18=int64((T18ETA-t18(1))*daymin)+120;
Z=Z18(sp18:ep18);
X=X18(sp18:ep18);
Y=Y18(sp18:ep18);
H=(X.^2+Y.^2).^.5;
F=(Z.^2+H.^2).^.5;
time=t18(sp18:ep18);

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
line([T18ETA T18ETA],[-.08 .06],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-.08 .06],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_Butter_T18_F_07_KI.png
print -deps HPF_Butter_T18_F_07_KI.eps

%%
h2=figure(2); 
plot(time,Hf); ylabel('H (nT)');set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[-.08 .08],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-.08 .08],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_Butter_T18_H_07_KI.png
print -deps HPF_Butter_T18_H_07_KI.eps

%%
h3=figure(3);  
plot(time,Zf); ylabel('Z (nT)');set(gca,'FontSize',16,'LineWidth',2);
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[-.04 .04],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-.04 .04],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_Butter_T18_Z_07_KI.png
print -deps HPF_Butter_T18_Z_07_KI.eps