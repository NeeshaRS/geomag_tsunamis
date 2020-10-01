% Create Cross wavelet spectra for CBI station
% during Tohuku (2011-03-11) EQ
% for dates 2011-03-01 to 2011-03-20

clc; clear all;
%% read CBI data

fname = 'cbi_march_2011.txt';
CBI = read_iaga2002_1min(fname);

fname = 'mmb_2011_march.txt';
MMB = read_iaga2002_1min(fname);

load CBIeta.mat
%% Analize. CBI = local and MMB = remote 


local_fday = CBI.MINUTELY(:,1)';
local_h =  sqrt(CBI.MINUTELY(:,2).^2+ CBI.MINUTELY(:,3).^2)';    
local_z =  CBI.MINUTELY(:,4)'; 

remote_fday = MMB.MINUTELY(:,1)';
remote_h =  sqrt(MMB.MINUTELY(:,2).^2+ MMB.MINUTELY(:,3).^2)';    
remote_z =  MMB.MINUTELY(:,4)';

%% Butterworth filtering
maxperiod=1*60*30; % 0.5 hour is the max period
dt= 60; % The sample rate of one per minute
w = dt*2.0/maxperiod;
n = 7;
[B, A] = butter(n,w,'high');

local_z_hpf = filtfilt(B,A,local_z);
local_h_hpf = filtfilt(B,A,local_h);
remote_z_hpf = filtfilt(B,A,remote_z);
remote_h_hpf = filtfilt(B,A,remote_h);

%% Spline filtering

%b1 = min(local_fday):(1/24):max(local_fday);

% b1 = min(local_fday):(2/24):max(local_fday);
% sp=spline(b1,local_h/spline(b1,eye(length(b1)),local_fday));
% local_h_hpf=local_h-ppval(local_fday,sp);
% %clear local_h;
% 
% sp=spline(b1,local_z/spline(b1,eye(length(b1)),local_fday));
% local_z_hpf=local_z-ppval(local_fday,sp);
% %clear local_z;
% 
% 
% sp=spline(b1,remote_h/spline(b1,eye(length(b1)),remote_fday));
% remote_h_hpf=remote_h-ppval(remote_fday,sp);
% %clear remote_h;
% 
% sp=spline(b1,remote_z/spline(b1,eye(length(b1)),local_fday));
% remote_z_hpf=remote_z-ppval(local_fday,sp);
%clear remote_z;
disp('high pass filtered')
%% Plot high pass filter-- CBI
h1=figure(1); set(h1,'Position',[100 100 1100 400],'PaperPositionMode','auto');
b(1) = datenum(2011,3,11,0,0,0);
b(2) = datenum(2011,3,12,0,0,0);

subplot(121); 
plot(local_fday,local_h_hpf); ylabel('H (nT)'); xlabel('Time (March 11, 2011)')
set(gca,'FontSize',16,'LineWidth',2); 
xlim([b(1) b(end)]); ylim([-6 6]); 
set(gca,'XTickLabel',{'3/11 00:00','3/11 06:00','3/11 12:00','3/11 18:00','3/12 00:00'},...
    'XTick',[734573 734573.25 734573.5 734573.75 734574])
line([CBIeta CBIeta],[-10 15],'Color',[1 0 0]); 

subplot(122);
plot(local_fday,local_z_hpf); ylabel('Z (nT)'); xlabel('Time (March 11, 2011)')
set(gca,'FontSize',16,'LineWidth',2); 
xlim([b(1) b(end)]); ylim([-1.5 1.5]);
set(gca,'XTickLabel',{'3/11 00:00','3/11 06:00','3/11 12:00','3/11 18:00','3/12 00:00'},...
    'XTick',[734573 734573.25 734573.5 734573.75 734574])
line([CBIeta CBIeta],[-3 2],'Color',[1 0 0]); 

print -dpng HPF_CBI_11_Japan.png
print -deps HPF_CBI_11_Japan.eps

%% wavelet analysis 
% waven = 'morl';
waven = 'cgau4';

perdiod_in_minutes = [1:60];
Sc = scal2frq(1./(fliplr(perdiod_in_minutes)*60),waven,60);

perd = 1./scal2frq(Sc,waven,60); % 60 seconds DELTA intrvl

remotezw = cwt(remote_z_hpf,Sc,waven);%Complex wavelet transfor
%clear remote_z_hpf;

localzw = cwt(local_z_hpf,Sc,waven);%Complex wavelet transform
%clear local_z_hpf;

