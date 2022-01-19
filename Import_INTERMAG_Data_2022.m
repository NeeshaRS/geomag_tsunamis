%% Clear parameters and set basics
clc; clear all;

addpath('tsunami_library')

daymin = 24*60;
daysec = daymin*60;

% time period of interest
time1 = datenum('01-15-2022 00:00:00');
timeE = datenum('01-15-2022 23:59:59');

% build time arrays
time_s = time1:1/daysec:timeE;
time_min = time1:1/daymin:timeE;
disp('Time arrays made.')

% time data for finding data files
year = '2022';
month = '01';
days= 15; %:16;

%% KNY: remote for KAK, MMB, and CHI
station = 'kny';
datapath = '../../Data/INTERMAGNET/KNY/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[knyX, knyY, knyZ, knyH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot KNY
[hzplot] = F_HZ_plot(time_min, knyH, knyZ)

%% KAK
station = 'kak';
datapath = '../../Data/INTERMAGNET/KAK/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[kakX, kakY, kakZ, kakH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot KAK
[hzplot] = F_HZ_plot(time_min, kakH, kakZ)

%% MMB
station = 'mmb';
datapath = '../../Data/INTERMAGNET/MMB/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[mmbX, mmbY, mmbZ, mmbH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot MMB
[hzplot] = F_HZ_plot(time_min, mmbH, mmbZ)

%% CNB
station = 'cnb';
datapath = '../../Data/INTERMAGNET/CNB/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 22;

[cnbX, cnbY, cnbZ, cnbH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot CNB
[hzplot] = F_HZ_plot(time_min, cnbH, cnbZ)

%% API
station = 'api';
datapath = '../../Data/INTERMAGNET/API/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 22;

[apiX, apiY, apiZ, apiH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot API
[hzplot] = F_HZ_plot(time_min, apiH, apiZ)

%% PPT
station = 'ppt';
datapath = '../../Data/INTERMAGNET/PPT/variational/2022/01/';
timeres = 'min';
dtype = 'v';
num_header = 25;

[pptX, pptY, pptZ, pptH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot PPT
[hzplot] = F_HZ_plot(time_min, pptH, pptZ)

%% IPM
station = 'ipm';
datapath = '../../Data/INTERMAGNET/IPM/variational/2022/01/';
timeres = 'sec';
dtype = 'v';
num_header = 23;

[ipmX, ipmY, ipmZ, ipmH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot IPM
[hzplot] = F_HZ_plot(time_s, ipmH, ipmZ)