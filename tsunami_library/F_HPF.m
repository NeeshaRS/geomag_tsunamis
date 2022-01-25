function [data_f] = F_HPF(maxT, dt, n, data)
% Goal is to high pass filter data sets.

% Inputs-
% maxT: the max period allowed. Given in seconds. 
% dt: the sample rate [Hz]
% n: order of the Butterworth filter
% data: the data being filtered

% Output-
% data_f: the high pass filtered data series

w = dt*2.0/maxT;
[B, A] = butter(n,w,'high');

data_f = filtfilt(B,A,data);