function [W_local_Zw1, CWA_plot,zoom_plot, maxamp, maxtime] = F_CWA(Sc, maxT, dt, waven, n, local_Z, local_H, remote_H, time, etaT)
% Goal is to perform the crosswavelet analysis on the data.

% Inputs-
% Sc: the range of frequencies. 
% maxT: the max period allowed. Given in seconds.
% dt: the sample rate [Hz]
% waven: the type of Mother wavelet to use
% n: order of the Butterworth filter
% local_Z: the local vertical data
% local_H: the local vertical data
% remote_H: the remote vertical data
% time: the time corresponding to the data series
% etaT: the estimated time of arrival of the tsunami wave

% Output-
% W_local_Zw1: absolute value of the resulting vertical component
% periodogram
% A figure of the resulting periodograms (full time span & zoomed in)

disp('starting high pass filter'); tic;
% High pass filter
[local_Zf] = F_HPF(maxT, dt, n, local_Z);
[local_Hf] = F_HPF(maxT, dt, n, local_H);
[remote_Hf] = F_HPF(maxT, dt, n, remote_H);

toc; 
disp('high pass filter complete')

disp('starting complex wavelet transforms'); tic;
% Complex wavelet transforms
perd = 1./scal2frq(Sc,waven,dt);
local_Zw = cwt(local_Zf,Sc,waven);
local_Hw = cwt(local_Hf,Sc,waven);
remote_Hw = cwt(remote_Hf,Sc,waven); 

toc; 
disp('complex wavelet transforms complete')

a=perd/60;

[CWA_plot,zoom_plot, maxamp, maxtime] = F_CWA_plot(a, maxT, time, etaT, abs(local_Hw))
[CWA_plot,zoom_plot, maxamp, maxtime] = F_CWA_plot(a, maxT, time, etaT, abs(remote_Hw))
[CWA_plot,zoom_plot, maxamp, maxtime] = F_CWA_plot(a, maxT, time, etaT, abs(local_Zw))

disp('crossing the two horizontal wavelets..'); tic;
% Cross the two horizontal stations to produce the weight
Hxy = remote_Hw .* conj(local_Hw);
cc = abs(max(max(abs(Hxy))) - abs(Hxy) );
weight = (cc./max(max(cc)));
toc; 
disp('crossed!')

% Now apply the weight to the wavelet spectrum of Z
W_local_Zw = (abs(local_Zw).*weight);

% Use the absolute values
Hxy1=abs(Hxy);
W_local_Zw1=abs(W_local_Zw);

disp('Cross-wavelet analysis complete.')

[CWA_plot,zoom_plot, maxamp, maxtime] = F_CWA_plot(a, maxT, time, etaT, W_local_Zw1)

