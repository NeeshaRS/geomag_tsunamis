%% Load in the data
close all; clear all; clc;
addpath /Users/neeshaschnepf/RESEARCH/Data/OBEM/Baba_2011
load Z18.mat; load Y18.mat; load X18.mat; load t18.mat;

addpath NWP/NWP_data/ % This is only January data
load NWP_01-07.mat

H18=(Y18.^2+X18.^2).^.5;
Bh=(By.^2+Bx.^2).^.5;

whos
%% Make sure they are the same time span
daymin=24*60;

startdate=datenum('January 1 2007 00:00:00');
enddate=datenum('January 31 2007 23:58:00');
sp=int64((startdate-t18(1))*daymin)+1;
ep=int64((enddate-t18(1))*daymin)+1;

Z18=Z18(sp:ep);
Y18=Y18(sp:ep);
X18=X18(sp:ep);
H18=(Y18.^2+X18.^2).^.5;
time=t18(sp:ep);

Bh=(By.^2+Bx.^2).^.5;

clc; whos;
%% Parameters for power spectra

F18=1/60; % 1 sample per minute for T18
N18=length(Z18); 
z18dft=fft(Z18); z18dft=z18dft(1:N18/2+1);
h18dft=fft(H18); h18dft=h18dft(1:N18/2+1);
psdz18=(1/(F18*N18)) * abs(z18dft).^2;
psdz18(2:end-1) = 2*psdz18(2:end-1);
psdh18=(1/(F18*N18)) * abs(h18dft).^2;
psdh18(2:end-1) = 2*psdh18(2:end-1);
freq18 = 0:F18/N18:F18/2;

Fnwp=1/120; % 1 sample per 2 minutes for NWP
Nnwp=length(Bz);
zNdft=fft(Bz); zNdft=zNdft(1:Nnwp/2+1);
hNdft=fft(Bh); hNdft=hNdft(1:Nnwp/2+1);
psdzN=(1/(Fnwp*Nnwp)) * abs(zNdft).^2;
psdzN(2:end-1) = 2*psdzN(2:end-1);
psdhN=(1/(Fnwp*Nnwp)) * abs(hNdft).^2;
psdhN(2:end-1) = 2*psdhN(2:end-1);
freqN = 0:Fnwp/Nnwp:Fnwp/2;

clc; whos;
%% Plot for T18 and NWP
tsunamiF=2*pi/(15*60);

figure(1)
loglog(freqN,psdzN.^.5,'-k'); %xlim([0 8e-3]); 
set(gca,'FontSize',16); hold on
line([tsunamiF tsunamiF],[1e-3 1e4],'LineStyle','--','color','b','LineWidth',1) 
grid on
title('T18 Z Periodogram')
xlabel('Frequency (Hz)')
ylabel('Power/Frequency (nT Hz^{-1/2})')

% print -dpng T18_2007_Z_PowerSpectra.png 