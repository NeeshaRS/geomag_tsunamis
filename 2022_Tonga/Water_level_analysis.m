%% Clear parameters and set basics
clc; clear all; close all;

addpath matlab_datafiles/
addpath('../tsunami_library')

% for high pass filter
maxT=1*60*30; %.5 hours is the max period
% maxT=1*60*10; % 10 min is the max period
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
    % write out the water level data
    [fid] = F_woTimeData(time,height_m_hpf, ...
        'matlab_datafiles/api_water_levels_m_hpf_T30min.mat');

    % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, apiZ,...
        'figures/API/water_level_analysis/api_whpf_Z_10min.png')
    F_waterB_plot(time,height_m_hpf, time_min2, apiH,...
        'figures/API/water_level_analysis/api_whpf_H_10min.png')

    % high pass filter magnetic data
    apiZ_hpf = F_HPF(maxT, dt, n, apiZ);
    apiH_hpf = F_HPF(maxT, dt, n, apiH);
    
    % plot water level vs raw magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, apiZ_hpf, apiH_hpf,...
        'figures/API/water_level_analysis/api_whpf_Bhpf_10min.png')

end

%% HON
for i=1
    close all
    % load water level data
    load HON_water_levels_m.mat
    load hon_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    [fid] = F_woTimeData(time,height_m_hpf, ...
        'matlab_datafiles/hon_water_levels_m_hpf_T30min.mat');

     % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, honZ, ...
        'figures/HON/water_level_analysis/hon_whpf_Z_10min.png')
    F_waterB_plot(time,height_m_hpf, time_min2, honH, ...
        'figures/HON/water_level_analysis/hon_whpf_H_10min.png')

    % high pass filter magnetic data
    honZ_hpf = F_HPF(maxT, dt, n, honZ);
    honH_hpf = F_HPF(maxT, dt, n, honH);
    
   % plot water level vs HPF magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, honZ_hpf, honH_hpf,...
        'figures/HON/water_level_analysis/hon_whpf_Bhpf_10min.png')
end

%% IPM
for i=1
    close all
    % load water level data
    load IPM_water_levels_m.mat
    load ipm_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    [fid] = F_woTimeData(time,height_m_hpf, ...
        'matlab_datafiles/ipm_water_levels_m_hpf_T30min.mat');
    
    % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, ipmZ, ...
        'figures/IPM/water_level_analysis/ipm_whpf_Z_10min.png')
    F_waterB_plot(time,height_m_hpf, time_min2, ipmH, ...
        'figures/IPM/water_level_analysis/ipm_whpf_H_10min.png')
    
    % high pass filter magnetic data
    ipmZ_hpf = F_HPF(maxT, dt, n, ipmZ);
    ipmH_hpf = F_HPF(maxT, dt, n, ipmH);
    
   % plot water level vs HPF magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, ipmZ_hpf, ipmH_hpf,...
        'figures/IPM/water_level_analysis/ipm_whpf_Bhpf_10min.png')
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
    % write out the water level data
    [fid] = F_woTimeData(time,height_m_hpf, ...
        'matlab_datafiles/ppt_water_levels_m_hpf_T30min.mat');

    % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, pptZ, ...
        'figures/PPT/water_level_analysis/ppt_whpf_Z_10min.png')
    F_waterB_plot(time,height_m_hpf, time_min2, pptH, ...
        'figures/PPT/water_level_analysis/ppt_whpf_H_10min.png')
    
    % high pass filter magnetic data
    pptZ_hpf = F_HPF(maxT, dt, n, pptZ);
    pptH_hpf = F_HPF(maxT, dt, n, pptH);
    
   % plot water level vs HPF magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, pptZ_hpf, pptH_hpf,...
        'figures/PPT/water_level_analysis/ppt_whpf_Bhpf_10min.png')
end