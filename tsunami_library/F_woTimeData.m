function [fid] = F_woTimeData(time_array,data_array, filename)
%F_woTimeData Write out data to a csv file
% INPUTS:
%   time_array-
%      array with the datetimes 
%   data_array-
%       array of the corresponding data
%   filename-
%       location/name of the file to write out to
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% convert datetimes to strings
format= 'yyyy-mm-dd HH:MM:SS'
tstr= zeros(length(time_array), length(format));
for t = 1:length(time_array)
   tstr(t,:) = datestr(time_array(t), format) ; 
end

% Write CSV file
fid = fopen(filename, 'w') ;
for i = 1:length(data_array) % Loop through each time/value row
   fprintf(fid, '%s1,', tstr(i,:)) ; % Print the time string
   fprintf(fid, '%12.3f\n', data_array(i)) ; % Print the data values
end
fclose(fid) ;

disp(['wrote out ' filename '.'])

end