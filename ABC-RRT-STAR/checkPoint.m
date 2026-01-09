function pointFlag = checkPoint( mapLoad, point )
% 
% function name:          pointCheck
% function objective:     check the feasibility of the specific point
% function input:
%     mapLoad:            map matrix (free space 255, obstacle sapce 0)
%     point£º             point being checked
% function output:
%     pointFlag:          flag indicating the check result, returns true if point within the map boundary and fall in the free space
% 

pointFlag = false;
[mapHeight, mapWidth] = size(mapLoad);

if( point(1)>=1 && point(1)<=mapWidth && point(2)>=1 && point(2)<=mapHeight &&...      % check if point within map boundary 
    mapLoad( point(2), point(1) ) == 255 )                                             % check if point lies in the free space
    pointFlag = true;
end

end