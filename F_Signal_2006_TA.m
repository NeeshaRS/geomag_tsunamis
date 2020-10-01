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
ep13=int64((T13eta-t13(1))*daymin)+180;

sp14=int64((IT-t14(1))*daymin)+1;
ep14=int64((T14eta-t14(1))*daymin)+180;

sp15=int64((IT-t15(1))*daymin)+1;
ep15=int64((T15eta-t15(1))*daymin)+180;

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
%% Section 5A: Fit a Fourier series to the data-- T13
clc

f13 = fit(m13,F13,'fourier8')

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
a0 =   4.066e+04 ;% (4.066e+04, 4.066e+04)
a1 =      0.8203 ;% (0.6897, 0.9508)
b1 =      -4.613 ;% (-4.68, -4.546)
a2 =      -2.186 ;% (-2.361, -2.012)
b2 =      -3.497 ;% (-3.623, -3.372)
a3 =     -0.9199 ;% (-0.9573, -0.8826)
b3 =      0.2731 ;% (0.1633, 0.3829)
a4 =     -0.8741 ;% (-0.8957, -0.8524)
b4 =     -0.0767 ;% (-0.1684, 0.01505)
a5 =     -0.4623 ;% (-0.498, -0.4266)
b5 =     -0.2631 ;% (-0.3434, -0.1828)
a6 =      -0.418 ;% (-0.4889, -0.3471)
b6 =      0.3311 ;% (0.2456, 0.4167)
a7 =     -0.1465 ;% (-0.2185, -0.07441)
b7 =      0.1682 ;% (0.1254, 0.2109)
a8 =      0.3588 ;% (0.2891, 0.4285)
b8 =      0.2765 ;% (0.2104, 0.3425)
w =    0.007027 ;% (0.006977, 0.007076)

x=m13;

F813=a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
               a2.*cos(2*x.*w) + b2.*sin(2*x.*w) + a3.*cos(3*x.*w) + b3.*sin(3*x.*w) + ...
               a4.*cos(4*x.*w) + b4.*sin(4*x.*w) + a5.*cos(5*x.*w) + b5.*sin(5*x.*w) + ...
               a6.*cos(6*x.*w) + b6.*sin(6*x.*w) + a7.*cos(7*x.*w) + b7.*sin(7*x.*w) + ...
               a8.*cos(8*x.*w) + b8.*sin(8*x.*w);
%%     
figure(2)
hold on
plot(m13,F13,'LineWidth',2)
% plot(m13,F13,'o')
% plot(m13,F813+1,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m13) max(m13) 4.0656*10^4 4.0672*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Calculated Field Magnitude compared with the Fourier Series(red)')

disp('Section 6A: done') 

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
a0 =   3.991e+04 ;% (3.991e+04, 3.991e+04)

a1 =      0.9474 ;% (0.6415, 1.253)
b1 =       -9.72 ;% (-9.766, -9.675)

a2 =      -4.961 ;% (-5.163, -4.758)
b2 =      -3.472 ;% (-3.784, -3.16)

a3 =     -0.8963 ;% (-0.9704, -0.8222)
b3 =      0.7951 ;% (0.6398, 0.9504)

a4 =      -1.368 ;% (-1.398, -1.338)
b4 =    -0.01716 ;% (-0.1847, 0.1504)

a5 =     -0.5149 ;% (-0.5861, -0.4436)
b5 =      0.2256 ;% (0.1175, 0.3338)

a6 =     -0.3789 ;% (-0.4818, -0.276)
b6 =      0.3884 ;% (0.3033, 0.4734)

a7 =    -0.07891 ;% (-0.1954, 0.0376)
b7 =      0.3285 ;% (0.2941, 0.3629)

a8 =      0.5244 ;% (0.4571, 0.5917)
b8 =      0.2103 ;% (0.109, 0.3117)

w =    0.006983 ;% (0.006935, 0.007031)

x=m14;

