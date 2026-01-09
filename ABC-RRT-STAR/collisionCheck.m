function pathCollisionFlag = collisionCheck(mapLoad, point2, point1)
% 
% function name:          collisionCheck
% function objective:     check the feasibility of the path from point1 to point2 
% function input:
%     mapLoad:             map matrix地图矩阵 黑色（障碍物）为0 白色（自由空间）255
%     point2:              destination point
%     point1:              source point
% function output:
%     pathCollisionFlag:   flag indicating the feasibility of the path, returns true if the path lies in the free space
%

pathCollisionFlag = true;
growthAngle = atan2( point2(2) - point1(2), point2(1) - point1(1) );
distCheck   = computeDistance( point1, point2 );

% check the feasibility of the destination point
if( ~( checkPoint(mapLoad,ceil(point2) ) && checkPoint(mapLoad, floor(point2)) &&...
    checkPoint(mapLoad, [ceil(point2(1)), floor(point2(2))]) && checkPoint(mapLoad, [floor(point2(1)), ceil(point2(2))]) ) )  

    pathCollisionFlag = false;
    return;
    
end


% check the feasiblity of the path from point1 to point2
for step = 0.1:0.1:distCheck          
    
    tempPose = point1 + step * [cos(growthAngle), sin(growthAngle)];
    
    if( ~( checkPoint(mapLoad, ceil(tempPose)) && checkPoint(mapLoad, floor(tempPose)) &&...
        checkPoint(mapLoad, [ceil(tempPose(1)), floor(tempPose(2))]) && checkPoint(mapLoad, [floor(tempPose(1)), ceil(tempPose(2))]) ) )  
        pathCollisionFlag = false;
        break;
    end
    
end

end





