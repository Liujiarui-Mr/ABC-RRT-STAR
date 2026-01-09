function pathHandle = showPath( path, lineColor, lineWidth )
% 
% function name:          showPath
% function objective:     visualize the complete path
% function input:
%     path:               the complete path
%     lineColor:          set the color of the path
%     lineWidth:          set the path width
% function output:
%     pathHandle:         path handle
%

for i =1:(size( path.pose, 2 )-1)
    
    pathHandle(i)    = plot( [path.pose(i).x, path.pose(i+1).x], [path.pose(i).y, path.pose(i+1).y], lineColor, 'LineWidth', lineWidth );
    
end


end