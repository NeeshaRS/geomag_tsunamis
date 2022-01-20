%% Clear parameters and set basics
clc; clear all;

addpath('../tsunami_library')

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

%% ASP
station = 'asp';
datapath = '../../../Data/INTERMAGNET/ASP/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 22;

[aspX, aspY, aspZ, aspH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

% save & plot ASP

% save asp_2022-01-15_zh.mat aspZ aspH time_min
[hzplot] = F_HZ_plot(time_min, aspH, aspZ)

%% detrend ASP via splines


%% KNY
station = 'kny';
datapath = '../../../Data/INTERMAGNET/KNY/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[knyX, knyY, knyZ, knyH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% save & plot KNY

save kny_2022-01-15_zh.mat knyZ knyH time_min
[hzplot] = F_HZ_plot(time_min, knyH, knyZ)

%% KAK
station = 'kak';
datapath = '../../../Data/INTERMAGNET/KAK/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[kakX, kakY, kakZ, kakH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% save & plot KAK

save kak_2022-01-15_zh.mat kakZ kakH time_min
[hzplot] = F_HZ_plot(time_min, kakH, kakZ)

%% MMB
station = 'mmb';
datapath = '../../../Data/INTERMAGNET/MMB/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[mmbX, mmbY, mmbZ, mmbH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% save & plot MMB

save mmb_2022-01-15_zh.mat mmbZ mmbH time_min
[hzplot] = F_HZ_plot(time_min, mmbH, mmbZ)

%% CNB
station = 'cnb';
datapath = '../../../Data/INTERMAGNET/CNB/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 22;

[cnbX, cnbY, cnbZ, cnbH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% save & plot CNB

save cnb_2022-01-15_zh.mat cnbZ cnbH time_min
[hzplot] = F_HZ_plot(time_min, cnbH, cnbZ)

%% API
station = 'api';
datapath = '../../../Data/INTERMAGNET/API/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 22;

[apiX, apiY, apiZ, apiH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% save & plot API

save api_2022-01-15_zh.mat apiZ apiH time_min
[hzplot] = F_HZ_plot(time_min, apiH, apiZ)

%% PPT
station = 'ppt';
datapath = '../../../Data/INTERMAGNET/PPT/variational/2022/01/';
timeres = 'min';
dtype = 'v';
num_header = 25;

[pptX, pptY, pptZ, pptH] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

%% plot PPT

save ppt_2022-01-15_zh.mat pptZ pptH time_min
[hzplot] = F_HZ_plot(time_min, pptH, pptZ)

%% IPM
station = 'ipm';
datapath = '../../../Data/INTERMAGNET/IPM/variational/2022/01/';
timeres = 'sec';
dtype = 'v';
num_header = 23;

[ipmX_s, ipmY_s, ipmZ_s, ipmH_s] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header);

[hzplot] = F_HZ_plot(time_s, ipmH_s, ipmZ_s)

%% resample IPM to 1 minute
ipmH = interp1(time_s,ipmH_s,time_min) 
ipmZ = interp1(time_s,ipmZ_s,time_min) 
disp('interpolated IPM to 1 minute from 1 second')
%% save & plot IPM

save ipm_2022-01-15_zh.mat ipmZ ipmH time_min
[hzplot] = F_HZ_plot(time_min, ipmH, ipmZ)