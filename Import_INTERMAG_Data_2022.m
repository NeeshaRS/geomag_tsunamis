%% Clear parameters and set basics
clc; clear all;

addpath('tsunami_library')

daymin = 24*60;
daysec = daymin*60;

% time period of interest
time1 = datenum('01-15-2022 00:00:00');
timeE = datenum('01-16-2022 23:59:59');

% build time arrays
time_s = time1:1/daysec:timeE;
time_min = time1:1/daymin:timeE;
disp('Time arrays made.')

% time data for finding data files
year = '2022';
month = '01';
days= 15:16;

%% KAK
station = 'kak';
datapath = '../../Data/INTERMAGNET/KAK/provisional/2022/01/';
timeres = 'min';
dtype = 'p';
num_header = 20;

[Bx, By, Bz, Bh] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header)

addpath 
days= 15:16;
formatSpec = 'kak202201%dpsec.sec';
daynum= 1;

for n=days
    filename = sprintf(formatSpec,n)
    delimiterIn = ' ';
    headerlinesIn = 20;
    A = importdata(filename,delimiterIn,headerlinesIn);
    
    sp=1+(daynum-1)*daysec;
    ep=daysec+(daynum-1)*daysec;
    daynum= 1 + daynum;

    kakX(sp:ep)=A.data(:,2);
    kakY(sp:ep)=A.data(:,3);
    kakZ(sp:ep)=A.data(:,4);
end
disp('KAK data read in to matlab arrays.')

kakH = (kakX.^2+kakY.^2).^.5;
disp('Horiztonal component made')

figure(1)
subplot(211)
plot(time_s, kakZ)

subplot(212)
plot(time_s, kakH)

