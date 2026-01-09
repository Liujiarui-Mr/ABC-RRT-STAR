function newPoint = findSteerPoint( point2, point1, stepSize )
% 
% function name:           findSteerPoint
% function objective:      attemp to generate a new point along the direction from point1 to point2
% function input:
%     point2:              destination point
%     point1:              source point 
%     stepSize:            step size 
% function output£º
%     newPoint:            the newly generated point
%

growAngle    = atan2( point2(2)-point1(2), point2(1)-point1(1) );
newPoint     = [ point1(1) + stepSize * cos(growAngle), point1(2) + stepSize * sin(growAngle) ];


end