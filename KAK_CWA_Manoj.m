% Written by Neesha R. Schnepf and Manoj Nair
%% Section 1: load datasets
clear all; clc

% addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/KAK_CWA/Data_files_CWA_06_TA
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

% addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/KAK_CWA/KAK_data
load timeTA.mat
load KAKH.mat;

% resample kak to 1 minute
% kak = resample(KAK_H_06_TA-nanmean(KAK_H_06_TA), 1, 60);
kak=KAKH;

% for plotting
% addpath /Users/NeeshaSchnepf/RESEARCH/Ocean_mag/Tsunamis/2006_Tonga/Cross_Wavelet_Analysis/Cross_Wavelet_Amp
% Time of earthquake
EQo=datenum('2006-05-03 15:26:40.2');
EQT=EQo-timeTA(1);

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

disp('Section 2: done')
%%
daymin=24*60;
% remove variations with periods > 1 hour by spline fit
n=length(timeTA);
fday = [1:n]./daymin; % time axis in decimal days
b1 = min(fday):(.25/24):max(fday); % knots separated by .25 hours

kak_sp=spline(b1,kak'/spline(b1,eye(length(b1)),fday(:))); % spline fit
kak_h_f = kak' - ppval(kak_sp, fday); %filtered data

%% H data
h13_sp=spline(b1,H13'/spline(b1,eye(length(b1)),fday(:))); % spline fit
h13_h_f = H13' - ppval(h13_sp, fday); %filtered data
save h13_h_f.mat h13_h_f;

h14_sp=spline(b1,H14'/spline(b1,eye(length(b1)),fday(:))); % spline fit
h14_h_f = H14' - ppval(h14_sp, fday); %filtered data
save h14_h_f.mat h14_h_f;

h15_sp=spline(b1,H15'/spline(b1,eye(length(b1)),fday(:))); % spline fit
h15_h_f = H15' - ppval(h15_sp, fday); %filtered data
save h15_h_f.mat h15_h_f;

% Z data
z13_sp=spline(b1,Z13'/spline(b1,eye(length(b1)),fday(:))); % spline fit
z13_h_f = Z13' - ppval(z13_sp, fday); %filtered data
save z13_h_f.mat z13_h_f;

z14_sp=spline(b1,Z14'/spline(b1,eye(length(b1)),fday(:))); % spline fit
z14_h_f = Z14' - ppval(z14_sp, fday); %filtered data
save z14_h_f.mat z14_h_f;

z15_sp=spline(b1,Z15'/spline(b1,eye(length(b1)),fday(:))); % spline fit
z15_h_f = Z15' - ppval(z15_sp, fday); %filtered data
save z15_h_f.mat z15_h_f;

%% F data
f13_sp=spline(b1,F13'/spline(b1,eye(length(b1)),fday(:))); % spline fit
f13_h_f = F13' - ppval(f13_sp, fday); %filtered data
save f13_h_f.mat f13_h_f;

f14_sp=spline(b1,F14'/spline(b1,eye(length(b1)),fday(:))); % spline fit
f14_h_f = F14' - ppval(f14_sp, fday); %filtered data
save f14_h_f.mat f14_h_f;

f15_sp=spline(b1,F15'/spline(b1,eye(length(b1)),fday(:))); % spline fit
f15_h_f = F15' - ppval(f15_sp, fday); %filtered data
save f15_h_f.mat f15_h_f;

disp('Section 3: done- data filtered')
%% ~1 day time window- H component
figure (1)
hold on
set(gca,'FontSize',16)
plot(fday, h13_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t13a t13a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t13a+0.0625) -.4 .5])

%%
figure (2)
set(gca,'FontSize',16)
plot(fday, h14_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t14a t14a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t14a+0.0625) -.4 .5])
%%
figure (3)
set(gca,'FontSize',16)
plot(fday, h15_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t14a t14a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t15a+0.0625) -.4 .5])

%% ~1 day time window- Z component
figure (4)
hold on
set(gca,'FontSize',16)
plot(fday, z13_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t13a t13a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t13a+0.0625) -.1 .1])

%%
figure (5)
set(gca,'FontSize',16)
plot(fday, z14_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t14a t14a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t14a+0.0625) -.1 .1])

