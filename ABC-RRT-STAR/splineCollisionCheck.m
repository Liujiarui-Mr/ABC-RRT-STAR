function [collisionFlag, collisionPoint] = splineCollisionCheck( mapLoad, point2, path )
%
%function name:              splineCollisionCheck
%function objective:         determine the feasibility of the spline curve 
%function input:
%   mapLoad:                 map matrix
%   point2:                  point being checked
%   path:                    the smoothed path being genrated
%function output:
%   collisionFlag:           flag indicating whether collision occurs during the smoothing
%   collisionPoint:          point where the collision occurs        
% 
% 

collisionFlag               = true;
collisionPoint              = [];

if (~isempty(path))
    point1                      = path(end,:);
    dist                        = computeDistance( point1, point2 );
    if ( dist <=1 ) 
        if( ~( checkPoint(mapLoad,ceil(point2)) && checkPoint(mapLoad, floor(point2)) && ...
            checkPoint(mapLoad, [ceil(point2(1)), floor(point2(2))]) && checkPoint(mapLoad, [floor(point2(1)), ceil(point2(2))]) ) )
            collisionFlag       = false;
            collisionPoint      = point2;
        end
    else
        angle                   = atan2( point2(2)-point1(2), point2(1)-point1(1) );
        for step = 0:0.1:dist
            tempPose            = point1 + step * [ cos(angle), sin(angle) ];
            if( ~( checkPoint(mapLoad, ceil(tempPose)) && checkPoint(mapLoad, floor(tempPose)) && ...
                   checkPoint(mapLoad, [ceil(tempPose(1)), floor(tempPose(2))]) && checkPoint(mapLoad, [floor(tempPose(1)), ceil(tempPose(2))]) ) )

                collisionFlag   = false;
                collisionPoint  = tempPose;
                break;
            end
        end
    end

end

end