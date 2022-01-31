%% Clear and set initial parameters
clc; clear all; close all;

Sc = 0.1:0.1:200;
maxT=1*60*30; % .5 hours is the max period
dt= 60; % The sample rate of one per minute
waven = 'cgau4';
n=7;
daymin=24*60;

addpath matlab_datafiles/
addpath('../tsunami_library')

disp('ready to go')

%% local = API, remote = ASP
for i=1
    load api_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % based on HPF from Water_level_analysis.m
    etaT= datenum('15-Jan-2022 05:11:00');

    local_Z= apiZ;
    local_H= apiH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = CBI, remote = ASP
for i=1
    load cbi_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 13:00:00');

    local_Z= cbiZ;
    local_H= cbiH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = CNB, remote = ASP
for i=1
    load cnb_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
%     etaT= datenum('15-Jan-2022 10:30:00');  
    % match API's ETA for comparison
    etaT= datenum('15-Jan-2022 05:11:00'); 

    local_Z= cnbZ;
    local_H= cnbH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = HON, remote = ASP
for i=1
    load hon_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 10:15:00');

    local_Z= honZ;
    local_H= honH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = IPM, remote = ASP
for i=1
    load ipm_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 10:15:00');

    local_Z= ipmZ;
    local_H= ipmH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = KAK, remote = ASP
for i=1
    load kak_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 14:00:00');

    local_Z= kakZ;
    local_H= kakH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = KNY, remote = ASP
for i=1
    load kny_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
%     etaT= datenum('15-Jan-2022 15:45:00');
    % match API's ETA for comparison
    etaT= datenum('15-Jan-2022 05:11:00');

    local_Z= knyZ;
    local_H= knyH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = MMB, remote = ASP
for i=1
    load mmb_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 15:00:00');

    local_Z= mmbZ;
    local_H= mmbH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = PPT, remote = ASP
for i=1
    load ppt_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 7:45:00');

    local_Z= pptZ;
    local_H= pptH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end
