function [outputArg1,outputArg2] = F_waterB_3plot(t_w,data_w, t_b, data_bz, data_bh, fname)
%F_waterB_plot Plot with two y axes comparing the water sea level height
%data (m) and the magnetic field data (nT).
%
% INPUTS:
%   t_w-
%       datetime array for the water height data
%   data_w-
%       array of the water height data [m]
%   t_b-
%       datetime array for the magnetic field data
%   data_bz-
%       array of the magnetic field Z component data [nT]
%   data_bh-
%       array of the magnetic field H component data [nT]
%   fname-
%       string of the name for saving the plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wbplot= figure()
set(wbplot,'Position',[100 100 1100 1100],'PaperPositionMode','auto');

subplot(311)
plot(t_w, data_w,'k'); hold on
set(gca, 'FontSize', 16);
datetick('x');
xlabel('Time (hr:mm UTC)')
ylabel('wave height variation (m)')

subplot(312)
plot(t_b, data_bz,'k')
set(gca, 'FontSize', 16);
datetick('x');
xlabel('Time (hr:mm UTC)')
ylabel('Z magnetic field (nT)')

subplot(313)
plot(t_b, data_bh,'k')
set(gca, 'FontSize', 16);
datetick('x');
xlabel('Time (hr:mm UTC)')
ylabel('H magnetic field (nT)')

saveas(wbplot,fname)

end