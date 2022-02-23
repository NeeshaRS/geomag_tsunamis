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

dayseconds=24*60*60;
dayminutes=24*60;

% Expected time tsunami arrives at each station
% T13
T13eta=EQT+eta13/dayseconds;
T13etas=(T13eta-IT)*dayminutes;
% T14
T14eta=EQT+eta14/dayseconds;
T14etas=(T14eta-IT)*dayminutes;
% T15
T15eta=EQT+eta15/dayseconds;
T15etas=(T15eta-IT)*dayminutes;
save TAeta T13eta T14eta T15eta


disp('Section 1: done')
%% Section 2: Load the data
addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011

% Station T13
load Z13.mat % raw data
load t13.mat % the time
Z13=Z13(~isnan(Z13));

% Station T14
load Z14.mat % raw data
load t14.mat % the time
Z14=Z14(~isnan(Z14));

% Station T15
load Z15.mat % raw data
load t15.mat % the time
Z15=Z15(~isnan(Z15));

disp('Section 2: done')
%% Section 3: Setting the start times for the tsunami relevant data

% sp13=int64((IT-t13(1))*dayminutes)+1;
sp13=int64((T13eta-t13(1))*dayminutes)-180;
ep13=int64((T13eta-t13(1))*dayminutes)+180;

% sp14=int64((IT-t14(1))*dayminutes)+1;
sp14=int64((T14eta-t14(1))*dayminutes)-180;
ep14=int64((T14eta-t14(1))*dayminutes)+180;

% sp15=int64((IT-t15(1))*dayminutes)+1;
sp15=int64((T15eta-t15(1))*dayminutes)-180;
ep15=int64((T15eta-t15(1))*dayminutes)+180;

disp('Section 3: done')
%% Section 4: Saving the relevant time frame
Z13=Z13(sp13:ep13);
save TAZ13.mat Z13
t13=t13(sp13:ep13);
save TAt13.mat t13

Z14=Z14(sp14:ep14);
save TAZ14.mat Z14
t14=t14(sp14:ep14);
save TAt14.mat t14

Z15=Z15(sp15:ep15);
save TAZ15.mat Z15
t15=t15(sp15:ep15);
save TAt15.mat t15

m13=[0:1:length(tr3)-1]';
m14=[0:1:length(tr4)-1]';
m15=[0:1:length(tr5)-1]';
disp('Section 4: done')
%% Section 5A: Fit a model to the data-- T13
clc

F = fit(m13,Fr13,'Fourier8')


disp('Section 5A: done')
%% Section 6A: Save the model--T13

a0 =   2.243e+04;%  (2.243e+04, 2.243e+04)
a1 =       11.48;%  (10.88, 12.07)
b1 =       11.73;%  (11.16, 12.31)
a2 =        1.62;%  (1.491, 1.748)
b2 =      0.6928;%  (0.4073, 0.9782)
a3 =       1.191;%  (1.035, 1.347)
b3 =      -0.449;%  (-0.6756, -0.2224)
a4 =      0.2776;%  (0.1367, 0.4184)
b4 =     -0.3938;%  (-0.4947, -0.2929)
a5 =    -0.06488;%  (-0.3089, 0.1791)
b5 =     -0.8907;%  (-0.9227, -0.8588)
a6 =     -0.1303;%  (-0.2023, -0.05829)
b6 =     -0.2145;%  (-0.3055, -0.1236)
a7 =      -0.103;%  (-0.1276, -0.0785)
b7 =     0.03714;%  (-0.02371, 0.098)
a8 =    -0.08297;%  (-0.1056, -0.06032)
b8 =     0.04634;%  (0.01135, 0.08132)
w =       0.014 ;% (0.01375, 0.01425)
x=m13;
% Fourier
F813=a0 + a1.*cos(x*w) + b1.*sin(x*w) + ...
               a2.*cos(2*x*w) + b2.*sin(2*x*w) + a3.*cos(3*x*w) + b3.*sin(3*x*w) + ...
               a4.*cos(4*x*w) + b4.*sin(4*x*w) + a5.*cos(5*x*w) + b5.*sin(5*x*w) + ...
               a6.*cos(6*x*w) + b6.*sin(6*x*w) + a7.*cos(7*x*w) + b7.*sin(7*x*w) + ...
               a8.*cos(8*x*w) + b8.*sin(8*x*w);

