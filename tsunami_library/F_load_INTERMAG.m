function [Bx, By, Bz, Bh] = F_load_INTERMAG(station, datapath, timeres, ...
    dtype, year, month, days, num_header)
%F_load_INTERMAG Read data from an INTERMAGNET observatory and save it as
% MATLAB arrays of the X, Y, Z and horizontal magnetic fields.
%
% INPUTS:
%   station-
%       string of the 3 letter station code in lowercase, eg 'kak'
%   datapath-
%       string of the path to the data
%       eg. '../../Data/INTERMAGNET/KAK/provisional/2022/01/'
%   timeres-
%       string of the time resolution. options are 'sec' or 'min'
%   dtype-
%       1 letter string specifying if this is provisional 'p' data or
%       variational 'v' data
%   year-
%       string of the 4 character year. eg '2022'
%   month-
%       string of the 2 character month. eg '01' or '11'
%   days-
%       array of the dates. eg. 15 or 15:16.
%   num_header-
%       number of header lines for the observatory files
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


addpath(datapath)
formatSpec = [station year month '%d' dtype timeres '.' timeres];
daynum= 1;

daymin = 24*60;
daysec = daymin*60;

for n=days
    filename = sprintf(formatSpec,n)
    delimiterIn = ' ';
    A = importdata(filename, delimiterIn, num_header);
    
    if timeres == 'sec'
        sp= 1 + (daynum-1)*daysec;
        ep= daysec + (daynum-1)*daysec;
    elseif timeres == 'min'
        sp= 1+(daynum-1)*daymin;
        ep= daymin+(daynum-1)*daymin;
    end
    daynum= 1 + daynum;

    Bx(sp:ep)=A.data(:,2);
    By(sp:ep)=A.data(:,3);
    Bz(sp:ep)=A.data(:,4);
end
disp('...Vector data read in to matlab arrays.')

Bh = (Bx.^2+By.^2).^.5;
disp('...Horiztonal component made.')

end

