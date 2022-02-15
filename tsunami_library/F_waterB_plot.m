function [outputArg1,outputArg2] = F_waterB_plot(t_w,data_w, t_b, data_b, fname)
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
wbplot= figure()
set(wbplot,'Position',[100 100 1100 600],'PaperPositionMode','auto');

yyaxis left
plot(t_w, data_w); hold on
ylabel('wave height variation (m)')

yyaxis right
plot(t_b, data_b)
set(gca, 'FontSize', 16);
datetick('x');
xlabel('Time (hr:mm UTC)')
ylabel('magnetic field (nT)')

saveas(wbplot,fname)

end