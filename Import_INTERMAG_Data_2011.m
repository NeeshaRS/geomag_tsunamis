% Load in data from INTERMAGNET station
clc; clear all;

daymin=24*60;
daysec= daymin*60;
%% KAK

days=length(3:19);
kakX=zeros(days*daymin,1);
kakY=zeros(days*daymin,1);
kakZ=zeros(days*daymin,1);
kakH=zeros(days*daymin,1);

day=3
for n=1:16
    if day<10
        formatSpec = 'kak2011030%ddmin.min';
        filename  = sprintf(formatSpec,day);
    elseif day>=10
        formatSpec = 'kak201103%ddmin.min';
        filename  = sprintf(formatSpec,day);
    end
    
    delimiterIn = ' ';
    headerlinesIn = 26;
    A = importdata(filename,delimiterIn,headerlinesIn);
    
    sp=1+(n-1)*1439;
    ep=1439+(n-1)*1439;
    
    kakX(sp:ep,1)=A.data(:,2);
    kakY(sp:ep,1)=A.data(:,3);
    kakZ(sp:ep,1)=A.data(:,4);
    
    day=day+1
end
disp('Done with March 2011 kak data')
% for n=1:7
%     if n<10
%         formatSpec = 'kak2010030%ddmin.min';
%         filename  = sprintf(formatSpec,n);
%     elseif n>=10
%         formatSpec = 'kak200910%ddmin.min';
%         filename  = sprintf(formatSpec,n);
%     end
%     delimiterIn = ' ';
%     headerlinesIn = 26;
%     A = importdata(filename,delimiterIn,headerlinesIn);
%     c=30+n;
%     sp=1+(c-1)*1440;
%     ep=1440+(c-1)*1440;
%     
%     kakX(sp:ep,1)=A.data(:,2);
%     kakY(sp:ep,1)=A.data(:,3);
%     kakZ(sp:ep,1)=A.data(:,4);
% end
% disp('Done with March 2010 kak data')

kakH=(kakX.^2+kakY.^2).^.5;
disp('Horiztonal component made')
%% Figures
figure(1)
plot(kakH)
%% Save data
save kakH_2011_03.mat kakH
save kakZ_2011_03.mat kakZ
disp('saved')

%% Make time data
time1=datenum('03-03-2011 00:00:00');
timeE=datenum('03-19-2011 23:59:00');
daymin=24*60;

time=time1:1/daymin:timeE;
save timekak.mat time