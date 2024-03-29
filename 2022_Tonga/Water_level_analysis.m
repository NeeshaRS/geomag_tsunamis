%% Clear parameters and set basics
clc; clear all; close all;

addpath matlab_datafiles/mat_files/
addpath matlab_datafiles/csv_files/
addpath('../tsunami_library')

% for high or band pass filter
T=120; % max period for names
maxT= 60*120; % max period in minutes
minT= 60*15; % min period in minutes
dt= 60; % The sample rate of one per minute
n=7;

disp('initial parameters set')
%% API- HPF
for i=1
    close all
    station= 'api';
    stationC= 'API';

    % load water level data
    load API_water_levels_m.mat
    load api_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    fname = ...
        sprintf('figures/%s/water_level_analysis/%s_water_levels.png',...
        stationC, station)
    F_water_plot(time,height_m, fname)
    
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/%s_water_levels_m_hpf_T%imin.csv',...
        station, T)
    [fid] = F_woTimeData(time,height_m_hpf, fname);

    % plot water level vs raw magnetic field data
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_whpf_Z_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_hpf, time_min2, apiZ, figname)
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_whpf_H_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_hpf, time_min2, apiH,figname)

    % high pass filter magnetic data
    apiZ_hpf = F_HPF(maxT, dt, n, apiZ);
    apiH_hpf = F_HPF(maxT, dt, n, apiH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/water_level_analysis/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, apiZ_hpf, apiH_hpf,...
        figname)

end

%% API- BPF
for i=1
    close all
    station= 'api2';
    stationC= 'API';

    % load water level data
    load API_2_water_levels_m.mat
    load api_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    fname = ...
        sprintf('figures/%s/water_level_analysis/%s_water_levels.png',...
        stationC, station)
    F_water_plot(time,height_m, fname)
    
    % high pass filter water level data
    height_m_bpf = F_BPF(minT, maxT, dt, n, height_m');
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/%s_water_levels_m_bpf_T%imin.csv',...
        station, T)
    [fid] = F_woTimeData(time,height_m_bpf, fname);

    % plot water level vs raw magnetic field data
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_wbpf_Z_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_bpf, time_min2, apiZ, figname)
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_wbpf_H_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_bpf, time_min2, apiH,figname)

    % high pass filter magnetic data
    apiZ_bpf = F_BPF(minT, maxT, dt, n, apiZ);
    apiH_bpf = F_BPF(minT, maxT, dt, n, apiH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/water_level_analysis/%s_wbpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_bpf, time_min2, apiZ_bpf, apiH_bpf,...
        figname)

end
%% CBI
for i=1
    close all
    station= 'cbi';
    stationC= 'CBI';

    % load water level data
    load CBI_water_levels.mat
    load cbi_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    day1= datetime(2022,01,15);
    day2= datetime(2022,01,16);

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    height_m= height_m(time >= day1 & time < day2);
    time= time(time >= day1 & time < day2);
    fname = ...
        sprintf('figures/%s/water_level_analysis/%s_water_levels.png',...
        stationC, station)
    F_water_plot(time,height_m, fname)
 
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/%s_water_levels_m_hpf_T%imin.csv',...
        station, T)
    [fid] = F_woTimeData(time,height_m_hpf, fname);

    % plot water level vs raw magnetic field data
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_whpf_Z_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_hpf, time_min2, cbiZ, figname)
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_whpf_H_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_hpf, time_min2, cbiH, figname)

    % high pass filter magnetic data
    cbiZ_hpf = F_HPF(maxT, dt, n, cbiZ);
    cbiH_hpf = F_HPF(maxT, dt, n, cbiH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/water_level_analysis/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, cbiZ_hpf, cbiH_hpf,...
        figname)
end

%% CTA
for i=1
    close all
    station= 'cta';
    stationC= 'CTA';
    
    % load water level data
    load API_water_levels_m.mat
    load cta_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % high pass filter magnetic data
    ctaZ_hpf = F_HPF(maxT, dt, n, ctaZ);
    ctaH_hpf = F_HPF(maxT, dt, n, ctaH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, ctaZ_hpf, ctaH_hpf,...
        figname)

end

%% CNB
for i=1
    close all
    station= 'cnb';
    stationC= 'CNB';
    
    % load water level data
    load API_water_levels_m.mat
    load cnb_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % high pass filter magnetic data
    cnbZ_hpf = F_HPF(maxT, dt, n, cnbZ);
    cnbH_hpf = F_HPF(maxT, dt, n, cnbH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, cnbZ_hpf, cnbH_hpf,...
        figname)

end

%% EYR
for i=1
    close all
    station= 'eyr';
    stationC= 'EYR';
    
    % load water level data
    load API_water_levels_m.mat
    load eyr_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % high pass filter magnetic data
    eyrZ_hpf = F_HPF(maxT, dt, n, eyrZ);
    eyrH_hpf = F_HPF(maxT, dt, n, eyrH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, eyrZ_hpf, eyrH_hpf,...
        figname)

