% Neesha Schnepf
% The magnetic field F value during the tsunami time period
% 2006 tsunami: 2006-05-03 15:26:40.2
%% Section 1: Setting the initial times
clc
clear all

% Initial time
IT=datenum('2006-04-19 00:00:00');
ET=datenum('2006-05-17 00:00:00');

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
addpath /Users/NeeshaSchnepf/RESEARCH/Summer/Hollings/Research/Matlab_stuff

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

sp13=int64((IT-t13(1))*daymin)+1;
ep13=int64((ET-t13(1))*daymin)+1;

sp14=int64((IT-t14(1))*daymin)+1;
ep14=int64((ET-t14(1))*daymin)+1;

sp15=int64((IT-t15(1))*daymin)+1;
ep15=int64((ET-t15(1))*daymin)+1;

disp('Section 3: done')
%% Section 4: Saving the relevant time frame
F13=Z13(sp13:ep13);
clear Z13
t3=t13(sp13:ep13);
clear t13

F14=Z14(sp14:ep14);
clear Z14
t4=t14(sp14:ep14);
clear t14

F15=Z15(sp15:ep15);
clear Z15
t5=t15(sp15:ep15);
clear t15

m13=[0:1:length(t3)-1]';
m14=[0:1:length(t4)-1]';
m15=[0:1:length(t5)-1]';
disp('Section 4: done')

%%
figure(1)

