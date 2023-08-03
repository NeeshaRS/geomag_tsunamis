clc; clear all; close all;
%% Set initial parameters
% sigma_o = 4; % S/m
sigma_o = 3.2; % S/m
h_obs = 2905; % m
g = 9.81; % m/s^2
mu = 4*pi*10^(-7); % H/m

%% Get ocean scale length & depth ratio
K = 1/(sigma_o*mu);
L = (2*K/(g^.5))^(2/3) % ocean scale length [m]

depth_ratio = h_obs/L
%% Self induction vs diffusion
h = 1:100:7001; % m

c = (g*h).^.5 ; % m/s
cd = 2*K*(h.^(-1)) ; % m/s

theta = atand(cd.*(c.^(-1)));

clc; close all;
% plot the phase lead as a function of ocean depth
figure(1)
plot(h, theta, 'k', 'LineWidth',2)
xlim([0 7000])
ylim([0 90])
grid on

% set font size & axis labels
set(gca, 'FontSize', 16);
ylabel(['Phase Lead [Degrees]'])
xlabel('Ocean Depth [m]');
title('sigma_o = 3.2 S/m')

%% 