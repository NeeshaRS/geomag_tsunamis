%% Clear and set initial parameters
clc; clear all; close all;

addpath matlab_datafiles/mat_files/
addpath matlab_datafiles/csv_files/
addpath('../tsunami_library')

%% API water data file
for i=1
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
end
%% API magnetic field data file
for i=1
    % load .mat magnetic field data file
    load api_2022-01-15_zh.mat
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,apiZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,apiH, fname);
    display('H magnetic field data csv saved.')
end
%% ASP magnetic field data file
for i=1
    station= 'asp';
    stationC= 'ASP';
    % load .mat magnetic field data file
    load asp_2022-01-15_zh.mat
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,aspZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,aspH, fname);
    display('H magnetic field data csv saved.')
end
%% CBI water data file
for i=1
    % load .mat water data file
    load CBI_water_levels.mat
    station= 'cbi';
    stationC= 'CBI';
    
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_water_levels_m_raw.csv',...
        station)
    [fid] = F_woTimeData(time,height_m, fname);
    display('water data csv saved.')
end
%% CBI magnetic field data file
for i=1
    % load .mat magnetic field data file
    load cbi_2022-01-15_zh.mat
    station= 'cbi';
    stationC= 'CBI';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,cbiZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,cbiH, fname);
    display('H magnetic field data csv saved.')
end
%% CNB magnetic field data file
for i=1
    % load .mat magnetic field data file
    load cnb_2022-01-15_zh.mat
    station= 'cnb';
    stationC= 'CNB';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,cnbZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,cnbH, fname);
    display('H magnetic field data csv saved.')
end
%% CTA magnetic field data file
for i=1
    % load .mat magnetic field data file
    load cta_2022-01-15_zh.mat
    station= 'cta';
    stationC= 'CTA';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,ctaZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,ctaH, fname);
    display('H magnetic field data csv saved.')
end
%% EYR magnetic field data file
for i=1
    % load .mat magnetic field data file
    load eyr_2022-01-15_zh.mat
    station= 'eyr';
    stationC= 'EYR';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,eyrZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,eyrH, fname);
    display('H magnetic field data csv saved.')
end
%% HON magnetic field data file
for i=1
    % load .mat magnetic field data file
    load hon_2022-01-15_zh.mat
    station= 'hon';
    stationC= 'HON';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,honZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,honH, fname);
    display('H magnetic field data csv saved.')
end
%% HON water data file
for i=1
    % load .mat water data file
    load HON_water_levels_m.mat
    station= 'hon';
    stationC= 'HON';
    
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_water_levels_m_raw.csv',...
        station)
    [fid] = F_woTimeData(time,height_m, fname);
    display('water data csv saved.')
end
%% IPM magnetic field data file
for i=1
    % load .mat magnetic field data file
    load ipm_2022-01-15_zh.mat
    station= 'ipm';
    stationC= 'IPM';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,ipmZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,ipmH, fname);
    display('H magnetic field data csv saved.')
end
%% IPM water data file
for i=1
    % load .mat water data file
    load IPM_water_levels_m.mat
    station= 'ipm';
    stationC= 'IPM';
    
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_water_levels_m_raw.csv',...
        station)
    [fid] = F_woTimeData(time,height_m, fname);
    display('water data csv saved.')
end
%% KAK magnetic field data file
for i=1
    % load .mat magnetic field data file
    load kak_2022-01-15_zh.mat
    station= 'kak';
    stationC= 'KAK';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,kakZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,kakH, fname);
    display('H magnetic field data csv saved.')
end
%% KNY magnetic field data file
for i=1
    % load .mat magnetic field data file
    load kny_2022-01-15_zh.mat
    station= 'kny';
    stationC= 'KNY';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,knyZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,knyH, fname);
    display('H magnetic field data csv saved.')
end
%% MMB magnetic field data file
for i=1
    % load .mat magnetic field data file
    load mmb_2022-01-15_zh.mat
    station= 'mmb';
    stationC= 'MMB';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,mmbZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,mmbH, fname);
    display('H magnetic field data csv saved.')
end
%% PPT magnetic field data file
for i=1
    % load .mat magnetic field data file
    load ppt_2022-01-15_zh.mat
    station= 'ppt';
    stationC= 'PPT';
    
    % write out the Z data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_Z_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,pptZ, fname);
    display('Z magnetic field data csv saved.')
    
    % write out the H data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_magnetic_field_nT_H_raw.csv',...
        station)
    [fid] = F_woTimeData(time_min,pptH, fname);
    display('H magnetic field data csv saved.')
end
%% PPT water data file
for i=1
    % load .mat water data file
    load PPT_water_levels_m.mat
    station= 'ppt';
    stationC= 'PPT';
    
    % write out the water level data
    fname = ...
        sprintf('matlab_datafiles/csv_files/%s_water_levels_m_raw.csv',...
        station)
    [fid] = F_woTimeData(time,height_m, fname);
    display('water data csv saved.')
end