%% Clear and set initial parameters
clc; clear all; close all;

Sc = 0.1:0.1:200;
maxT=1*60*30; % .5 hours is the max period
dt= 60; % The sample rate of one per minute
waven = 'cgau4';
n=7;
daymin=24*60;

addpath('../tsunami_library')

disp('ready to go')
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
%% local = CHI, remote = ASP


%% local = KNY, remote = ASP
for i=1
    load kny_2022-01-15_zh.mat
    load asp_2022-01-15_zh.mat
    whos

    % very rough back of the envelope estimate of tsunami arrival @ KAK
    etaT= datenum('15-Jan-2022 15:45:00');

    local_Z= knyZ;
    local_H= knyH;
    remote_H= aspH;

    [W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = ...
        F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time_min, etaT);
end

%% local = CNB, remote = ASP


%% local = API, remote = ASP


%% local = IPM, remote = ASP


%% local = PPT, remote = ASP