localhw = cwt(local_h_hpf,Sc,waven);%Complex wavelet transform
%clear local_h_hpf;

remotehw = cwt(remote_h_hpf,Sc,waven);%Complex wavelet transformf
%clear remote_h_hpf;

Hxy = localhw .* conj(remotehw);
L = abs(Hxy) > 100;
Hxy(L) = 100;
ss = sqrt(abs(Hxy));

cc = max(max(ss)) - abs(ss);
weight = (cc./max(max(cc)));
%clear cc ss L localhw remotehw ;

imagesc(local_fday,perd/60,(abs(localzw).*weight));
caxis([0,3]);
disp('CWA done')
%% plot

f = figure;
colormap(jet);
set(f,'Position',[ 34         562        1876         489]);
% b(1) = min(local_fday);
% b(2) = max(local_fday);

b(1) = datenum(2011,3,04,0,0,0);
b(2) = datenum(2011,3,19,0,0,0);

ax(1)=subplot(311);
imagesc(local_fday,perd/60,abs(localzw));
set(gca,'FontSize',16);
h=colorbar; caxis([0 3]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);

% datetick;
axis([b(1) b(2) -inf 50]);
text(b(1),7,'Wavelet amplitude of local Z','FontSize', 18,'color','white');
set(gca,'xtick',[]); ylabel('Period (min)');
set(gca,'XTickLabel',{'3/05','3/07','3/09','3/11','3/13','3/15','3/17'},...
    'XTick',[734567 734569 734571 734573 734575 734577 734579])
line([CBIeta  CBIeta ],[0 200],'LineStyle','--','Color',[1 1 1],'LineWidth',1)

ax(2)=subplot(312)
imagesc(local_fday,perd/60,abs(Hxy))
set(gca,'FontSize',16);
% b=axis;
% datetick;
axis([b(1) b(2) -inf 50]);
text(b(1),7,'Cross wavelet amplitude between local H and remote H','FontSize', 18,'color','white');
set(gca,'xtick',[]); ylabel('Period (min)');
h=colorbar; caxis([0 100]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);
set(gca,'XTickLabel',{'3/05','3/07','3/09','3/11','3/13','3/15','3/17'},...
    'XTick',[734567 734569 734571 734573 734575 734577 734579])
line([CBIeta  CBIeta ],[0 200],'LineStyle','--','Color',[1 1 1],'LineWidth',1)

ax(3)=subplot(313)
imagesc(local_fday,perd/60,(abs(localzw).*weight))
set(gca,'FontSize',16);
axis([b(1) b(2) -inf 50]);
text(b(1),7,'Weighted wavelet amplitude of local Z ','FontSize', 18,'color','white');
h=colorbar; caxis([0 3]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',14);
set(gca,'XTickLabel',{'3/05','3/07','3/09','3/11','3/13','3/15','3/17'},...
    'XTick',[734567 734569 734571 734573 734575 734577 734579])
line([CBIeta  CBIeta ],[0 200],'LineStyle','--','Color',[1 1 1],'LineWidth',1)
xlabel('Date in 2011 mm/dd');
ylabel('Period (min)');

print -dpng CWA_CBI-MMB_11_JN.png

%% short time window
figure(2)
colormap(jet);
timeEQ=datenum('03-11-2011 05:46:24.1');
start=datenum('11-Mar-2011 06:30:00'); 
mid1=datenum('11-Mar-2011 07:00:00'); 
mid2=datenum('11-Mar-2011 08:00:00');
mid3=datenum('11-Mar-2011 09:00:00');
endt=datenum('11-Mar-2011 09:30:00');
imagesc(local_fday,perd/60,(abs(localzw).*weight));  set(gca, 'FontSize', 18); 
set(gca,'XTickLabel',{'7:00','8:00', '9:00'},...
    'XTick',[mid1 mid2 mid3])
xlim([start endt]); ylim([-inf 50]); 
% line([timeEQ timeEQ],[0 400],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
line([CBIeta  CBIeta ],[0 50],'LineStyle','--','Color',[1 1 1],'LineWidth',2)
 % text(.15,2,'CBI Z Weighted-Wavelet Amplitudes', 'FontSize', 18,'Color',[0 0 0]);
h=colorbar; caxis([0 3]); set(h,'fontsize',14); set(get(h,'ylabel'),'string','nT','fontsize',18);
xlabel('Time (3/11/2011)'); ylabel('Period (min)'); 

print -dpng CWA_CBI-MMB_11_JN_zoom.png