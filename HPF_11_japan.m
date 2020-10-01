%% Section 1: load datasets
close all; clear all; clc;

load kakH_2011_03.mat
load kakZ_2011_03.mat
load timeKAK.mat

timeEQ=datenum('03-11-2011 05:46:24.1');
teta=datenum('03-11-2011 06:46:24.1');

daymin=24*60;
sp=int64((timeEQ-time(1))*daymin)-60;
ep=int64((teta-time(1))*daymin)+180;

Z=kakZ(sp:ep);
H=kakH(sp:ep);
F=(Z.^2+H.^2).^.5;
time=time(sp:ep);

whos
%% Plot of raw data

h1=figure(1); set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto');
subplot(221); set(gca,'FontSize',16,'LineWidth',2); 
plot(time,F); ylabel('F (nT)'); xlabel('Time (March 11, 2011)')
datetick('x',15); xlim([time(1) time(end)]);

subplot(222); set(gca,'FontSize',16,'LineWidth',2); 
plot(time,H); ylabel('H (nT)'); xlabel('Time (March 11, 2011)')
datetick('x',15); xlim([time(1) time(end)]);

subplot(224); set(gca,'FontSize',16,'LineWidth',2); 
plot(time,Z); ylabel('Z (nT)'); xlabel('Time (March 11, 2011)')
datetick('x',15); xlim([time(1) time(end)]);
%% High pass filter
% remove variations with periods > 1 hour by spline fit
n=length(time);
fday = [1:n]./daymin; % time axis in decimal days

Xh=.25; % X hour spline
b2 = min(fday):(Xh/24):max(fday);
clc
tic
disp('starting Z spline')
z_sp2=spline(b2,Z'/spline(b2,eye(length(b2)),fday(:))); % spline fit
toc
z_h_f2 = Z' - ppval(z_sp2, fday); %filtered data
toc
disp('starting H spline')
x_sp2=spline(b2,H'/spline(b2,eye(length(b2)),fday(:))); % spline fit
toc
x_h_f2 = H' - ppval(x_sp2, fday); %filtered data
toc
disp('starting F spline')
f_sp2=spline(b2,F'/spline(b2,eye(length(b2)),fday(:))); % spline fit
toc
f_h_f2 = F' - ppval(f_sp2, fday); %filtered data
toc

disp('High pass filter done')

%% Plot high pass filter
h1=figure(1); set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto');
subplot(221); set(gca,'FontSize',16,'LineWidth',2); 
plot(time,f_h_f2); ylabel('F (nT)'); xlabel('Time (March 11, 2011)')
datetick('x',15); xlim([time(1) time(end)]); ylim([-2.5 2.5]);

subplot(222); set(gca,'FontSize',16,'LineWidth',2); 
plot(time,x_h_f2); ylabel('H (nT)'); xlabel('Time (March 11, 2011)')
datetick('x',15); xlim([time(1) time(end)]); ylim([-2.5 2]);


subplot(224); set(gca,'FontSize',16,'LineWidth',2); 
plot(time,z_h_f2); ylabel('Z (nT)'); xlabel('Time (March 11, 2011)')
datetick('x',15); xlim([time(1) time(end)]); ylim([-2 2]);
 

print -dpng HPF_KAK_11_Japan.png
print -deps HPF_KAK_11_Japan.eps