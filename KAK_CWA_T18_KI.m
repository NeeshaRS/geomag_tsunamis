% code written by N. R. Schnepf & Manoj Nair
%% Section 1: load datasets
clear all; clc

% addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2007_Kuril_Islands/T18/H/
load H18KI.mat;
addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011/
load Z18.mat;
load t18.mat;

% addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2007_Kuril_Islands/T18/KAK_CWA/
load timeKI.mat
load KAKH_KI.mat;

% resample kak to 1 minute
% kak = resample(KAK_H_06_TA-nanmean(KAK_H_06_TA), 1, 60);
kak=KAKH_KI;

load T18ETA.mat
t18a=T18ETA-timeKI(1)

EQo=datenum('2007-01-13 04:23:21.1');
EQT=EQo-timeKI(1);

disp('Section 1: done')
%% Section 2: Setting the start times for the tsunami relevant data
daymin=24*60;

sp18=int64((timeKI(1)-t18(1))*daymin)+1;
ep18=int64((timeKI(end)-t18(1))*daymin)+1;
Z18=Z18(sp18:ep18);

disp('Section 2: done')
%%
% SPLINE FILTER
% % remove variations with periods > 1 hour by spline fit
% n=length(timeKI);
% fday = [1:n]./daymin; % time axis in decimal days
% b1 = min(fday):(.25/24):max(fday); % knots separated by .25 hour
% 
% kak_sp=spline(b1,kak'/spline(b1,eye(length(b1)),fday(:))); % spline fit
% kak_h_f = kak' - ppval(kak_sp, fday); %filtered data
% 
% % H data
% h18_sp=spline(b1,H18KI'/spline(b1,eye(length(b1)),fday(:))); % spline fit
% h18_h_f = H18KI' - ppval(h18_sp, fday); %filtered data
% 
% % Z data
% z18_sp=spline(b1,Z18'/spline(b1,eye(length(b1)),fday(:))); % spline fit
% z18_h_f = Z18' - ppval(z18_sp, fday); %filtered data

% save h18_h_f_KI.mat h18_h_f;
% save z18_h_f_KI.mat z18_h_f;

% HPF FILTER
maxperiod=1*60*30; % 0.5 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');
z18_h_f = filtfilt(B,A,Z18);
h18_h_f = filtfilt(B,A,H18KI);
kak_h_f = filtfilt(B,A,kak);

disp('data filtered')
%% cross wavelet spectra

% Sc = scal2frq(1./(fliplr(perdiod_in_minutes)*60),waven,60); %to get desired scales for a set of frequencies
Sc = 0.1:0.1:200; % You will need to play around with the frequencies a bit
waven = 'cgau4';
perd = 1./scal2frq(Sc,waven,60); % 60 = sampling interval in seconds

kakhw = cwt(kak_h_f,Sc,waven);%Complex wavelet transform
h18hw = cwt(h18_h_f,Sc,waven);%Complex wavelet transform
z18hw = cwt(z18_h_f,Sc,waven);%Complex wavelet transform
disp('done')
%%
a=perd/60;
kakhw1=abs(kakhw);
h18hw1=abs(h18hw);
z18hw1=abs(z18hw);

%% Finally produce a weight matrix. You will need to determine which remote
% observatory best removes the noise in Z

Hxy = kakhw .* conj(h18hw);
cc = abs(max(max(abs(Hxy))) - abs(Hxy) );
weight = (cc./max(max(cc)));
% Now apply the weight to the wavelet spectrum of Z
wKZ = (abs(z18hw).*weight);

Hxy1=abs(Hxy);
wKZ1=abs(wKZ);
disp('finished')
 %%
% save CWA_T18_KI_07.mat z18* wKZ* H* h18*
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
colormap(map);
subplot(511); 
imagesc(timeKI,a,z18hw1); set(gca, 'FontSize', 14); 
h=colorbar; caxis([0 1.5]); set(h,'fontsize',12); set(get(h,'ylabel'),'string','nT','fontsize',14);
ylim([0 15]); xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
line([T18ETA T18ETA],[0 200],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
text(timeKI(5),2,'T18 Z Wavelet Amplitudes', 'FontSize', 14,'Color',[1 1 1]);;
xlabel('Date'); ylabel('Period (min)'); 

subplot(512); 
imagesc(timeKI,a,kakhw1);  set(gca, 'FontSize', 14); 
h=colorbar; caxis([0 1.5]); set(h,'fontsize',12); set(get(h,'ylabel'),'string','nT','fontsize',14);
xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
line([T18ETA T18ETA],[0 200],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
ylim([0 15]);  text(timeKI(5),2,'KAK H Wavelet Amplitudes', 'FontSize', 14,'Color',[1 1 1]);;
xlabel('Date'); ylabel('Period (min)'); 

subplot(513);
imagesc(timeKI,a,h18hw1);  set(gca, 'FontSize', 14);
line([T18ETA T18ETA],[0 200],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
h=colorbar; caxis([0 1.5]); set(h,'fontsize',12); set(get(h,'ylabel'),'string','nT','fontsize',14);
xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
ylim([0 15]); text(timeKI(5),2,'T18 H Wavelet Amplitudes', 'FontSize', 14,'Color',[1 1 1]);;
xlabel('Date'); ylabel('Period (min)'); 

subplot(514);
imagesc(timeKI,a,Hxy1);  set(gca, 'FontSize', 14); 
line([T18ETA T18ETA],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
ylim([0 15]);  text(timeKI(5),2,'Cross-Weighing Matrix', 'FontSize', 14,'Color',[1 1 1]);;
h=colorbar; caxis([0 1.5]); set(h,'fontsize',12); set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Date'); ylabel('Period (min)'); 

subplot(515);
%%
h1=figure(5); set(h1,'Position',[100 100 1100 200],'PaperPositionMode','auto');
colormap(jet);
imagesc(timeKI,a,wKZ1);  set(gca, 'FontSize', 16); 
line([T18ETA T18ETA],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',0.25)
xlim([timeKI(1) timeKI(end)]);
set(gca,'XTickLabel',{'1/10/2007','1/14/2007','1/18/2007'},...
    'XTick',[733052 733056 733060 ])
ylim([0 30]);  text(timeKI(5),2,'T18 Z Weighted-Wavelet Amplitudes', 'FontSize', 16,'Color',[1 1 1]);;
h=colorbar; caxis([0 1.5]);
set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);
xlabel('Date'); ylabel('Period (min)'); 
%% short time window
close all
colormap(jet);
imagesc(timeKI,a,wKZ1);  set(gca, 'FontSize', 18); 
start=datenum('13-Jan-2007 06:00:00'); 
mid0=datenum('13-Jan-2007 06:15:00'); 
mid1=datenum('13-Jan-2007 06:30:00'); 
mid2=datenum('13-Jan-2007 06:45:00'); 
endt=datenum('13-Jan-2007 07:00:00'); 
set(gca,'XTickLabel',{'6:00','6:15','6:30','6:45','7:00'},...
    'XTick',[start mid0 mid1 mid2 endt])
line([T18ETA T18ETA],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
xlim([start endt]);
ylim([0 30]);  %text(timeKI(5),2,'T18 Z Weighted-Wavelet Amplitudes', 'FontSize', 14,'Color',[1 1 1]);;
h=colorbar; caxis([0 1.2]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',18);
xlabel('Time (Jan. 13 2007)'); ylabel('Period (min)'); 
