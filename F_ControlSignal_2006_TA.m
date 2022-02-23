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
load Fc13.mat % raw data
load t13.mat % the time
Fc13=Fc13(~isnan(Fc13));

% Station T14
load Fc14.mat % raw data
load t14.mat % the time
Fc14=Fc14(~isnan(Fc14));

% Station T15
load Fc15.mat % raw data
load t15.mat % the time
Fc15=Fc15(~isnan(Fc15));

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
F13=Fc13(sp13:ep13);
clear Fc13
t3=t13(sp13:ep13);
clear t13

F14=Fc14(sp14:ep14);
clear Fc14
t4=t14(sp14:ep14);
clear t14

F15=Fc15(sp15:ep15);
clear Fc15
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
line([T13eta T13eta],[4.06*10^4 4.07*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
datetick('x',6)
axis([min(t3) max(t3) 4.06*10^4 4.068*10^4])
ylabel('Field Magnitude (nT)')
xlabel('Date')
title('T13: The 2006 Tonga Tsunami- F Component')

subplot(3,1,2)
plot(t4,F14, 'LineWidth',1)
line([T14eta T14eta],[3.98*10^4 3.995*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
datetick('x',6)
axis([min(t4) max(t4) 3.98*10^4 3.995*10^4])
ylabel('Field Magnitude (nT)')
xlabel('Date')
title('T14: The 2006 Tonga Tsunami- F Component')

subplot(3,1,3)
plot(t5,F15, 'LineWidth',1)
line([T15eta T15eta],[4.216*10^4 4.224*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
datetick('x',6)
axis([min(t5) max(t5) 4.216*10^4 4.224*10^4])

xlabel('Date')
ylabel('Field Magnitude (nT)')
title('T15: The 2006 Tonga Tsunami- F Component')


%% Section 5A: Fit a Fourier series to the data-- T13
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
%% Section 6A: Save the Fourier series model--T13
a1 =   4.065e+04 ;% (4.064e+04, 4.066e+04)
b1 =     1.9e+04 ;% (1.88e+04, 1.92e+04)
c1 =   1.367e+05 ;% (1.095e+05, 1.639e+05)
a2 =       790.4 ;% (453.6, 1127)
b2 =       -1873 ;% (-2536, -1210)
c2 =        6287 ;% (5511, 7063)
a3 =       32.54 ;% (28.4, 36.69)
b3 =        3561 ;% (3535, 3587)
c3 =        1050 ;% (967.8, 1133)
a4 =       766.1 ;% (525, 1007)
b4 =   4.169e+04 ;% (4.138e+04, 4.2e+04)
c4 =        3180 ;% (2626, 3734)
a5 =       20.91 ;% (18.54, 23.28)
b5 =        6181 ;% (6144, 6217)
c5 =       889.3 ;% (817.3, 961.4)
a6 =       201.2 ;% (126.7, 275.7)
b6 =   3.738e+04 ;% (3.683e+04, 3.793e+04)
c6 =        2897 ;% (2611, 3182)
a7 =       182.8 ;% (91.23, 274.4)
b7 =        7483 ;% (6630, 8337)
c7 =        5595 ;% (4913, 6276)
a8 =       431.8 ;% (195.5, 668.1)
b8 =   3.523e+04 ;% (3.385e+04, 3.661e+04)
c8 =        7359 ;% (6168, 8551)

x=m13;

F813=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
              a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
              a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
              a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
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

f14 = fit(m14,F14,'gauss8')

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
a1 =    3.99e+04 ;% (3.989e+04, 3.991e+04)
b1 =   1.968e+04 ;% (1.906e+04, 2.03e+04)
c1 =   1.507e+05 ;% (1.136e+05, 1.877e+05)
a2 =       704.5 ;% (504.4, 904.6)
b2 =       -2994 ;% (-3957, -2032)
c2 =        4851 ;% (3451, 6251)
a3 =       67.59 ;% (45.17, 90.01)
b3 =        3200 ;% (3110, 3290)
c3 =        1847 ;% (1665, 2028)
a4 =       746.3 ;% (425.7, 1067)
b4 =   4.226e+04 ;% (4.126e+04, 4.326e+04)
c4 =        4600 ;% (2821, 6379)
a5 =       84.68 ;% (-15.74, 185.1)
b5 =   3.665e+04 ;% (3.606e+04, 3.724e+04)
c5 =        2604 ;% (2013, 3195)
a6 =       34.04 ;% (32.66, 35.41)
b6 =        5947 ;% (5939, 5955)
c6 =       256.8 ;% (244, 269.7)
a7 =       277.9 ;% (22.77, 533)
b7 =        4614 ;% (1931, 7298)
c7 =        7100 ;% (4974, 9226)
a8 =       283.8 ;% (136.6, 431)
b8 =   3.411e+04 ;% (3.306e+04, 3.516e+04)
c8 =        6126 ;% (5233, 7019)

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

disp('Section 6: done') 
%% Section 5C: Fit a Fourier series to the data-- T15
clc

f15 = fit(m15,F15,'gauss8')

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
a1 =   4.219e+04 ;% (4.216e+04, 4.223e+04)
b1 =   1.982e+04 ;% (1.938e+04, 2.025e+04)
c1 =   1.212e+05 ;% (6.809e+04, 1.744e+05)
a2 =       757.2 ;% (201.8, 1313)
b2 =       -1769 ;% (-3163, -375.7)
c2 =        4544 ;% (3672, 5416)
a3 =       45.19 ;% (37.58, 52.8)
b3 =        3610 ;% (3580, 3640)
c3 =        1327 ;% (1241, 1414)
a4 =       397.8 ;% (-96.67, 892.2)
b4 =   4.263e+04 ;% (4.14e+04, 4.385e+04)
c4 =        2489 ;% (1717, 3260)
a5 =       23.37 ;% (20.5, 26.24)
b5 =        6097 ;% (6073, 6121)
c5 =       916.8 ;% (860, 973.5)
a6 =       739.1 ;% (345.4, 1133)
b6 =   4.115e+04 ;% (4.025e+04, 4.206e+04)
c6 =        5069 ;% (4432, 5707)
a7 =       534.4 ;% (-87.28, 1156)
b7 =        3475 ;% (1004, 5947)
c7 =        8296 ;% (6250, 1.034e+04)
a8 =       488.8 ;% (-96.52, 1074)
b8 =   3.528e+04 ;% (3.231e+04, 3.826e+04)
c8 =        7586 ;% (5329, 9843)

x=m15;

F815=a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
              a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
              a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
              a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);
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
axis([min(m13) max(m13) -50 50])
ylabel('Field Magnitude (nT)')
xlabel('Minutes from 2006-04-19 00:00:00')
title('T13: The 2006 Tonga Tsunami- F Component')

subplot(3,1,2)
plot(m14,Fd14,'k')
line([T14etas T14etas],[-50 50],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([min(m14) max(m14) -50 40])
ylabel('Field Magnitude (nT)')
xlabel('Minutes from 2006-04-19 00:00:00')
title('T14: The 2006 Tonga Tsunami- F Component')

subplot(3,1,3)
plot(m15,Fd15,'k')
line([T15etas T15etas],[-50 50],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16)
axis([min(m15) max(m15) -30 25])
ylabel('Field Magnitude (nT)')
xlabel('Minutes from 2006-04-19 00:00:00')
title('T15: The 2006 Tonga Tsunami- F Component')

disp('Section 7: done')