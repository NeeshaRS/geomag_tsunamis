%% Clear and set initial parameters
clc; clear all; close all;

Sc = 0.1:0.1:200;
T= 120;  % max period in minutes
maxT=1*60*T; 

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

    figlocation= 'figures/API/wavelet_analysis/30min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT, figlocation);
end

%% local = CBI, remote = KAK
for i=1
    load cbi_2022-01-15_zh.mat
    load kak_2022-01-15_zh.mat
    whos

    stationC= 'CBI';

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 11:16:45');

    local_Z= cbiZ;
    local_H= cbiH;
    remote_H= kakH;

    figlocation= ...
    sprintf('figures/%s/wavelet_analysis/%imin_maxT/',...
        stationC, T);
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = CNB, remote = ASP
for i=1
    load cnb_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
%     etaT= datenum('15-Jan-2022 10:30:00');  
    % match API's ETA for comparison
%     etaT= datenum('15-Jan-2022 05:11:00');
    % skip having an eta
    etaT= NaN;

    local_Z= cnbZ;
    local_H= cnbH;
    remote_H= aspH;

    figlocation= 'figures/CNB/30min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = CTA, remote = ASP
for i=1
    load cta_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    % etaT= datenum('15-Jan-2022 10:30:00');  
    % match API's ETA for comparison
%     etaT= datenum('15-Jan-2022 05:11:00'); 
    % skip having an eta
    etaT= NaN;

    local_Z= ctaZ;
    local_H= ctaH;
    remote_H= aspH;

    figlocation= 'figures/CTA/30min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = EYR, remote = ASP
for i=1
    load eyr_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
%     etaT= datenum('15-Jan-2022 10:30:00');  
    % match API's ETA for comparison
%     etaT= datenum('15-Jan-2022 05:11:00'); 
    % skip having an eta
    etaT= NaN;


    local_Z= eyrZ;
    local_H= eyrH;
    remote_H= aspH;

    figlocation= 'figures/EYR/30min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = HON, remote = ASP
for i=1
    load hon_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % based on HPF from Water_level_analysis.m
    etaT= datenum('15-Jan-2022 09:07:00');

    local_Z= honZ;
    local_H= honH;
    remote_H= aspH;
    
%     figlocation= 'figures/HON/wavelet_analysis/10min_maxT/';
%     figlocation= 'figures/HON/wavelet_analysis/30min_maxT/';
    figlocation= 'figures/HON/wavelet_analysis/120min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = IPM, remote = ASP
for i=1
    load ipm_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 13:42:00');

    local_Z= ipmZ;
    local_H= ipmH;
    remote_H= aspH;
    
%     figlocation= 'figures/IPM/wavelet_analysis/10min_maxT/';
%     figlocation= 'figures/IPM/wavelet_analysis/30min_maxT/';
    figlocation= 'figures/IPM/wavelet_analysis/120min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = KAK, remote = ASP
for i=1
    load kak_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos
    
    stationC= 'KAK';

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    % etaT= datenum('15-Jan-2022 14:00:00');
    % skip having an eta
    etaT= NaN;

    local_Z= kakZ;
    local_H= kakH;
    remote_H= aspH;
    
    figlocation= ...
    sprintf('figures/%s/%imin_maxT/',...
        stationC, T);
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = KNY, remote = ASP
for i=1
    load kny_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos
    
    stationC= 'KNY';

    % very rough back of the envelope estimate of tsunami arrival @ KAK
%     etaT= datenum('15-Jan-2022 15:45:00');
    % match API's ETA for comparison
    % etaT= datenum('15-Jan-2022 05:11:00');
    % skip having an eta
    etaT= NaN;

    local_Z= knyZ;
    local_H= knyH;
    remote_H= aspH;

    figlocation= ...
    sprintf('figures/%s/%imin_maxT/',...
        stationC, T);
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = MMB, remote = ASP
for i=1
    load mmb_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos
    
    stationC= 'MMB';

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    % etaT= datenum('15-Jan-2022 15:00:00');
    % skip having an eta
    etaT= NaN;

    local_Z= mmbZ;
    local_H= mmbH;
    remote_H= aspH;
    
    figlocation= ...
    sprintf('figures/%s/%imin_maxT/',...
        stationC, T);
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end

%% local = PPT, remote = ASP
for i=1
    load ppt_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 06:48:00');

    local_Z= pptZ;
    local_H= pptH;
    remote_H= aspH;
    
    figlocation= 'figures/PPT/wavelet_analysis/10min_maxT/';
%     figlocation= 'figures/PPT/wavelet_analysis/30min_maxT/';
%     figlocation= 'figures/PPT/wavelet_analysis/120min_maxT/';
    addpath(figlocation)

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, ...
        remote_H, time_min, etaT, figlocation);
end