F814=a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
               a2.*cos(2*x.*w) + b2.*sin(2*x.*w) + a3.*cos(3*x.*w) + b3.*sin(3*x.*w) + ...
               a4.*cos(4*x.*w) + b4.*sin(4*x.*w) + a5.*cos(5*x.*w) + b5.*sin(5*x.*w) + ...
               a6.*cos(6*x.*w) + b6.*sin(6*x.*w) + a7.*cos(7*x.*w) + b7.*sin(7*x.*w) + ...
               a8.*cos(8*x.*w) + b8.*sin(8*x.*w);
%%     
figure(2)
hold on
plot(m14,F14,'LineWidth',2)
% plot(m14,F14,'o')
% plot(m14,F814+1,'r','LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m14) max(m14) 3.99*10^4 3.993*10^4])
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
a0 =   4.221e+04 ;% (4.221e+04, 4.221e+04)

a1 =      0.8317 ;% (0.7286, 0.9348)
b1 =      0.3472 ;% (0.1957, 0.4987)

a2 =       1.645 ;% (1.169, 2.122)
b2 =       -3.48 ;% (-3.67, -3.29)

a3 =      -2.403 ;% (-2.44, -2.367)
b3 =       0.253 ;% (-0.2468, 0.7528)

a4 =    0.003738 ;% (-0.1845, 0.1919)
b4 =      0.6344 ;% (0.5708, 0.6979)

a5 =    -0.06608 ;% (-0.1337, 0.001495)
b5 =     -0.1532 ;% (-0.2017, -0.1046)

a6 =     -0.1905 ;% (-0.2863, -0.09476)
b6 =      0.3061 ;% (0.2116, 0.4007)

a7 =     -0.0784 ;% (-0.1725, 0.01568)
b7 =      0.1651 ;% (0.1347, 0.1955)

a8 =      0.1556 ;% (0.1175, 0.1936)
b8 =     0.04107 ;% (-0.03781, 0.1199)

w =     0.00698 ;% (0.006864, 0.007097)

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
plot(m13,F813+1,'r','LineWidth',1)
line([T13etas T13etas],[4.0655*10^4 4.0675*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m13) max(m13) 4.0655*10^4 4.0675*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')
legend('Data','Fourier Series')
title('T13')
%%
% subplot(3,1,2)
hold on
plot(m14,F14,'o')
plot(m14,F814+1,'r','LineWidth',1)
line([T14etas T14etas],[3.99*10^4 3.993*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m14) max(m14) 3.99*10^4 3.993*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')
legend('Data','Fourier Series')
title('T14')
%%
subplot(3,1,3)
hold on
plot(m15,F15,'o')
plot(m15,F815+5,'r','LineWidth',1)
line([T15etas T15etas],[4.22*10^4 4.223*10^4],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m15) max(m15) 4.22*10^4 4.223*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')
legend('Data','Fourier Series')
title('T15')

disp('Section 6C: done')  
%% Section 7: Subtract the Fourier series model from the data to detrend it
Fd13=F13-F813-1;
Fd14=F14-F814-1;
Fd15=F15-F815-5;
%%
% subplot(3,1,1)
hold on
plot(m13,F13,'k','LineWidth',1)
line([T13etas T13etas],[30000 70000],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m13) max(m13) 4.0656*10^4 4.0672*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')

F=F13(floor(T13etas))

title('T13')
%%
% subplot(3,1,2)
hold on
plot(m14,F14,'k','LineWidth',1)
line([T14etas T14etas],[30000 70000],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(m14) max(m14) 3.99*10^4 3.993*10^4])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')

F=F14(floor(T14etas))

title('T14')
%%
subplot(3,1,3)
hold on
plot(m15,F15,'k','LineWidth',1)
line([T15etas T15etas],[-1 1],'Color',[1 0 0],'LineWidth',1)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(m15) max(m15) -1 .5])
xlabel('Minutes from 2006-05-03 15:00:00')
ylabel('Field Magnitude (nT)')

title('T15')

F=F15(floor(T15etas))

disp('Section 7: done')