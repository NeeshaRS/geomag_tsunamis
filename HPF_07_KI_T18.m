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
%% Plot of raw data

h1=figure(1); %set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto'); 
plot(time,F); ylabel('F (nT)'); 
set(gca,'FontSize',16,'LineWidth',2); xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[3.96825e4 3.9686e4],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[3.96825e4 3.9686e4],'LineStyle','--','Color',[1 0 0]);
print -dpng Raw_Data_T18_F_07_KI.png
print -deps Raw_Data_T18_F_07_KI.eps
%%
h2=figure(2);
plot(time,H); ylabel('H (nT)'); set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[3.18385e4 3.1842e4],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[3.18385e4 3.1842e4],'LineStyle','--','Color',[1 0 0]);
print -dpng Raw_Data_T18_H_07_KI.png
print -deps Raw_Data_T18_H_07_KI.eps
%%
h3=figure(3); 
plot(time,Z); set(gca,'FontSize',16,'LineWidth',2); 
ylabel('Z (nT)'); xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[2.3685e4 2.3688e4],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[2.3685e4 2.3688e4],'LineStyle','--','Color',[1 0 0]);
print -dpng Raw_Data_T18_Z_07_KI.png
print -deps Raw_Data_T18_Z_07_KI.eps
%% High pass filter
% remove variations with periods > 1 hour by spline fit
n=length(time);
fday = [1:n]./daymin; % time axis in decimal days

Xh=.5; % X hour spline
b2 = min(fday):(Xh/24):max(fday);
clc
tic
disp('starting Z spline')
z_sp2=spline(b2,Z'/spline(b2,eye(length(b2)),fday(:))); % spline fit
toc
z_h_f2 = Z' - ppval(z_sp2, fday); %filtered data
toc
disp('starting H spline')
h_sp=spline(b2,H'/spline(b2,eye(length(b2)),fday(:))); % spline fit
h_h_f = H' - ppval(h_sp, fday); %filtered data
toc
disp('starting F spline')
f_sp2=spline(b2,F'/spline(b2,eye(length(b2)),fday(:))); % spline fit
toc
f_h_f2 = F' - ppval(f_sp2, fday); %filtered data
toc

disp('High pass filter done')

%% Plot high pass filter
h1=figure(1); %set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto');
plot(time,f_h_f2); ylabel('F (nT)'); set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[-.25 .2],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-.25 .2],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_T18_F_07_KI.png
print -deps HPF_T18_F_07_KI.eps

%%
h2=figure(2); 
plot(time,h_h_f); ylabel('H (nT)');set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[-.3 .3],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-.3 .3],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_T18_H_07_KI.png
print -deps HPF_T18_H_07_KI.eps

%%
h3=figure(3);  
plot(time,z_h_f2); ylabel('Z (nT)');set(gca,'FontSize',16,'LineWidth',2);
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([T18ETA T18ETA],[-.1 .08],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-.1 .08],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_T18_Z_07_KI.png
print -deps HPF_T18_Z_07_KI.eps