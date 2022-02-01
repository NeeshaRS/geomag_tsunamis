%% Clear parameters and set basics
clc; clear all; close all;

addpath matlab_datafiles/
addpath('../tsunami_library')

% for high pass filter
maxT=1*60*30; %.5 hours is the max period
dt= 60; % The sample rate of one per minute
n=7;

disp('initial parameters set')
%% API
for i=1
    close all
    % load water level data
    load API_water_levels_m.mat
    load api_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, apiZ,...
        'figures/API/water_level_analysis/api_whpf_Z.png')
    F_waterB_plot(time,height_m_hpf, time_min2, apiH,...
        'figures/API/water_level_analysis/api_whpf_H.png')

    % high pass filter magnetic data
    apiZ_hpf = F_HPF(maxT, dt, n, apiZ);
    apiH_hpf = F_HPF(maxT, dt, n, apiH);
    
    % plot water level vs raw magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, apiZ_hpf, apiH_hpf,...
        'figures/API/water_level_analysis/api_whpf_Bhpf.png')

end

%% HON
for i=1
    close all
    % load water level data
    load HON_water_levels_m.mat
    load hon_2022-01-15_zh.mat
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % try detrending magnetic field
    honH_d= detrend(honH); %, 4
    honZ_d= detrend(honZ);
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    % high pass filter magnetic data
    honZ_hpf = F_HPF(maxT, dt, n, honZ);
    honH_hpf = F_HPF(maxT, dt, n, honH);
    
    % plot water level vs magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, honZ, 'hon_whpf_Z.png')
    F_waterB_plot(time,height_m_hpf, time_min2, honH, 'hon_whpf_H.png')
end

%% IPM
for i=1
    close all
    % load water level data
    load IPM_water_levels_m.mat
    load ipm_2022-01-15_zh.mat
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    
    % plot water level vs magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, ipmZ, 'ipm_whpf_Z.png')
    F_waterB_plot(time,height_m_hpf, time_min2, ipmH, 'ipm_whpf_H.png')

end
%% PPT
for i=1
    close all
    % load water level data
    load PPT_water_levels_m.mat
    load ppt_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % try detrending
    pptH_d= detrend(pptH); %, 4
    pptZ_d= detrend(pptZ);

    F_waterB_plot(time,height_m_hpf, time_min2, pptZ_d, 'ppt_whpf_Z.png')
    F_waterB_plot(time,height_m_hpf, time_min2, pptH_d, 'ppt_whpf_H.png')

end