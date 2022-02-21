function [wplot] = F_water_plot(t_w,data_w, fname)
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
%   data_b-
%       array of the magnetic field data [nT]
%   fname-
%       string of the name for saving the plot
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
wplot= figure()
set(wplot,'Position',[100 100 1100 600],'PaperPositionMode','auto');

plot(t_w, data_w); hold on
ylabel('wave height variation (m)')
set(gca, 'FontSize', 16);
datetick('x');
xlabel('Time (hr:mm UTC)')

saveas(wplot,fname)

end