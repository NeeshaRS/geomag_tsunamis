% Code written by N. R. Schnepf & Manoj Nair
%% Section 1: load datasets
clear all; clc

addpath ../NWP_data/
load NWP_01-07.mat
addpath ../
load NWPeta.mat
addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Tsunamis/2007_Kuril_Islands/KAK
load KAKH_KI.mat

load timeKI.mat;
% resample kak to 2 minute
kak = KAKH_KI(1:2:end);
timeKI = timeKI(1:2:end);
% kak=KAKH_KI;

% Time of earthquake origin
timeEQ=datenum('1-13-2007 04:23:21');

whos

disp('Section 1: done')
%% Section 2: Setting the start times for the tsunami relevant data
daymin=24*60;

sp=int64((timeKI(1)-Date(1))*daymin)/2+1;
ep=int64((timeKI(end)-Date(1))*daymin)/2+1;
Z=Bz(sp:ep);
X=Bx(sp:ep);
Y=By(sp:ep);
H=(X.^2+Y.^2).^.5;
time=Date(sp:ep);

clc; whos;
disp('Section 2: done')
%% spline filtering
% remove variations with periods > 1 hour by spline fit
n=length(timeKI);
fday = [1:n]./daymin; % time axis in decimal days
b1 = min(fday):(.25/24):max(fday); % knots separated by .25 hour

