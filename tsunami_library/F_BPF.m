function [data_f] = F_BPF(minT, maxT, dt, n, data)
% Goal is to band pass filter data sets.

% Inputs-
% minT: the min period allowed. Given in seconds. 
% maxT: the max period allowed. Given in seconds. 
% dt: the number of seconds between data sampling
% n: order of the Butterworth filter
% data: the data being filtered

% Output-
% data_f: the high pass filtered data series

fs= 1/dt; % sample rate in Hz
fcutlow= 1/maxT; % low frequency bound
fcuthigh= 1/minT; % max frequency bound

[B, A] = butter(n,[fcutlow,fcuthigh]/(fs/2),'bandpass');

data_f = filtfilt(B,A,data);