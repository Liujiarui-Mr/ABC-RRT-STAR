function pathCost = computePathCost( path )
% 
% function name:             computePathCost
% function objective:        compute the total cost for the complete path 
% function input:
%     path:                  path input
% function output:
%     pathCost:              total path cost
% 
% 


pathCost        = 0;

for i=1:size(path.pose, 2)-1
    node1           = path.pose(i);
    node2           = path.pose(i+1);
    pathCost        = pathCost + computeDistance( [node1.x, node1.y], [node2.x, node2.y] );
end



end