kak_sp=spline(b1,kak'/spline(b1,eye(length(b1)),fday(:))); % spline fit
kak_h_f = kak' - ppval(kak_sp, fday); %filtered data

% H data
h_sp=spline(b1,H'/spline(b1,eye(length(b1)),fday(:))); % spline fit
h_h_f = H' - ppval(h_sp, fday); %filtered data

% Z data
z_sp=spline(b1,Z'/spline(b1,eye(length(b1)),fday(:))); % spline fit
z_h_f = Z' - ppval(z_sp, fday); %filtered data

% save h_h_f_KI.mat h_h_f;
% save z_h_f_KI.mat z_h_f;

disp('data filtered')

%% Section 3: Highpass filter the data

maxperiod=1*60*30; % 0.5 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

z_h_f = filtfilt(B,A,Z);
h_h_f = filtfilt(B,A,H);
kak_h_f = filtfilt(B,A,kak);

disp('Section 3: Highpass filter all the data--- COMPLETE')
%% cross wavelet spectra
Sc = 0.1:0.1:200; % You will need to play around with the frequencies a bit
waven = 'cgau4';
perd = 1./scal2frq(Sc,waven,60); % 60 = sampling interval in seconds

kakhw = cwt(kak_h_f,Sc,waven);%Complex wavelet transform
hhw = cwt(h_h_f,Sc,waven);%Complex wavelet transform
zhw = cwt(z_h_f,Sc,waven);%Complex wavelet transform

%
a=perd/60;
kakhw1=abs(kakhw);
hhw1=abs(hhw);
zhw1=abs(zhw);

disp('done')
%%
% save hhwKI.mat hhw; % save kakhwKI.mat kakhw; 
% save zhwKI.mat zhw;
%% Finally produce a weight matrix. You will need to determine which remote
% observatory best removes the noise in Z
tic
Hxy = kakhw .* conj(hhw);
cc = abs(max(max(abs(Hxy))) - abs(Hxy) );
weight = (cc./max(max(cc)));
% Now apply the weight to the wavelet spectrum of Z
wKZ = (abs(zhw).*weight);

Hxy1=abs(Hxy);
wKZ1=abs(wKZ); toc
%%
% save Final_plot.mat zhw1 kakhw1 hhw1 Hxy1 wKZ1 timeKI a
disp('saved')
%% Set the color map for Amplitude
map = [1.0000    1.0000    1.0000
    1.0000    1.0000    0.8333
    1.0000    1.0000    0.6667
    1.0000    1.0000    0.5000
    1.0000    1.0000    0.3333
    1.0000    1.0000    0.1667
    1.0000    1.0000         0
    1.0000    0.9333         0
    1.0000    0.8667         0
    1.0000    0.8000         0
    1.0000    0.7333         0
    1.0000    0.6667         0
    1.0000    0.6000         0
    1.0000    0.5333         0
    1.0000    0.4667         0
    1.0000    0.4000         0
    1.0000    0.3333         0
    1.0000    0.2667         0
    1.0000    0.2000         0
    1.0000    0.1333         0
    1.0000    0.0667         0
    1.0000         0         0
    1.0000         0    0.0909
    1.0000         0    0.1818
    1.0000         0    0.2727
    1.0000         0    0.3636
    1.0000         0    0.4545
    1.0000         0    0.5455
    1.0000         0    0.6364
    1.0000         0    0.7273
    1.0000         0    0.8182
    1.0000         0    0.9091
    1.0000         0    1.0000];

%%
h1=figure(5); set(h1,'Position',[100 100 1100 700],'PaperPositionMode','auto');
subplot(311); 
imagesc(timeKI,a,zhw1); set(gca, 'FontSize', 16);  colormap(jet);
h=colorbar; caxis([0 1.5]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);
ylim([0 15]); xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
line([NWPeta NWPeta],[0 200],'LineStyle','--','Color',[0 0 0],'LineWidth',0.25)
% text(.15,2,'NWP Z Wavelet Amplitudes', 'FontSize', 18,'Color',[1 1 1]);
xlabel('Date'); ylabel('Period (min)'); 

% subplot(512); 
% imagesc(timeKI,a,kakhw1);  set(gca, 'FontSize', 14); 
% h=colorbar; caxis([0 1.5]); set(h,'fontsize',12); set(get(h,'ylabel'),'string','nT','fontsize',14);
% xlim([timeKI(1) timeKI(end)]);
% set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
%     'XTick',[733052 733056 733060 ])
% line([NWPeta NWPeta],[0 200],'LineStyle','--','Color',[0 0 0],'LineWidth',0.25)
% ylim([0 15]);  % text(.15,2,'KAK H Wavelet Amplitudes', 'FontSize', 18,'Color',[1 1 1]);
% xlabel('Date'); ylabel('Period (min)'); 

% subplot(513);
% imagesc(timeKI,a,hhw1);  set(gca, 'FontSize', 14); 
% line([NWPeta NWPeta],[0 200],'LineStyle','--','Color',[0 0 0],'LineWidth',0.25)
% h=colorbar; caxis([0 1.5]); set(h,'fontsize',12); set(get(h,'ylabel'),'string','nT','fontsize',14);
% xlim([timeKI(1) timeKI(end)]);
% set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
%     'XTick',[733052 733056 733060 ])
% ylim([0 15]); %  text(.15,2,'NWP H Wavelet Amplitudes', 'FontSize', 18,'Color',[1 1 1]);
% xlabel('Date'); ylabel('Period (min)'); 

subplot(312);
imagesc(timeKI,a,Hxy1);  set(gca, 'FontSize', 16); 
colormap(jet);
line([NWPeta NWPeta],[0 400],'LineStyle','--','Color',[0 0 0],'LineWidth',0.25)
xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
ylim([0 15]);  % text(.15,2,'Cross-Weighing Matrix', 'FontSize', 18,'Color',[1 1 1]);
h=colorbar; caxis([0 1.5]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Date'); ylabel('Period (min)'); 

subplot(313);
% h1=figure(5); set(h1,'Position',[100 100 1100 200],'PaperPositionMode','auto');
colormap(jet);
imagesc(timeKI,a,wKZ1);  set(gca, 'FontSize', 16); 
line([NWPeta NWPeta],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
ylim([0 30]);  text(.15,5,'NWP Z Weighted-Wavelet Amplitudes', 'FontSize', 18,'Color',[1 1 1]);
h=colorbar; caxis([0 1.2]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Date'); ylabel('Period (min)'); 
%% short time window
close all
colormap(jet);
imagesc(timeKI,a,wKZ1);  set(gca, 'FontSize', 18); 
start=datenum('13-Jan-2007 05:00:00'); 
mid0=datenum('13-Jan-2007 05:15:00'); 
mid1=datenum('13-Jan-2007 05:30:00'); 
mid2=datenum('13-Jan-2007 05:45:00'); 
endt=datenum('13-Jan-2007 06:00:00'); 

line([NWPeta NWPeta],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
xlim([start endt]); 
set(gca,'XTickLabel',{'5:00','5:15','5:30','5:45','6:00'},...
    'XTick',[start mid0 mid1 mid2 endt])
ylim([0 30]);  % text(.15,2,'NWP Z Weighted-Wavelet Amplitudes', 'FontSize', 18,'Color',[1 1 1]);
h=colorbar; caxis([0 1.2]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',18);
xlabel('Time (Jan. 13 2007)'); ylabel('Period (min)'); 
