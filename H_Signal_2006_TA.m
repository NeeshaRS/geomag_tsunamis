% Neesha Schnepf
% The magnetic field F value during the tsunami time period
% 2006 tsunami: 5/3/06 15:26:40.2
%% Section 1: Setting the initial times
clc
clear all

% Initial time
IT=datenum('2006-05-03 15:00:00');
% Time of earthquake
EQT=datenum('2006-05-03 15:26:40.2');


eta13=34320; %s, water elevation arrival time
eta14= 34860; %s
eta15= 33930; % s

dayminutes=24*60*60;
daymin=24*60;

% Expected time tsunami arrives at each station
% T13
T13eta=EQT+eta13/dayminutes;
T13etas=(T13eta-IT)*daymin;
% T14
T14eta=EQT+eta14/dayminutes;
T14etas=(T14eta-IT)*daymin;
% T15
T15eta=EQT+eta15/dayminutes;
T15etas=(T15eta-IT)*daymin;


disp('Section 1: done')
%% Section 2: Load the data
addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011

% Station T13
load X13.mat % raw data
load t13.mat % the time
X13=X13(~isnan(X13));
load Y13.mat % raw data
load t13.mat % the time
Y13=Y13(~isnan(Y13));

H13=(X13.^2+Y13.^2).^(0.5);

% Station T14
load X14.mat % raw data
load t14.mat % the time
X14=X14(~isnan(X14));
load Y14.mat % raw data
load t14.mat % the time
Y14=Y14(~isnan(Y14));

H14=(X14.^2+Y14.^2).^(0.5);

% Station T15
load X15.mat % raw data
load t15.mat % the time
X15=X15(~isnan(X15));
load Y15.mat % raw data
load t15.mat % the time
Y15=Y15(~isnan(Y15));

H15=(X15.^2+Y15.^2).^(0.5);

disp('Section 2: done')
%% Section 3: Setting the start times for the tsunami relevant data

% Have the time match that of the land station
addpath /Users/neeshaschnepf/RESEARCH/Ocean_mag/Research/Tsunamis/2006_Tonga/KAK_CWA/KAK_data
load timeTA.mat

sp13=int64((timeTA(1)-t13(1))*daymin)+1;
ep13=int64((timeTA(end)-t13(1))*daymin)+1;

sp14=int64((timeTA(1)-t14(1))*daymin)+1;
ep14=int64((timeTA(end)-t14(1))*daymin)+1;

sp15=int64((timeTA(1)-t15(1))*daymin)+1;
ep15=int64((timeTA(end)-t15(1))*daymin)+1;

disp('Section 3: done')
%% Section 4: Saving the relevant time frame for CWA
H13=H13(sp13:ep13);
save H13.mat H13

H14=H14(sp14:ep14);
save H14.mat H14

H15=H15(sp15:ep15);
save H15.mat H15

disp('Section 4: done')
%% Section 4: Saving the relevant time frame
F13=H13(sp13:ep13);
clear X13
t3=t13(sp13:ep13);
clear t13

F14=H14(sp14:ep14);
clear X14
t4=t14(sp14:ep14);
clear t14

F15=H15(sp15:ep15);
clear X15
t5=t15(sp15:ep15);
clear t15

m13=[0:1:length(t3)-1]';
m14=[0:1:length(t4)-1]';
m15=[0:1:length(t5)-1]';
disp('Section 4: done')
%% Section 5A: Fit a model to the data-- T13
clc

f13 = fit(m13,F13,'gauss8')

figure(1)
hold on
plot(f13,m13,F13)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series (red)')

disp('Section 5A: done')
%% Section 6A: Save the model--T13
a1 =   3.387e+04 ;% (3.387e+04, 3.387e+04)
b1 =       726.4 ;% (724.1, 728.8)
c1 =        4921 ;% (4723, 5120)
a2 =       610.3 ;% (-1400, 2621)
b2 =      -42.99 ;% (-90.61, 4.625)
c2 =       76.58 ;% (-881.7, 1035)
a3 =       132.9 ;% (-6404, 6670)
b3 =       45.05 ;% (-339.4, 429.5)
c3 =       53.23 ;% (-591.2, 697.7)
a4 =     -0.6045 ;% (-9.107, 7.898)
b4 =       78.55 ;% (62.45, 94.65)
c4 =       15.65 ;% (-53.78, 85.09)
a5 =       46.55 ;% (-1093, 1186)
b5 =       99.64 ;% (-308.5, 507.8)
c5 =       47.75 ;% (-51.61, 147.1)
a6 =       2.671 ;% (-8.18, 13.52)
b6 =       152.8 ;% (138.3, 167.3)
c6 =       22.92 ;% (-1.796, 47.64)
a7 =       265.6 ;% (128.1, 403.1)
b7 =       99.15 ;% (55.9, 142.4)
c7 =       122.6 ;% (94.27, 150.9)
a8 =       228.5 ;% (178, 279.1)
b8 =       240.6 ;% (213.9, 267.2)
c8 =       197.6 ;% (180.2, 215.1)

x=m13;

F813=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
              a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
              a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
              a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
