%% Clear parameters and set basics
clc; clear all; close all;

addpath matlab_datafiles/
%% API
for i=1
    close all
    load API_water_levels_m.mat
    load api_2022-01-15_zh.mat
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % try detrending
    apiH_d= detrend(apiH); %, 4
    apiZ_d= detrend(apiZ);

    F_waterB_plot(time,height_m, time_min2, apiZ_d, 'api_wb_Zd.png')
    F_waterB_plot(time,height_m, time_min2, apiH_d, 'api_wb_Hd.png')

end

%% HON
for i=1
    close all
    load HON_water_levels_m.mat
    load hon_2022-01-15_zh.mat

    % try detrending
    honH_d= detrend(honH); %, 4
    honZ_d= detrend(honZ);
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    F_waterB_plot(time,height_m, time_min2, honZ_d, 'hon_wb_Zd.png')
    F_waterB_plot(time,height_m, time_min2, honH_d, 'hon_wb_Hd.png')
end

%% IPM
for i=1
    close all
    load IPM_water_levels_m.mat
    load ipm_2022-01-15_zh.mat
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    F_waterB_plot(time,height_m, time_min2, ipmZ, 'ipm_wb_Z.png')
    F_waterB_plot(time,height_m, time_min2, ipmH, 'ipm_wb_H.png')

end
%% PPT
for i=1
    close all
    load PPT_water_levels_m.mat
    load ppt_2022-01-15_zh.mat
    time_min2= datetime(time_min, 'ConvertFrom','datenum');

    % try detrending
    pptH_d= detrend(pptH); %, 4
    pptZ_d= detrend(pptZ);

    F_waterB_plot(time,height_m, time_min2, pptZ_d, 'ppt_wb_Zd.png')
    F_waterB_plot(time,height_m, time_min2, pptH_d, 'ppt_wb_Hd.png')

end