function path = getPath(  path1, path2 )
% 
% function name:          getPath
% function objective:     merge two path into a complete feasible path
% function input:
%     path1:              path extracted in forward tree
%     path2:              path extracted in reverse tree
% function output£º
%     path£º              final complete feasible path
% 

if ( path1.flag == 1 )
    
    % the forward tree is tooted at the start point
    tempLength1          = size( path1.pose, 2 );
    nodeNo1              = tempLength1;
    for i = 1:tempLength1
        tempPath1.pose( i ).x    = path1.pose( nodeNo1 ).x;
        tempPath1.pose( i ).y    = path1.pose( nodeNo1 ).y;
        nodeNo1                  = nodeNo1 - 1;
    end
    tempPath1.cost               = path1.cost;
    tempPath1.flag               = path1.flag;
    
    % merge two path
    path.pose                    = [tempPath1.pose, path2.pose];
    path.cost                    = tempPath1.cost + path2.cost + computeDistance( [path1.pose(1).x, path1.pose(1).y], [path2.pose(1).x, path2.pose(1).y] );
    
elseif (path1.flag == 2)
    
    % the forward tree is rooted at the gaol point
    tempLength2          = size( path2.pose, 2 );
    nodeNo2              = tempLength2;
    for i = 1:tempLength2
        tempPath2.pose( i ).x    = path2.pose( nodeNo2 ).x;
        tempPath2.pose( i ).y    = path2.pose( nodeNo2 ).y;
        nodeNo2                  = nodeNo2 - 1;
    end
    tempPath2.cost               = path2.cost;
    tempPath2.flag               = path2.flag;
    
    % merge two path
    path.pose                    = [ tempPath2.pose, path1.pose ];
    path.cost                    = path1.cost + tempPath2.cost + computeDistance( [path1.pose(1).x, path1.pose(1).y], [path2.pose(1).x, path2.pose(1).y] );
    
end


end




