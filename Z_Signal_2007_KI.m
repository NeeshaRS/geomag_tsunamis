% Neesha Schnepf
% The magnetic field F value during the tsunami time period
% 2007 tsunami: 01/13/07 04:23:21

%% Section 1: Setting the initial times
clc
clear all

% Initial time
IT=datenum('2007-01-13 04:00:00');
% Time of earthquake
EQT=datenum('2007-01-13 04:23:21.1');


eta18= 8143; % s, water elevation arrival time

dayseconds=24*60*60;
daymin=24*60;

% Expected time tsunami arrives at station
KIeta=EQT+eta18/dayseconds;
save KIeta.mat KIeta
load T18ETA.mat
T18ETAs=(T18ETA-IT)*daymin;

disp('Section 1: done')
%% Section 2: Load the data
addpath /Users/NeeshaSchnepf/RESEARCH/Data/OBEM/Baba_2011


load Z18.mat % raw data
load t18.mat % the time

Z18=Z18(~isnan(Z18));
t18=t18(~isnan(Z18));

disp('Section 2: done')
%% Section 3: Setting the start times for the tsunami relevant data

% startp=int64((IT-t18(1))*daymin)+1;
% endp=int64((T18ETA-t18(1))*daymin)+180;

startp=int64((T18ETA-t18(1))*daymin)-180;
endp=int64((T18ETA-t18(1))*daymin)+180;

disp('Section 3: done')

%% Section 4: Saving the relevant time frame
Z=Z18(startp:endp);
clear Z18
time=t18(startp:endp);
clear t18
minutes=[0:1:length(time)-1]';

disp('Section 4: done')

%% Section 5: Fit a Gaussian to the data
clc
f = fit(minutes,Z,'Gauss8')

figure(1)
hold on
plot(f,minutes,Z)
set(gca,'FontSize',16,'LineWidth',1)
% axis([min(minutes) max(minutes) 3.9672*10^4 3.9688*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Z Field Component compared with the Fourier Series Fit (red)')

disp('Section 5: done')

%% Section 6: Save the Gaussian model

a1 =   2.368e+04 ;% (2.368e+04, 2.368e+04)
b1 =       392.5 ;% (386.2, 398.8)
c1 =     1.3e+04 ;% (1.274e+04, 1.326e+04)
a2 =       7.484 ;% (2.696, 12.27)
b2 =      -6.101 ;% (-133.1, 120.9)
c2 =       41.04 ;% (-652.3, 734.3)
a3 =      0.9272 ;% (-141.7, 143.5)
b3 =        23.4 ;% (-660.1, 706.9)
c3 =       11.94 ;% (-367.6, 391.5)
a4 =       1.564 ;% (-164.2, 167.3)
b4 =       36.46 ;% (-144.5, 217.4)
c4 =       12.13 ;% (-547.1, 571.3)
a5 =       1.821 ;% (-194.1, 197.8)
b5 =       49.95 ;% (-366.5, 466.4)
c5 =       12.69 ;% (-348, 373.4)
a6 =       1.674 ;% (-47.4, 50.75)
b6 =       65.34 ;% (-197.2, 327.9)
c6 =        15.9 ;% (-256.8, 288.6)
a7 =       1.031 ;% (-14.88, 16.95)
b7 =       87.05 ;% (-161.5, 335.6)
c7 =       19.25 ;% (-115, 153.5)
a8 =     0.06845 ;% (-0.6225, 0.7594)
b8 =       115.6 ;% (98.69, 132.6)
c8 =       7.864 ;% (-34.48, 50.21)

x=minutes;

F8=a1*exp(-((x-b1)/c1).^2) + a2*exp(-((x-b2)/c2).^2) + ...
              a3*exp(-((x-b3)/c3).^2) + a4*exp(-((x-b4)/c4).^2) + ...
              a5*exp(-((x-b5)/c5).^2) + a6*exp(-((x-b6)/c6).^2) + ...
              a7*exp(-((x-b7)/c7).^2) + a8*exp(-((x-b8)/c8).^2);
%%
figure(2)
hold on
plot(minutes,Z,'o','MarkerSize',10)
plot(minutes,F8+1,'r','LineWidth',2)
set(gca,'FontSize',16,'LineWidth',1)
axis([min(minutes) max(minutes) 2.3666*10^4 2.3682*10^4])
xlabel('Date')
ylabel('Field Magnitude (nT)')
title('Z Field Component compared with the Gaussian Fit (red)')

disp('Section 6: done') 
%% Section 7: Subtract the Fourier series model from the data to detrend it
Zd=Z-F8-1;

figure(3)
hold on
plot(minutes,Zd,'k')
set(gca,'FontSize',16)
axis([min(minutes) max(minutes) -.4 .3])
xlabel('Minutes from 2007-01-13 04:00:00')
ylabel('Field Magnitude (nT)')
title('Z Field Component')

line([T18ETAs T18ETAs],[-1 3],'Color',[1 0 0])

disp('Section 7: done')