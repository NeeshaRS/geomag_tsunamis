%% Clear parameters and set basics
clc; clear all;

addpath matlab_datafiles/
%% HON
for i=1
    load HON_water_levels_m.mat
    load hon_2022-01-15_zh.mat

    honH_d= detrend(honH); %, 4
    honZ_d= detrend(honZ);
    time_min2= datetime(time_min, 'ConvertFrom','datenum');
    
    figure()
    yyaxis left
    plot(time, residual, 'k'); hold on
    yyaxis right
    plot(time_min2, honZ_d)
    plot(time_min2, honH_d, '--')
end