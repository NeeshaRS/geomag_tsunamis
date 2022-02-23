%% Clear parameters and set basics
clc; clear all; close all;

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

%% API
for i=1
    station = 'api';
    datapath = '../../../Data/INTERMAGNET/API/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 22;

    [apiX, apiY, apiZ, apiH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot API

    % save api_2022-01-15_zh.mat apiZ apiH time_min
    [hzplot] = F_HZ_plot(time_min, apiH, apiZ)
end
%% ASP
for i=1
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
end
%% CBI
for i=1
    station = 'cbi';
    datapath = '../../../Data/INTERMAGNET/CBI/';
    timeres = 'sec';
    dtype = 'p';
    num_header = 20;

    [cbiX_s, cbiY_s, cbiZ_s, cbiH_s] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    [hzplot] = F_HZ_plot(time_s, cbiH_s, cbiZ_s)

    % resample CBI to 1 minute
    cbiH = interp1(time_s,cbiH_s,time_min)
    cbiZ = interp1(time_s,cbiZ_s,time_min)
    disp('interpolated CBI to 1 minute from 1 second')

    [hzplot] = F_HZ_plot(time_min, cbiH, cbiZ)
    save cbi_2022-01-15_zh.mat cbiZ cbiH time_min

end
%% CNB
for i=1
    station = 'cnb';
    datapath = '../../../Data/INTERMAGNET/CNB/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 22;

    [cnbX, cnbY, cnbZ, cnbH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot CNB

    save cnb_2022-01-15_zh.mat cnbZ cnbH time_min
    [hzplot] = F_HZ_plot(time_min, cnbH, cnbZ)
end
%% CTA
for i=1
    station = 'cta';
    datapath = '../../../Data/INTERMAGNET/CTA/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 22;

    [ctaX, ctaY, ctaZ, ctaH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot CTA

    save cta_2022-01-15_zh.mat ctaZ ctaH time_min
    [hzplot] = F_HZ_plot(time_min, ctaH, ctaZ)
end
%% EYR
for i=1
    station = 'eyr';
    datapath = '../../../Data/INTERMAGNET/EYR/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 22;

    [eyrX, eyrY, eyrZ, eyrH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot EYR

    save eyr_2022-01-15_zh.mat eyrZ eyrH time_min
    [hzplot] = F_HZ_plot(time_min, eyrH, eyrZ)
end

%% HON
for i=1
    station = 'hon';
    datapath = '../../../Data/INTERMAGNET/HON/provisional/2022/01/';
    timeres = 'min';
    dtype = 'v';
    num_header = 22;

    [honX, honY, honZ, honH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    [hzplot] = F_HZ_plot(time_min, honH, honZ)

    save hon_2022-01-15_zh.mat honZ honH time_min
end

%% IPM
for i=1
    station = 'ipm';
    datapath = '../../../Data/INTERMAGNET/IPM/variational/2022/01/';
    timeres = 'sec';
    dtype = 'v';
    num_header = 23;

    [ipmX_s, ipmY_s, ipmZ_s, ipmH_s] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    [hzplot] = F_HZ_plot(time_s, ipmH_s, ipmZ_s)

    % resample IPM to 1 minute
    ipmH = interp1(time_s,ipmH_s,time_min)
    ipmZ = interp1(time_s,ipmZ_s,time_min)
    disp('interpolated IPM to 1 minute from 1 second')
    % save & plot IPM

    save ipm_2022-01-15_zh.mat ipmZ ipmH time_min
    [hzplot] = F_HZ_plot(time_min, ipmH, ipmZ)
end

%% KNY
for i=1
    station = 'kny';
    datapath = '../../../Data/INTERMAGNET/KNY/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 20;

    [knyX, knyY, knyZ, knyH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot KNY

    save kny_2022-01-15_zh.mat knyZ knyH time_min
    [hzplot] = F_HZ_plot(time_min, knyH, knyZ)
end
%% KAK
for i=1
    station = 'kak';
    datapath = '../../../Data/INTERMAGNET/KAK/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 20;

    [kakX, kakY, kakZ, kakH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot KAK

    save kak_2022-01-15_zh.mat kakZ kakH time_min
    [hzplot] = F_HZ_plot(time_min, kakH, kakZ)
end
%% MMB
for i=1
    station = 'mmb';
    datapath = '../../../Data/INTERMAGNET/MMB/provisional/2022/01/';
    timeres = 'min';
    dtype = 'p';
    num_header = 20;

    [mmbX, mmbY, mmbZ, mmbH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % save & plot MMB

    save mmb_2022-01-15_zh.mat mmbZ mmbH time_min
    [hzplot] = F_HZ_plot(time_min, mmbH, mmbZ)
end

%% PPT
for i=1
    station = 'ppt';
    datapath = '../../../Data/INTERMAGNET/PPT/variational/2022/01/';
    timeres = 'min';
    dtype = 'v';
    num_header = 25;

    [pptX, pptY, pptZ, pptH] = F_load_INTERMAG(station, datapath, timeres, ...
        dtype, year, month, days, num_header);

    % plot PPT

    % save ppt_2022-01-15_zh.mat pptZ pptH time_min
    [hzplot] = F_HZ_plot(time_min, pptH, pptZ)
end