% Gaussian
% F813=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
%               a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
%               a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
%               a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
%%     
figure(2)
hold on
plot(m13,Fr13,'o')
plot(m13,F813+4,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(x) max(x) 3.9672*10^4 3.9688*10^4])
axis([min(x) max(x) 2.2415*10^4 2.2455*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6A: done') 

%% Section 5B: Fit a model to the data-- T14
clc

F = fit(m14,Fr14,'Fourier8')


disp('Section 5B: done')
%% Section 6B: Save the model--T14

a0 =   1.865e+04;%  (1.865e+04, 1.865e+04)
a1 =         7.4;%  (7.141, 7.659)
b1 =       7.763;%  (7.554, 7.972)
a2 =       1.079;%  (1.018, 1.14)
b2 =       1.354;%  (1.181, 1.526)
a3 =       1.807;%  (1.739, 1.875)
b3 =     -0.2477;%  (-0.4398, -0.05566)
a4 =      0.8945;%  (0.7919, 0.997)
b4 =      -0.145;%  (-0.2987, 0.008648)
a5 =     -0.2141;%  (-0.3723, -0.05586)
b5 =     -0.6846;%  (-0.7204, -0.6487)
a6 =    -0.02921;%  (-0.07689, 0.01846)
b6 =     -0.1472;%  (-0.1938, -0.1006)
a7 =     -0.1863;%  (-0.2653, -0.1074)
b7 =     -0.1825;%  (-0.2418, -0.1231)
a8 =    -0.08157;%  (-0.119, -0.04414)
b8 =      0.1074;%  (0.06632, 0.1485)
w =     0.01375;%  (0.01355, 0.01396)

x=m14;
% Fourier
F814=a0 + a1.*cos(x*w) + b1.*sin(x*w) + ...
               a2.*cos(2*x*w) + b2.*sin(2*x*w) + a3.*cos(3*x*w) + b3.*sin(3*x*w) + ...
               a4.*cos(4*x*w) + b4.*sin(4*x*w) + a5.*cos(5*x*w) + b5.*sin(5*x*w) + ...
               a6.*cos(6*x*w) + b6.*sin(6*x*w) + a7.*cos(7*x*w) + b7.*sin(7*x*w) + ...
               a8.*cos(8*x*w) + b8.*sin(8*x*w);

% Gaussian
% F814=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
%               a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
%               a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
%               a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
%%     
figure(2)
hold on
plot(m14,Fr14,'o')
plot(m14,F814-.5,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6B: done') 
%% Section 5C: Fit a Fourier series to the data-- T15
clc

F = fit(m15,Fr15,'gauss8')

% figure(1)
% hold on
% plot(Fr15,m15,Fr15)
% set(gca,'FontSize',16,'LineWidth',1)
% % axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
% xlabel('Date')
% ylabel('Field Magnitude (nT)')
% title('Calculated Field Magnitude compared with the Fourier Series (red)')

disp('Section 5C: done')
%% Section 6C: Save the model--T15
a1 =   2.706e+04;%  (2.706e+04, 2.706e+04)
b1 =       35.99;%  (35.51, 36.48)
c1 =        4805;%  (4749, 4861)
a2 =       131.6;%  (-5252, 5515)
b2 =       416.9;%  (-2202, 3036)
c2 =       64.92;%  (-6256, 6386)
a3 =        24.2;%  (-6916, 6964)
b3 =       340.1;%  (-2893, 3574)
c3 =       47.79;%  (-1380, 1475)
a4 =      0.1763;%  (-7.586, 7.938)
b4 =         325;%  (263.7, 386.3)
c4 =        8.51;%  (-79.92, 96.94)
a5 =      0.3456;%  (-6.598, 7.289)
b5 =       311.4;%  (229.9, 393)
c5 =       10.78;%  (-71.06, 92.61)
a6 =        0.46;%  (-20.86, 21.78)
b6 =       295.4;%  (130.5, 460.2)
c6 =       14.42;%  (-220.1, 248.9)
a7 =      0.3076;%  (-1.461, 2.076)
b7 =       267.4;%  (254.9, 279.8)
c7 =       9.749;%  (-7.201, 26.7)
a8 =       37.01;%  (-79.2, 153.2)
b8 =       300.6;%  (167, 434.2)
c8 =       76.45;%  (36.51, 116.4)

x=m15;

F815=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
              a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
              a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
              a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
%%        
figure(3)
hold on
plot(m15,Fr15,'o')
plot(m15,F815-3,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6C: done')  
%% Section 7: Subtract the Fourier series model from the data to detrend it
Fd13=Fr13-F813-4;
Fd14=Fr14-F814+.5;
Fd15=Fr15-F815+3;
%%
figure(4)
plot(m13,Fd13,'k','LineWidth',2)
line([180 180],[-2 2],'Color',[1 0 0],'LineWidth',2)
set(gca,'FontSize',30,'LineWidth',2)
axis([min(m13) max(m13) -.2 .1])
xlabel('Minutes from 2006-05-03 21:58:00')
ylabel('Field Magnitude (nT)')
%%
figure(5)
plot(m14,Fd14,'k','LineWidth',1)
line([180 180],[-2 2],'Color',[1 0 0],'LineWidth',2)
set(gca,'FontSize',30,'LineWidth',2)
axis([min(m14) max(m14) -.2 0])
xlabel('Minutes from 2006-05-03 22:07:00')
ylabel('Field Magnitude (nT)')
%%
figure(6)
hold on
plot(m15,Fd15,'k','LineWidth',2)
line([180 180],[-4 4],'Color',[1 0 0],'LineWidth',2)
set(gca,'FontSize',30,'LineWidth',2)
axis([min(m15) max(m15) -.5 .2])
xlabel('Minutes from 2006-05-03 21:51:00')
ylabel('Field Magnitude (nT)')

disp('Section 7: done')