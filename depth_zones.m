clc; clear all; close all;
%% Set initial parameters
% sigma_o = 4; % S/m
sigma_o = 3.2; % S/m
h_obs = 2905; % m
g = 9.81; % m/s^2
mu = 4*pi*10^(-7); % H/m

%% Get background main magnetic field from IGRF
addpath /Users/nesc6259/Library/CloudStorage/OneDrive-UCB-O365/Professional/Data/IGRF/
time = datenum("03-Aug-2019");
latitude = 44.515229 ; % [degrees]
longitude = -125.389891; % [degrees]
altitude = 6371 - 2.9; % [km]
coord = 'geocentric';
[Fx, Fy, Fz] = igrf(time, latitude, longitude, altitude, coord);

%% Get ocean scale length & depth ratio
K = 1/(sigma_o*mu);
L = (2*K/(g^.5))^(2/3) % ocean scale length [m]

depth_ratio = h_obs/L
%% Phase lead as function of ocean depth
for i=1
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
end
%% Phase lead converted to seconds
for i=1
    tsunamiT_30min= 30*60; % [s]
    tsunamiT_10min= 10*60; % [s]

    time_lead_30min = tsunamiT_30min*(theta/360); % [s]
    time_lead_10min = tsunamiT_10min*(theta/360); % [s]

    % plot the phase lead as a function of ocean depth
    figure(2)
    plot(h, time_lead_30min, 'Color', '#331832', 'LineWidth',2)
    hold on
    plot(h, time_lead_10min, 'Color', '#F0544F', 'LineWidth',2)
    xlim([0 7000])

    % fix y labels
    yticks([0 60 120 180 240 300 360 420 480])
    yticklabels({'0', '1', '2', '3', '4', '5', '6', '7', '8'})
    ylim([0 480])

    grid on

    legend('Period of 30 min', 'Period of 10 min')

    % set font size & axis labels
    set(gca, 'FontSize', 16);
    ylabel(['Magnetic Field Lead Time [min]'])
    xlabel('Ocean Depth [m]');
end
%% Amplitude as a function of ocean depth
for i=1
    eta_1m = 1; % [m]
    eta_0p1m = 0.1; % [m]
    bz_1m = eta_1m * c ./(c + i*cd) .* (Fz*(h.^(-1)));
    bz_0p1m = eta_0p1m * c ./(c + i*cd) .* (Fz*(h.^(-1)));

    % plot the induced magnetic field amplitude as a function of ocean depth
    figure(3)
    plot(h, bz_1m, 'Color', '#331832', 'LineWidth',2)
    hold on
    plot(h, bz_0p1m, 'Color', '#F0544F', 'LineWidth',2)
    xlim([0 7000])
    grid on

    legend('Sea surface displace of 1 m', 'Sea surface displace of 0.1 m')

    % set font size & axis labels
    set(gca, 'FontSize', 16);
    ylabel(['Tsunami Magnetic Field b_z [nT]'])
    xlabel('Ocean Depth [m]');

end