%%
figure (6)
set(gca,'FontSize',16)
plot(fday, z15_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t15a t15a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t15a+0.0625) -.1 .1])

%% ~1 day time window- F component
figure (4)
hold on
set(gca,'FontSize',16)
plot(fday, f13_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t13a t13a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t13a+0.0625) -.3 .3])

%%
figure (5)
set(gca,'FontSize',16)
plot(fday, f14_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t14a t14a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t14a+0.0625) -.3 .3])

%%
figure (6)
set(gca,'FontSize',16)
plot(fday, f15_h_f,'k')
ylabel('Amplitude (nT)')
xlabel('Date')
set(gca,'XTickLabel',{'5/3 16:48','5/3 19:12','5/3 21:36','5/4 00:00 ','5/4 02:24'},...
  'XTick',[7.7 7.8 7.9 8.0 8.1])
line([EQT EQT],[-8 12],'LineStyle','--','Color',[0 0 1],'LineWidth',2)
line([t15a t15a],[-8 12],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
axis([(EQT-0.0208) (t15a+0.0625) -.3 .3])
%% cross wavelet spectra

Sc = 0.1:0.1:200; % You will need to play around with the frequencies a bit
waven = 'cgau4';
perd = 1./scal2frq(Sc,waven,60); % 60 = sampling interval in seconds

kakhw = cwt(kak_h_f,Sc,waven);%Complex wavelet transform
% h13hw = cwt(h13_h_f,Sc,waven);%Complex wavelet transform
% h14hw = cwt(h14_h_f,Sc,waven);%Complex wavelet transfor
% h15hw = cwt(h15_h_f,Sc,waven);%Complex wavelet transfor
% z13hw = cwt(z13_h_f,Sc,waven);%Complex wavelet transform
% z14hw = cwt(z14_h_f,Sc,waven);%Complex wavelet transfor
% z15hw = cwt(z15_h_f,Sc,waven);%Complex wavelet transfor
f13hw = cwt(f13_h_f,Sc,waven);%Complex wavelet transform
f14hw = cwt(f14_h_f,Sc,waven);%Complex wavelet transfor
f15hw = cwt(f15_h_f,Sc,waven);%Complex wavelet transfor

disp('ow ow owww!')
%%
a=perd/60;
kakhw1=abs(kakhw);
% h13hw1=abs(h13hw);
% h14hw1=abs(h14hw);
% h15hw1=abs(h15hw);
% z13hw1=abs(z13hw);
% z14hw1=abs(z14hw);
% z15hw1=abs(z15hw);
f13hw1=abs(f13hw);
f14hw1=abs(f14hw);
f15hw1=abs(f15hw);
%%
figure(3)
subplot(411);
imagesc(fday,a,kakhw1);
axis([0 15 0 100])
colorbar
subplot(412);
imagesc(fday,a,f13hw1);
line([t13a t13a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar
subplot(413);
imagesc(fday,a,f14hw1);
line([t14a t14a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar
subplot(414);
imagesc(fday,a,f15hw1);
line([t15a t15a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar
%%
figure(4)
subplot(411)
imagesc(fday,a,z13hw1);
line([t13a t13a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar
subplot(412);
imagesc(fday,a,z14hw1);
line([t14a t14a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar
subplot(413);
imagesc(fday,a,z15hw1);
line([t15a t15a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar
%%
save h13hw05.mat h13hw; save h14hw05.mat h14hw; 
save h15hw05.mat h15hw; save kakhw05.mat kakhw; 
save z13hw05.mat z13hw; save z14hw05.mat z14hw; 
save z15hw05.mat z15hw; 
%% Finally produce a weight matrix. You will need to determine which remote
% observatory best removes the noise in Z

Hxy13 = kakhw .* conj(h13hw);
cc13 = abs(max(max(abs(Hxy13))) - abs(Hxy13) );
weight13 = (cc13./max(max(cc13)));
% Now apply the weight to the wavelet spectrum of Z
wKZ13 = (abs(z13hw).*weight13);

Hxy14 = kakhw .* conj(h14hw);
cc14 = abs(max(max(abs(Hxy14))) - abs(Hxy14) );
weight14 = (cc14./max(max(cc14)));
% Now apply the weight to the wavelet spectrum of Z
wKZ14 = (abs(z14hw).*weight14);

Hxy15 = kakhw .* conj(h15hw);
cc15 = abs(max(max(abs(Hxy15))) - abs(Hxy15) );
weight15 = (cc15./max(max(cc15)));
% Now apply the weight to the wavelet spectrum of Z
wKZ15 = (abs(z15hw).*weight15);

save wKZ13.mat wKZ13; save wKZ14.mat wKZ14; 
save wKZ15.mat wKZ15; 

disp('isis has arrived')
%%
Hxy13a=abs(Hxy13);
Hxy14a=abs(Hxy14);
Hxy15a=abs(Hxy15);
wKZ13a=abs(wKZ13);
wKZ14a=abs(wKZ14);
wKZ15a=abs(wKZ15);

%% Finally produce a weight matrix. You will need to determine which remote
% observatory best removes the noise in F

Hxy13 = kakhw .* conj(f13hw);
cc13 = abs(max(max(abs(Hxy13))) - abs(Hxy13) );
weight13 = (cc13./max(max(cc13)));
% Now apply the weight to the wavelet spectrum of Z
wKF13 = (abs(f13hw).*weight13);

Hxy14 = kakhw .* conj(f14hw);
cc14 = abs(max(max(abs(Hxy14))) - abs(Hxy14) );
weight14 = (cc14./max(max(cc14)));
% Now apply the weight to the wavelet spectrum of Z
wKF14 = (abs(f14hw).*weight14);

Hxy15 = kakhw .* conj(f15hw);
cc15 = abs(max(max(abs(Hxy15))) - abs(Hxy15) );
weight15 = (cc15./max(max(cc15)));
% Now apply the weight to the wavelet spectrum of Z
wKF15 = (abs(f15hw).*weight15);

save wKF13.mat wKF13; save wKF14.mat wKF14; 
save wKF15.mat wKF15; 
%%
Hxy13a=abs(Hxy13);
Hxy14a=abs(Hxy14);
Hxy15a=abs(Hxy15);
wKZ13a=abs(wKF13);
wKZ14a=abs(wKF14);
wKZ15a=abs(wKF15);

disp('isis has arrived')
%%
figure(4)
subplot(411)
imagesc(fday,a,Hxy13a);
line([t13a t13a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
colorbar

subplot(412);
imagesc(fday,a,Hxy14a);
line([t14a t14a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
colorbar

subplot(413);
imagesc(fday,a,Hxy15a);
line([t15a t15a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
colorbar

%% plot the weighted cross-wavelet amplitudes
figure(5)
subplot(411)
imagesc(fday,a,wKZ13a);
line([t13a t13a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar

subplot(412);
imagesc(fday,a,wKZ14a);
line([t14a t14a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar

subplot(413);
imagesc(fday,a,wKZ15a);
line([t15a t15a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
axis([0 15 0 100])
colorbar

%% short time windows

figure(6)
% T13
% imagesc(fday,perd/60,abs(wKZ13));
% line([EQT EQT],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',3)
% line([t13a t13a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',3)

% T14
% imagesc(fday,perd/60,abs(wKZ14));
% line([EQT EQT],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',3)
% line([t14a t14a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',3)

% % T15
imagesc(fday,perd/60,abs(wKZ15));
line([EQT EQT],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',3)
line([t15a t15a],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',3)

set(gca,'FontSize',16)
axis([7.5 8.5 0 400]);
colorbar
caxis([0,8]);
set(gca,'XTickLabel',{'','5/3 18:00','5/4 00:00','5/4 06:00',''},...
    'XTick',[7.5 7.75 8 8.25 8.5])

