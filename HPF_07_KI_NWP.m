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
%% Plot of raw data

h1=figure(1); %set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto'); 
plot(time,F); ylabel('F (nT)'); 
set(gca,'FontSize',16,'LineWidth',2); xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[4.5275e4 4.5305e4],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[4.5275e4 4.5305e4],'LineStyle','--','Color',[1 0 0]);
print -dpng Raw_Data_NWP_F_07_KI.png
print -deps Raw_Data_NWP_F_07_KI.eps
%%
h2=figure(2);
plot(time,H); ylabel('H (nT)'); set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[2.7675e4 2.7705e4],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[2.7675e4 2.7705e4],'LineStyle','--','Color',[1 0 0]);
print -dpng Raw_Data_NWP_H_07_KI.png
print -deps Raw_Data_NWP_H_07_KI.eps
%%
h3=figure(3); 
plot(time,Z); set(gca,'FontSize',16,'LineWidth',2); 
ylabel('Z (nT)'); xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[3.5834e4 3.5848e4],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[3.5834e4 3.5848e4],'LineStyle','--','Color',[1 0 0]);
print -dpng Raw_Data_NWP_Z_07_KI.png
print -deps Raw_Data_NWP_Z_07_KI.eps
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
line([NWPeta NWPeta],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_NWP_F_07_KI.png
print -deps HPF_NWP_F_07_KI.eps

%%
h2=figure(2); 
plot(time,h_h_f); ylabel('H (nT)');set(gca,'FontSize',16,'LineWidth',2); 
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-1.5 1.5],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_NWP_H_07_KI.png
print -deps HPF_NWP_H_07_KI.eps

%%
h3=figure(3);  
plot(time,z_h_f2); ylabel('Z (nT)');set(gca,'FontSize',16,'LineWidth',2);
xlabel('Time (Jan. 13, 2007)')
datetick('x',15); xlim([time(1) time(end)]);
line([NWPeta NWPeta],[-1.5 2],'LineStyle','--','Color',[1 0 0]);
line([timeEQ timeEQ],[-1.5 2],'LineStyle','--','Color',[1 0 0]);
print -dpng HPF_NWP_Z_07_KI.png
print -deps HPF_NWP_Z_07_KI.eps