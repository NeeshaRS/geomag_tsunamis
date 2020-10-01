function[data] = read_iaga2002_1min(fname)

% Read the notes carefully before using the function!!!!

% 

%=============================================

% MATLAB

% read & plot data : IAGA2002 format

% Geomagnetic Data : 1 sample/min.

% May 2011

% Modified the original program downloaded from URL

% http://sc1.cc.kochi-u.ac.jp/~murakami/cgi-bin/FSW/@@@@@

%=============================================

%[date,hms,a,H,D,Z] = textread(fname,'%s %s %f %f %f %f %*f','headerlines',15,'delimiter',' ');

[date,hms,a,D,H,Z] = textread(fname,'%s %s %f %f %f %f %*f','headerlines',20,'delimiter',' ');

%[date,hms,a,H,D,Z] = textread(fname,'%s %s %f %f %f

%%f','headerlines',15,'delimiter',' ');

% Note: The official IAGA format requires HDZF or XYZF, however, some

% observatories (like India - IIG) reports only HDZ.So change the above

% text read accordingly, 

% Note the Kyoto WDC reports data as date,hms,a,D,H,Z,F !!!

%================ (H,D) --> (X,Y)



    %deal with the missing data

    

    D(D==999999.9) = NaN;

    H(H==999999.9) = NaN;

    Z(Z==999999.9) = NaN;



%     A = cell2str(hms);

%     A(end+1) = ' ';

%     nline = length(D);

%     timestring = reshape(A,[13,nline])';

%    

%     hour1 = str2num(timestring(:,1:2));

%     min1 = str2num(timestring(:,4:5));

%       

%     A = cell2str(date);

%     A(end+1) = ' ';

%     nline = length(D);

%     datestring = reshape(A,[11,nline])';

%    

%     year1 = str2num(datestring(:,1:4));

%     month1 = str2num(datestring(:,6:7));

%     day1 = str2num(datestring(:,9:10));





    A = cell2mat(date(1));

    B = cell2mat(hms(1));

    startfday = datenum([A ' ' B(1:6) '30'],31);

    MINUTELY(:,1) = startfday:(1/1440):(startfday + (length(H) - 1) /1440);





    %minutely, first array is matlab time (have follow the INTERMAG.m)      



    X=H.*cos(deg2rad(D/60)); % D is given in decimal arc minutes

    Y=H.*sin(deg2rad(D/60));

    

%     MINUTELY(:,1) = datenum(year1,month1,day1,hour1,min1,30)';

    %

    MINUTELY(:,[2 3]) = [X Y];

    

    MINUTELY(:,4) = Z;

    data = struct('MINUTELY',MINUTELY);







%------------------------------------

