function path = globalReverseTraversalPruning( mapLoad, pathPose )
% 
% function name:          globalReverseTraversalPruning
% function objective:     Glocal-focused pruning
% function input:
%     mapLoad:            map matrix
%     pathPose:           the complete path
% function output£º
%     pathPrune:          the pruned path
% 

startNode         = pathPose.pose(1);
length            = size(pathPose.pose, 2);
k                 = length;
path.pose(1)      = startNode;
flag              = false;
while ( ~flag )
    endNode       = pathPose.pose(k);
    if ( collisionCheck(mapLoad, [endNode.x, endNode.y], [startNode.x, startNode.y]) || collisionCheck(mapLoad, [startNode.x, startNode.y], [endNode.x, endNode.y]) )
        if ( k==length )
            path.pose   = [path.pose, endNode];
            flag        = true;
        else
            startNode       = pathPose.pose(k);
            path.pose       = [ path.pose, startNode ];
            k               = length;
        end
    else
        k               = k - 1;
    end
end


end