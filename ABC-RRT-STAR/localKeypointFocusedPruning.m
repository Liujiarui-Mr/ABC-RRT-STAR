function path = localKeypointFocusedPruning( mapLoad, pathPose )
% 
% function name:          localKeypointFocusedPruning
% function objective:     Local-focused pruning
% function input:
%     mapLoad:            map matrix
%     pathPose:           the complete path
% function output£º
%     pathPrune:          the pruned path
% 

k         =1;
path      = pathPose;

while ( k < size(path.pose, 2) - 1 )
    
    node0                 = path.pose(k);
    node2                 = path.pose(k+2);
    if ( collisionCheck(mapLoad, [node2.x, node2.y], [node0.x, node0.y]) )
        path.pose(k+1)    = [];
        if (k>1)
            k             = k - 1;
        end
    else
        k                 = k + 1;
        
    end
    
end



end