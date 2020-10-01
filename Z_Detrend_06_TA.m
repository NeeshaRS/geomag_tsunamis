% Neesha Schnepf
% Tonga 2006 tsunami: 5/3/06 15:26:40.2

clc
%% Section 1: Station T13 spline fit
bz=min(tr3):1/(2*24):max(tr3); % the knots
Lz=isnan(Zr13);                  % where Z is a NAN
xz=tr3(~Lz)';                % do not include the time points where Z does not exist

% Spline for the Z component
if length(bz)>1
    % Get the spline coefficient
    spz=spline(bz,Zr13(~Lz)'/spline(bz,eye(length(bz)),xz'));
    % Evaluate the spline
    Vz=ppval(xz,spz);
end

% Plotting Z's spline
figure(1)
hold on
plot(xz,Zr13(~Lz),'k')
plot(xz,Vz, 'r','LineWidth',1)
set(gca,'FontSize',16)
datetick('x',23,'keeplimits','keepticks')
% axis([min(tr3) max(tr3) 2.239*10^4 2.247*10^4])
xlabel('Date')
ylabel('Z Component(nT)')
title('The Z Component of the B Field Compared with the Spline (red) at T13')

% Detrending Z
Zd13=Zr13(~Lz)-Vz';

% Z detrended plot
figure(2)
plot(xz,Zd13,'k')
set(gca,'FontSize',16)
line([T13ETA T13ETA],[-10 15],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
datetick('x',23,'keeplimits','keepticks')
axis([min(tr3) max(tr3) -0.4 0.3])
xlabel('Date')
ylabel('Z Component (nT)')
title('Z Component of the B Field with Spline Removed at T13')

disp('Section 1: Station T13 spline fit--- COMPLETE')

%% Section 2: Station T13 bandpass filter

% High pass filter
dt=60; % in seconds
maxperiod=13*60*60; % in seconds

w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

hout = filtfilt(B,A,Zr13);

figure(3)
hold on
plot(hout,'r')
plot(Zr13,'*')

disp('Section 2: Station T13 bandpass filter--- COMPLETE')
%% Section 3: Fourier/Gaussian fit to filtered data
F = fit(m13,hout,'fourier8')

x=m13;

a0 =   8.355e+04 ;% (8.083e+04, 8.627e+04)
a1 =   1.015e+04 ;% (8911, 1.139e+04)
b1 =  -1.083e+04 ;% (-1.649e+04, -5167)
a2 =       -3359 ;% (-7252, 533.4)
b2 =       -4162 ;% (-5894, -2430)
a3 =       -1314 ;% (-3623, 994.4)
b3 =        2877 ;% (613.8, 5141)
a4 =        1282 ;% (476.3, 2087)
b4 =         269 ;% (-1252, 1790)
a5 =       14.79 ;% (-721.7, 751.3)
b5 =        -476 ;% (-686.1, -265.8)
a6 =      -139.3 ;% (-172.4, -106.2)
b6 =       11.59 ;% (-252.8, 276)
a7 =       5.886 ;% (-60.44, 72.21)
b7 =          29 ;% (24.25, 33.74)
a8 =       2.573 ;% (0.006683, 5.14)
b8 =      -1.276 ;% (-9.449, 6.896)
w =    0.004631 ;% (0.004212, 0.00505)

F13= a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
    a2*cos(2*x.*w) + b2*sin(2*x.*w) + a3*cos(3*x.*w) + b3*sin(3*x.*w) + ...
    a4*cos(4*x.*w) + b4*sin(4*x.*w) + a5*cos(5*x.*w) + b5*sin(5*x.*w) + ...
    a6*cos(6*x.*w) + b6*sin(6*x.*w) + a7*cos(7*x.*w) + b7*sin(7*x.*w) + ...
    a8*cos(8*x.*w) + b8*sin(8*x.*w);

figure(4)
hold on
plot(m13,hout,'*')
plot(m13,F13,'r')

Zf13=hout-F13;
%%
figure(5)
hold on
plot(tr3,Zf13)
line([T13ETA T13ETA],[-4 2],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
datetick('x',23,'keeplimits','keepticks')
axis([min(tr3) max(tr3) -4 2])

disp('Section 3: Fourier/Gaussian fit to filtered data--- COMPLETE')

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MULTIPLE POLYFITS....
clc
p=zeros(5,5);
f=zeros(5,156);
Zd13=Zr13;

for t=1:4
    p(t,:) = polyfit((1:156)',Zr13(1+(t-1)*156:156+(t-1)*156),4);
    f(t,:) = polyval(p(t,:),1:156);
    Zd13(1+(t-1)*156:156+(t-1)*156)= Zr13(1+(t-1)*156:156+(t-1)*156) - f(t,:)';
end

p(5,:) = polyfit((1:155)',Zr13(1+(5-1)*156:end),4);
f(5,1:155) = polyval(p(5,:),1:155);
Zd13(1+(5-1)*156:end)= Zr13(1+(5-1)*156:end) - f(5,1:155)';

figure(5)
plot(tr3,Zd13)
line([T13ETA T13ETA],[-4 2],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
datetick('x',23,'keeplimits','keepticks')
axis([min(tr3) max(tr3) -.1 .15])

%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% MULTIPLE FOURIER/GAUSSIAN FITS....

%% Fit 1
[F1, goodness, output]  = fit((1:156)',Zr13(1:156),'fourier8')
x=1:156;

a0 =   2.244e+04 ;% (2.244e+04, 2.244e+04)
a1 =     -0.9554 ;% (-2.848, 0.9373)
b1 =     -0.5212 ;% (-2.459, 1.416)
a2 =     -0.2251 ;% (-0.5937, 0.1436)
b2 =      0.4907 ;% (-1.766, 2.748)
a3 =      0.2115 ;% (-1.433, 1.856)
b3 =      0.4606 ;% (-0.4947, 1.416)
a4 =      0.3348 ;% (-0.9333, 1.603)
b4 =     0.09432 ;% (-0.3754, 0.5641)
a5 =      0.1996 ;% (-0.1022, 0.5014)
b5 =     -0.1159 ;% (-0.9458, 0.714)
a6 =     0.03972 ;% (-0.2195, 0.2989)
b6 =     -0.1229 ;% (-0.5626, 0.3167)
a7 =    -0.03149 ;% (-0.2675, 0.2046)
b7 =     -0.0532 ;% (-0.08697, -0.01943)
a8 =    -0.02137 ;% (-0.07324, 0.0305)
b8 =   -0.006983 ;% (-0.07238, 0.05841)
w =     0.02931 ;%

F1= a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
    a2*cos(2*x.*w) + b2*sin(2*x.*w) + a3*cos(3*x.*w) + b3*sin(3*x.*w) + ...
    a4*cos(4*x.*w) + b4*sin(4*x.*w) + a5*cos(5*x.*w) + b5*sin(5*x.*w) + ...
    a6*cos(6*x.*w) + b6*sin(6*x.*w) + a7*cos(7*x.*w) + b7*sin(7*x.*w) + ...
    a8*cos(8*x.*w) + b8*sin(8*x.*w);



%% Fit 2
[F2, goodness, output]  = fit((1:156)',Zr13(157:156+156),'fourier8')
x=1:156;
a0 =   2.245e+04 ;% (2.244e+04, 2.245e+04)
a1 =     -0.5068 ;% (-0.8704, -0.1432)
b1 =      0.2031 ;% (-0.6184, 1.025)
a2 =     0.02908 ;% (-0.2638, 0.3219)
b2 =      0.2441 ;% (-0.1414, 0.6296)
a3 =     0.08389 ;% (-0.2359, 0.4036)
b3 =      0.1255 ;% (0.03777, 0.2132)
a4 =     0.05753 ;% (-0.1305, 0.2456)
b4 =     0.03307 ;% (-0.02291, 0.08904)
a5 =     0.04959 ;% (-0.03876, 0.1379)
b5 =   7.813e-05 ;% (-0.1607, 0.1608)
a6 =     0.01737 ;% (-0.06627, 0.101)
b6 =     -0.0231 ;% (-0.09308, 0.04689)
a7 =   4.567e-05 ;% (-0.01688, 0.01698)
b7 =   -0.007692 ;% (-0.0302, 0.01481)
a8 =    0.002222 ;% (-0.005375, 0.00982)
b8 =   -0.003683 ;% (-0.01874, 0.01137)
w =     0.03283 ;% (0.02341, 0.04224)

F2= a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
    a2*cos(2*x.*w) + b2*sin(2*x.*w) + a3*cos(3*x.*w) + b3*sin(3*x.*w) + ...
    a4*cos(4*x.*w) + b4*sin(4*x.*w) + a5*cos(5*x.*w) + b5*sin(5*x.*w) + ...
    a6*cos(6*x.*w) + b6*sin(6*x.*w) + a7*cos(7*x.*w) + b7*sin(7*x.*w) + ...
    a8*cos(8*x.*w) + b8*sin(8*x.*w);

%% Fit 3
[F3, goodness, output]  = fit((1:156)',Zr13(1+156*2:156+156*2),'fourier8')
x=1:156;
a0 =   2.245e+04 ;% (2.244e+04, 2.245e+04)
a1 =      -2.814 ;% (-6.89, 1.262)
b1 =     -0.8815 ;% (-5.752, 3.989)
a2 =     -0.6931 ;% (-2.305, 0.9186)
b2 =       1.388 ;% (-3.819, 6.596)
a3 =      0.8223 ;% (-3.119, 4.763)
b3 =      0.8789 ;% (-0.4058, 2.164)
a4 =      0.8955 ;% (-1.555, 3.346)
b4 =    0.008833 ;% (-1.706, 1.724)
a5 =      0.3529 ;% (0.195, 0.5107)
b5 =     -0.4078 ;% (-2.245, 1.43)
a6 =    -0.05555 ;% (-0.849, 0.7379)
b6 =     -0.3018 ;% (-0.8667, 0.2631)
a7 =     -0.1075 ;% (-0.4978, 0.2827)
b7 =    -0.08227 ;% (-0.2141, 0.04959)
a8 =     -0.0377 ;% (-0.08293, 0.007525)
b8 =   -0.001102 ;% (-0.1095, 0.1073)
w =     0.02909 ;% (0.02453, 0.03365)

F3= a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
    a2*cos(2*x.*w) + b2*sin(2*x.*w) + a3*cos(3*x.*w) + b3*sin(3*x.*w) + ...
    a4*cos(4*x.*w) + b4*sin(4*x.*w) + a5*cos(5*x.*w) + b5*sin(5*x.*w) + ...
    a6*cos(6*x.*w) + b6*sin(6*x.*w) + a7*cos(7*x.*w) + b7*sin(7*x.*w) + ...
    a8*cos(8*x.*w) + b8*sin(8*x.*w);

%% Fit 4
[F4, goodness, output]  = fit((1:156)',Zr13(1+156*3:156+156*3),'gauss8')
x=1:156;
a1 =   2.245e+04 ;% (2.245e+04, 2.245e+04)
b1 =        5.01 ;% (4.702, 5.317)
c1 =        2724 ;% (2607, 2840)
a2 =       28.51 ;% (-137, 194)
b2 =       169.5 ;% (159, 179.9)
c2 =          13 ;% (-29.51, 55.52)
a3 =       10.14 ;% (-138.8, 159.1)
b3 =       155.7 ;% (54.17, 257.2)
c3 =       14.26 ;% (-29.21, 57.74)
a4 =   9.619e+04 ;% (-6.598e+20, 6.598e+20)
b4 =       141.3 ;% (-1.058e+14, 1.058e+14)
c4 =     0.06753 ;% (-4.114e+13, 4.114e+13)
a5 =       15.84 ;% (-10.41, 42.09)
b5 =       146.8 ;% (119.7, 173.9)
c5 =       23.81 ;% (11.55, 36.08)
a6 =     0.03658 ;% (-0.02269, 0.09585)
b6 =       120.5 ;% (119.1, 121.9)
c6 =       1.311 ;% (-1.255, 3.878)
a7 =     0.05131 ;% (-0.004103, 0.1067)
b7 =       114.9 ;% (113.4, 116.4)
c7 =       2.611 ;% (-0.3538, 5.576)
a8 =       18.91 ;% (13.92, 23.9)
b8 =       121.3 ;% (114.6, 128.1)
c8 =       45.94 ;% (41.09, 50.79)

F4= a1.*exp(-((x-b1)./c1).^2) + a2.*exp(-((x-b2)./c2).^2) + ...
              a3.*exp(-((x-b3)./c3).^2) + a4.*exp(-((x-b4)./c4).^2) + ...
              a5.*exp(-((x-b5)./c5).^2) + a6.*exp(-((x-b6)./c6).^2) + ...
              a7.*exp(-((x-b7)./c7).^2) + a8.*exp(-((x-b8)./c8).^2);


%% Fit 5
[F5, goodness, output]  = fit((1:155)',Zr13(1+156*4:end),'fourier8')
x=1:155;
a0 =   2.242e+04 ;% (2.241e+04, 2.243e+04)
a1 =       1.605 ;% (-9.116, 12.33)
b1 =     -0.5613 ;% (-15.38, 14.26)
a2 =       1.172 ;% (-7.641, 9.986)
b2 =       1.876 ;% (-12.8, 16.55)
a3 =       1.793 ;% (-10.77, 14.35)
b3 =     -0.1807 ;% (-0.6886, 0.3273)
a4 =      0.8215 ;% (-3.394, 5.038)
b4 =      -1.113 ;% (-8.89, 6.664)
a5 =     -0.2593 ;% (-3.094, 2.576)
b5 =     -0.8413 ;% (-5.26, 3.578)
a6 =     -0.4523 ;% (-3.103, 2.199)
b6 =     -0.1735 ;% (-0.4262, 0.07932)
a7 =     -0.1942 ;% (-0.554, 0.1656)
b7 =      0.1144 ;% (-0.8488, 1.078)
a8 =    -0.02608 ;% (-0.1186, 0.06649)
b8 =     0.04284 ;% (-0.1749, 0.2606)
w =     0.02741 ;% (0.01994, 0.03489)

F5= a0 + a1.*cos(x.*w) + b1.*sin(x.*w) + ...
    a2*cos(2*x.*w) + b2*sin(2*x.*w) + a3*cos(3*x.*w) + b3*sin(3*x.*w) + ...
    a4*cos(4*x.*w) + b4*sin(4*x.*w) + a5*cos(5*x.*w) + b5*sin(5*x.*w) + ...
    a6*cos(6*x.*w) + b6*sin(6*x.*w) + a7*cos(7*x.*w) + b7*sin(7*x.*w) + ...
    a8*cos(8*x.*w) + b8*sin(8*x.*w);
%%
Zd1=(Zr13(1:156)-F1');
Zd2=Zr13(157:156+156)-F2';
Zd3=Zr13(1+156*2:156+2*156)-F3';
Zd4=Zr13(1+156*3:156+3*156)-F4';
Zd5=Zr13(1+156*4:end)-F5';

%%
Zd13=[Zd1-mean(Zd1); Zd2-mean(Zd2); Zd3-mean(Zd3); Zd4-mean(Zd4); Zd5-mean(Zd5)];

figure(6)
hold on
plot(tr3, Zd13)
line([T13ETA T13ETA],[-.06 .08],'LineStyle','--','Color',[1 0 0],'LineWidth',1)
datetick('x',23,'keeplimits','keepticks')
set(gca,'FontSize',16,'LineWidth',2)
axis([min(tr3) max(tr3) -.06 .08])