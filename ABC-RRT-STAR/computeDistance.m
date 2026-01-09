function distance = computeDistance( p1, p2 )
%function name:         computeDistance
%function objective:    compute the distance between p1 and p2
%function input:
%   p1:                 point 1 
%   p2:                 point 2
%function output:
%   distance:           distance value between p1 and p2
%

distance = sqrt( (p2(2)-p1(2))^2 + (p2(1)-p1(1))^2 );

end