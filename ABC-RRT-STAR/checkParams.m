function paramFlag = checkParams( mapLoad, start, goal )
% 
% function name:        checkParams
% function objective:   check the feasibility of the start point and the goal point 
% function input:
%     mapLoad£º         map matrix
%     start£º           start point 
%     tartget£º         goal point
% function output:
%     paramFlag£º       flag indicating the check result, return true if the both start and goal feasible  
%    

paramFlag   = true;

% check start point
if( checkPoint(mapLoad, start) )
    disp('Start point feasible !!!');
else
    disp('Start point failed, the satrt point may exceed the map boundary or be created on the obstacle space ...');
    paramFlag = false;
    return ;
end


% check goal point
if( checkPoint(mapLoad, goal) )
    disp('Goal point feasible !!!');
else
    disp('Goal point failed, the goal point may exceed the map boundary or be created on the obstacle space ...');
    paramFlag = false;
    return ;
end


end