subplot(3,1,1)
plot(t3,F13, 'LineWidth',1)
line([T13eta T13eta],[2.24*10^4 2.246*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
datetick('x',6)
axis([min(t3) max(t3) 2.24*10^4 2.246*10^4])
ylabel('Field Magnitude (nT)')
xlabel('Date')
title('T13: The 2006 Tonga Tsunami- Z Component')

subplot(3,1,2)
plot(t4,F14, 'LineWidth',1)
line([T14eta T14eta],[1.863*10^4 1.867*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
datetick('x',6)
axis([min(t4) max(t4) 1.863*10^4 1.867*10^4])
ylabel('Field Magnitude (nT)')
xlabel('Date')
title('T14: The 2006 Tonga Tsunami- Z Component')

subplot(3,1,3)
plot(t5,F15, 'LineWidth',1)
line([T15eta T15eta],[2.702*10^4 2.708*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
datetick('x',6)
axis([min(t5) max(t5) 2.702*10^4 2.708*10^4])

xlabel('Date')
ylabel('Field Magnitude (nT)')
title('T15: The 2006 Tonga Tsunami- Z Component')


%% Section 5A: Fit a Fourier series to the data-- T13
clc

f13 = fit(m13,F13,'Fourier8')

figure(1)
hold on
plot(f13,m13,F13)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series (red)')

disp('Section 5A: done')
%% Section 6A: Save the Fourier series model--T13
a0 =   2.244e+04 ;% (2.244e+04, 2.244e+04)
a1 =      0.7307 ;% (0.6793, 0.7821)
b1 =      0.2036 ;% (0.152, 0.2552)
a2 =       -2.06 ;% (-2.129, -1.99)
b2 =      -8.595 ;% (-8.647, -8.542)
a3 =     0.09119 ;% (0.03955, 0.1428)
b3 =      0.5403 ;% (0.4888, 0.5918)
a4 =       1.606 ;% (1.532, 1.681)
b4 =      -5.008 ;% (-5.063, -4.954)
a5 =     -0.3787 ;% (-0.4302, -0.3273)
b5 =      0.1111 ;% (0.05927, 0.163)
a6 =       2.487 ;% (2.434, 2.54)
b6 =     -0.8163 ;% (-0.8813, -0.7513)
a7 =     0.02106 ;% (-0.03049, 0.07261)
b7 =      -0.129 ;% (-0.1805, -0.07756)
a8 =      0.8648 ;% (0.8133, 0.9162)
b8 =     0.01371 ;% (-0.04088, 0.0683)
w =    0.002187 ;% (0.002187, 0.002187)

x=m13;

F813=a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
               a2.*cos(2*x.*w) + b2.*sin(2*x.*w) + a3.*cos(3*x.*w) + b3.*sin(3*x.*w) + ...
               a4.*cos(4*x.*w) + b4.*sin(4*x.*w) + a5.*cos(5*x.*w) + b5.*sin(5*x.*w) + ...
               a6.*cos(6*x.*w) + b6.*sin(6*x.*w) + a7.*cos(7*x.*w) + b7.*sin(7*x.*w) + ...
               a8.*cos(8*x.*w) + b8.*sin(8*x.*w);
%%     
figure(2)
hold on
plot(m13,F13,'o')
plot(m13,F813,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6: done') 

%% Section 5B: Fit a Fourier series to the data-- T14
clc

f14 = fit(m14,F14,'Fourier8')

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
a0 =   1.866e+04 ;% (1.866e+04, 1.866e+04)
a1 =      0.8269 ;% (0.7789, 0.8749)
b1 =      0.2036 ;% (0.1554, 0.2518)
a2 =      -1.185 ;% (-1.251, -1.119)
b2 =      -7.369 ;% (-7.418, -7.321)
a3 =      0.3382 ;% (0.29, 0.3865)
b3 =      0.4462 ;% (0.398, 0.4944)
a4 =       1.956 ;% (1.889, 2.023)
b4 =      -3.859 ;% (-3.912, -3.805)
a5 =     -0.1436 ;% (-0.1916, -0.09551)
b5 =      0.1435 ;% (0.09531, 0.1916)
a6 =       2.091 ;% (2.042, 2.139)
b6 =     -0.3409 ;% (-0.4021, -0.2797)
a7 =      0.1993 ;% (0.1512, 0.2473)
b7 =    -0.03624 ;% (-0.08441, 0.01193)
a8 =       0.541 ;% (0.4929, 0.5891)
b8 =      0.1534 ;% (0.1036, 0.2032)
w =    0.002188 ;% (0.002188, 0.002188)

x=m14;

F814=a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
               a2.*cos(2*x.*w) + b2.*sin(2*x.*w) + a3.*cos(3*x.*w) + b3.*sin(3*x.*w) + ...
               a4.*cos(4*x.*w) + b4.*sin(4*x.*w) + a5.*cos(5*x.*w) + b5.*sin(5*x.*w) + ...
               a6.*cos(6*x.*w) + b6.*sin(6*x.*w) + a7.*cos(7*x.*w) + b7.*sin(7*x.*w) + ...
               a8.*cos(8*x.*w) + b8.*sin(8*x.*w);
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

disp('Section 6: done') 
%% Section 5C: Fit a Fourier series to the data-- T15
clc

f15 = fit(m15,F15,'Fourier8')

figure(1)
hold on
plot(f15,m15,F15)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series (red)')

disp('Section 5B: done')
%% Section 6C: Save the model--T15
a0 =   2.705e+04 ;% (2.705e+04, 2.705e+04)
a1 =      0.1565 ;% (0.1097, 0.2032)
b1 =      0.1595 ;% (0.1128, 0.2063)
a2 =      -4.373 ;% (-4.432, -4.314)
b2 =      -5.172 ;% (-5.228, -5.117)
a3 =     -0.3656 ;% (-0.4125, -0.3187)
b3 =      0.3808 ;% (0.3339, 0.4277)
a4 =      0.0265 ;% (-0.03757, 0.09057)
b4 =      -3.183 ;% (-3.23, -3.136)
a5 =     -0.6221 ;% (-0.6689, -0.5753)
b5 =      0.1004 ;% (0.05234, 0.1485)
a6 =      0.9206 ;% (0.8618, 0.9794)
b6 =      -1.734 ;% (-1.784, -1.684)
a7 =     -0.2818 ;% (-0.3289, -0.2348)
b7 =     -0.2129 ;% (-0.2603, -0.1655)
a8 =      0.4937 ;% (0.4439, 0.5435)
b8 =     -0.6175 ;% (-0.6659, -0.569)
w =    0.002184 ;% (0.002184, 0.002184)

x=m15;

F815=a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
               a2.*cos(2*x.*w) + b2.*sin(2*x.*w) + a3.*cos(3*x.*w) + b3.*sin(3*x.*w) + ...
               a4.*cos(4*x.*w) + b4.*sin(4*x.*w) + a5.*cos(5*x.*w) + b5.*sin(5*x.*w) + ...
               a6.*cos(6*x.*w) + b6.*sin(6*x.*w) + a7.*cos(7*x.*w) + b7.*sin(7*x.*w) + ...
               a8.*cos(8*x.*w) + b8.*sin(8*x.*w);
%%     
figure(2)
hold on
plot(m15,F15,'o')
plot(m15,F815,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6: done')           
%% Section 7: Subtract the Fourier series model from the data to detrend it
Fd13=F13-F813;
Fd14=F14-F814;
Fd15=F15-F815;
%%
figure(3)
hold on

subplot(3,1,1)
plot(m13,Fd13,'k')
line([T13etas T13etas],[-50 50],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([min(m13) max(m13) -20 20])
ylabel('Field Magnitude (nT)')
xlabel('Minutes from 2006-04-19 00:00:00')
title('T13: The 2006 Tonga Tsunami- Z Component')

subplot(3,1,2)
plot(m14,Fd14,'k')
line([T14etas T14etas],[-50 50],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([min(m14) max(m14) -20 10])
ylabel('Field Magnitude (nT)')
xlabel('Minutes from 2006-04-19 00:00:00')
title('T14: The 2006 Tonga Tsunami- Z Component')

subplot(3,1,3)
plot(m15,Fd15,'k')
line([T15etas T15etas],[-50 50],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([min(m15) max(m15) -20 20])
ylabel('Field Magnitude (nT)')
xlabel('Minutes from 2006-04-19 00:00:00')
title('T15: The 2006 Tonga Tsunami- Z Component')

disp('Section 7: done')