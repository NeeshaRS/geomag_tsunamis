%% Clear and set initial parameters
clc; clear all; close all;

addpath matlab_datafiles/mat_files/
addpath matlab_datafiles/csv_files/
addpath('../tsunami_library')

%% API water data file
% load .mat water data file
load API_water_levels_m.mat
station= 'api';
stationC= 'API';
    
% write out the water level data
fname = ...
    sprintf('matlab_datafiles/csv_files/%s_water_levels_m_raw.csv',...
    station)
[fid] = F_woTimeData(time,height_m, fname);
display('water data csv saved.')

%% API magnetic field data file
% load .mat magnetic field data file
load api_2022-01-15_zh.mat

% write out the Z data
fname = ...
    sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
    station)
[fid] = F_woTimeData(time_min,apiZ, fname);
display('Z magnetic field data csv saved.')

% write out the Z data
fname = ...
    sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
    station)
[fid] = F_woTimeData(time_min,apiH, fname);
display('H magnetic field data csv saved.')