end

%% KAK
for i=1
    close all
    station= 'kak';
    stationC= 'KAK';

    % load water level data
    load CBI_water_levels.mat
    load kak_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    day1= datetime(2022,01,15);
    day2= datetime(2022,01,16);

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    height_m= height_m(time >= day1 & time < day2);
    time= time(time >= day1 & time < day2);
 
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');

    % high pass filter magnetic data
    kakZ_hpf = F_HPF(maxT, dt, n, kakZ);
    kakH_hpf = F_HPF(maxT, dt, n, kakH);
    
    % plot water level vs raw magnetic field data
    figname= sprintf(...
        'figures/%s/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, kakZ_hpf, kakH_hpf,...
        figname)
end
%% HON
for i=1
    close all
    station= 'hon';
    stationC= 'HON';
    % load water level data
    load HON_water_levels_m.mat
    load hon_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    fname = ...
        sprintf('figures/%s/water_level_analysis/%s_water_levels.png',...
        stationC, station)
    F_water_plot(time,height_m, fname)
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    [fid] = F_woTimeData(time,height_m_hpf, ...
        'matlab_datafiles/hon_water_levels_m_hpf_T120min.csv');

     % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, honZ, ...
        'figures/HON/water_level_analysis/hon_whpf_Z_120min.png')
    F_waterB_plot(time,height_m_hpf, time_min2, honH, ...
        'figures/HON/water_level_analysis/hon_whpf_H_120min.png')

    % high pass filter magnetic data
    honZ_hpf = F_HPF(maxT, dt, n, honZ);
    honH_hpf = F_HPF(maxT, dt, n, honH);
    
   % plot water level vs HPF magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, honZ_hpf, honH_hpf,...
        'figures/HON/water_level_analysis/hon_whpf_Bhpf_120min.png')
end

%% IPM
for i=1
    close all
    station= 'ipm';
    stationC= 'IPM';

    % load water level data
    load IPM_water_levels_m.mat
    load ipm_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    fname = ...
        sprintf('figures/%s/water_level_analysis/%s_water_levels.png',...
        stationC, station)
    F_water_plot(time,height_m, fname)
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/%s_water_levels_m_hpf_T%imin.csv',...
        station, T)
    [fid] = F_woTimeData(time,height_m_hpf, fname);
    
    % plot water level vs raw magnetic field data
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_whpf_Z_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_hpf, time_min2, ipmZ, figname)
    figname = ...
        sprintf('figures/%s/water_level_analysis/%s_whpf_H_%imin.png', ...
        stationC, station, T)
    F_waterB_plot(time,height_m_hpf, time_min2, ipmH, figname)
    
    % high pass filter magnetic data
    ipmZ_hpf = F_HPF(maxT, dt, n, ipmZ);
    ipmH_hpf = F_HPF(maxT, dt, n, ipmH);
    
   % plot water level vs HPF magnetic field data
   figname= sprintf(...
        'figures/%s/water_level_analysis/%s_whpf_Bhpf_%imin.png', ...
        stationC, station, T)
    F_waterB_3plot(time,height_m_hpf, time_min2, ipmZ_hpf, ipmH_hpf,...
        figname)
end

%% PPT
for i=1
    close all
    station= 'ppt';
    stationC= 'PPT';
    % load water level data
    load PPT_water_levels_m.mat
    load ppt_2022-01-15_zh.mat
    % convert time array to matlab datetime
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % remove NaNs from water level data
    height_m= height_m(~isnan(height_m))';
    time= time(~isnan(height_m));
    fname = ...
        sprintf('figures/%s/water_level_analysis/%s_water_levels.png',...
        stationC, station)
    F_water_plot(time,height_m, fname)
    % high pass filter water level data
    height_m_hpf = F_HPF(maxT, dt, n, height_m');
    % write out the water level data
    [fid] = F_woTimeData(time,height_m_hpf, ...
        'matlab_datafiles/ppt_water_levels_m_hpf_T120min.csv');

    % plot water level vs raw magnetic field data
    F_waterB_plot(time,height_m_hpf, time_min2, pptZ, ...
        'figures/PPT/water_level_analysis/ppt_whpf_Z_120min.png')
    F_waterB_plot(time,height_m_hpf, time_min2, pptH, ...
        'figures/PPT/water_level_analysis/ppt_whpf_H_120min.png')
    
    % high pass filter magnetic data
    pptZ_hpf = F_HPF(maxT, dt, n, pptZ);
    pptH_hpf = F_HPF(maxT, dt, n, pptH);
    
   % plot water level vs HPF magnetic field data
    F_waterB_3plot(time,height_m_hpf, time_min2, pptZ_hpf, pptH_hpf,...
        'figures/PPT/water_level_analysis/ppt_whpf_Bhpf_120min.png')
end