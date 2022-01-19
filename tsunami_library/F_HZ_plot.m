function [hzplot] = F_HZ_plot(timearray,Harray, Zarray)
%F_rawHZ_plot Plot the station's horizontal and vertical magnetic fields
% (nT).
%   Detailed explanation goes here

hzplot= figure(1)
set(hzplot,'Position',[100 100 1100 600],'PaperPositionMode','auto');

subplot(211)
plot(timearray, Zarray, 'k')
set(gca, 'FontSize', 16); 
datetick('x');
xlabel('Time (hr:mm UTC)')
ylabel('Z field (nT)')

subplot(212)
plot(timearray, Harray, 'k')
set(gca, 'FontSize', 16); 
datetick('x');
xlabel('Time (hr:mm UTC)')
ylabel('H field (nT)')


end