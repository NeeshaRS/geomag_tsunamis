%% Clear parameters and set basics
clc; clear all;

addpath('tsunami_library')

daymin = 24*60;
daysec = daymin*60;

% time period of interest
time1 = datenum('01-15-2022 00:00:00');
timeE = datenum('01-16-2022 23:59:59');

% build time arrays
time_s = time1:1/daysec:timeE;
time_min = time1:1/daymin:timeE;
disp('Time arrays made.')

% time data for finding data files
year = '2022';
month = '01';
days= 15:16;

%% KAK
station = 'kak';
datapath = '../../Data/INTERMAGNET/KAK/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[kakX, kakY, kakZ, kakH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot KAK
figure(1)
subplot(211)
plot(time_min, kakZ)

subplot(212)
plot(time_min, kakH)

%% API
station = 'api';
datapath = '../../Data/INTERMAGNET/API/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 22;

[apiX, apiY, apiZ, apiH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot API
figure(1)
subplot(211)
plot(time_min, apiZ)

subplot(212)
plot(time_min, apiH)
%% MMB
station = 'mmb';
datapath = '../../Data/INTERMAGNET/MMB/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[mmbX, mmbY, mmbZ, mmbH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot MMB
figure(1)
subplot(211)
plot(time_min, mmbZ)

subplot(212)
plot(time_min, mmbH)

%% PPT
station = 'ppt';
datapath = '../../Data/INTERMAGNET/PPT/variational/2022/01/';
timeres = 'min';
dtype = 'v';
num_header = 25;

[pptX, pptY, pptZ, pptH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot PPT
figure(1)
subplot(211)
plot(time_min, pptZ)

subplot(212)
plot(time_min, pptH)
%% IPM
station = 'ipm';
datapath = '../../Data/INTERMAGNET/IPM/variational/2022/01/';
timeres = 'sec';
dtype = 'v';
num_header = 23;

[ipmX, ipmY, ipmZ, ipmH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot IPM
figure(1)
subplot(211)
plot(time_s, ipmZ)

subplot(212)
plot(time_s, ipmH)
%%  


addpath 
days= 15:16;
formatSpec = 'kak202201%dpsec.sec';
daynum= 1;

for n=days
    filename = sprintf(formatSpec,n)
    delimiterIn = ' ';
    headerlinesIn = 20;
    A = importdata(filename,delimiterIn,headerlinesIn);
    
    sp=1+(daynum-1)*daysec;
    ep=daysec+(daynum-1)*daysec;
    daynum= 1 + daynum;

    kakX(sp:ep)=A.data(:,2);
    kakY(sp:ep)=A.data(:,3);
    kakZ(sp:ep)=A.data(:,4);
end
disp('KAK data read in to matlab arrays.')

kakH = (kakX.^2+kakY.^2).^.5;
disp('Horiztonal component made')