%%     
figure(2)
hold on
plot(m13,F13,'o')
plot(m13,F813+5,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6A: done') 

%% Section 5B: Fit a model to the data-- T14
clc

f14 = fit(m14,F14,'Gauss8')

figure(1)
hold on
plot(f14,m14,F14)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series (red)')

disp('Section 5B: done')
%% Section 6B: Save the model--T14
a1 =   3.528e+04 ;% (3.528e+04, 3.528e+04)
b1 =       721.1 ;% (717.8, 724.3)
c1 =        5664 ;% (5391, 5937)
a2 =       245.2 ;% (-2.696e+04, 2.745e+04)
b2 =      -77.58 ;% (-1159, 1004)
c2 =       76.86 ;% (-2356, 2509)
a3 =         426 ;% (-9982, 1.083e+04)
b3 =        10.3 ;% (-6044, 6064)
c3 =       146.3 ;% (-2471, 2764)
a4 =       9.398 ;% (-2.04e+04, 2.042e+04)
b4 =       132.4 ;% (-3599, 3864)
c4 =       51.08 ;% (-5579, 5681)
a5 =      0.1282 ;% (-1.341, 1.598)
b5 =       111.7 ;% (71.07, 152.4)
c5 =        13.2 ;% (-84.9, 111.3)
a6 =       5.028 ;% (-1.637e+04, 1.638e+04)
b6 =       126.4 ;% (-2.786e+04, 2.811e+04)
c6 =       59.23 ;% (-3.503e+04, 3.515e+04)
a7 =       32.26 ;% (-988.2, 1053)
b7 =       194.8 ;% (-102.2, 491.9)
c7 =       73.55 ;% (-83.69, 230.8)
a8 =         163 ;% (-74.29, 400.4)
b8 =       252.3 ;% (85.33, 419.3)
c8 =         176 ;% (108.1, 244)

x=m14;

F814=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
              a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
              a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
              a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
%%     
figure(2)
hold on
plot(m14,F14,'o')
plot(m14,F814,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6B: done') 
%% Section 5C: Fit a Fourier series to the data-- T15
clc

f15 = fit(m15,F15,'fourier8')

figure(1)
hold on
plot(f15,m15,F15)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series (red)')

disp('Section 5C: done')
%% Section 6C: Save the model--T15
a0 =   3.232e+04 ;% (3.232e+04, 3.232e+04)

a1 =    -0.08862 ;% (-0.5999, 0.4227)
b1 =      -7.745 ;% (-7.869, -7.621)

a2 =      -4.885 ;% (-5.293, -4.477)
b2 =      -3.795 ;% (-4.422, -3.167)

a3 =     -0.9349 ;% (-1.292, -0.578)
b3 =       2.364 ;% (2.042, 2.687)

a4 =     -0.4726 ;% (-0.5909, -0.3543)
b4 =      0.3802 ;% (0.2309, 0.5295)

a5 =     -0.4359 ;% (-0.5587, -0.3131)
b5 =     0.09356 ;% (-0.08875, 0.2759)

a6 =      0.2153 ;% (-0.06426, 0.4948)
b6 =       0.753 ;% (0.716, 0.79)

a7 =      0.1966 ;% (0.0784, 0.3148)
b7 =      0.1837 ;% (0.08504, 0.2823)

a8 =      0.2889 ;% (0.2477, 0.33)
b8 =     -0.1478 ;% (-0.2674, -0.02823)

w =    0.006713 ;% (0.00662, 0.006807)

x=m15;

F815=a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
               a2.*cos(2*x.*w) + b2.*sin(2*x.*w) + a3.*cos(3*x.*w) + b3.*sin(3*x.*w) + ...
               a4.*cos(4*x.*w) + b4.*sin(4*x.*w) + a5.*cos(5*x.*w) + b5.*sin(5*x.*w) + ...
               a6.*cos(6*x.*w) + b6.*sin(6*x.*w) + a7.*cos(7*x.*w) + b7.*sin(7*x.*w) + ...
               a8.*cos(8*x.*w) + b8.*sin(8*x.*w);
%%     
figure(2)

subplot(3,1,1)
hold on
plot(m13,F13,'o')
plot(m13,F813+5,'r','LineWidth',1)
line([T13etas T13etas],[3.382*10^4 3.388*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m13) max(m13) 3.382*10^4 3.388*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')
legend('Data','Gaussian Fit')
title('T13')

subplot(3,1,2)
hold on
plot(m14,F14,'o')
plot(m14,F814,'r','LineWidth',1)
line([T14etas T14etas],[3.524*10^4 3.53*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m14) max(m14) 3.524*10^4 3.53*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')
legend('Data','Gaussian Fit')
title('T14')

subplot(3,1,3)
hold on
plot(m15,F15,'o')
plot(m15,F815-1,'r','LineWidth',1)
line([T15etas T15etas],[3.231*10^4 3.234*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m15) max(m15) 3.231*10^4 3.234*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')
legend('Data','Fourier Series Fit')
title('T15')

disp('Section 6C: done')  
%% Section 7: Subtract the Fourier series model from the data to detrend it
Fd13=F13-F813-5;
Fd14=F14-F814;
Fd15=F15-F815+1;

subplot(3,1,1)
hold on
plot(m13,Fd13,'k','LineWidth',1)
line([T13etas T13etas],[-2 2],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m13) max(m13) -2 2])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')

title('T13')

subplot(3,1,2)
hold on
plot(m14,Fd14,'k','LineWidth',1)
line([T14etas T14etas],[-5 5],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m14) max(m14) -5 5])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')

title('T14')

subplot(3,1,3)
hold on
plot(m15,Fd15,'k','LineWidth',1)
line([T15etas T15etas],[-1 0],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m15) max(m15) -1 0])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')

title('T15')

disp('Section 7: done')