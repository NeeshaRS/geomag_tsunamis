clc; clear all; close all;

load NWP_2011_data.mat;
load MMB_data.mat;

whos

Sc = 0.1:0.1:200;
maxT=1*60*30; % .5 hours is the max period
dt= 60; % The sample rate of one per minute
waven = 'cgau4';
n=7;
daymin=24*60;
etaT= datenum('11-Mar-2011 07:30:00'); % Value given by Takuto over email


local_Z= Z_raw;
local_H=(X_raw.^2+Y_raw.^2).^.5;
remote_H= mmbH;

[W_local_Zw1,CWA_plot,zoom_plot, maxamp, maxtime] = F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, timeNWP, etaT);