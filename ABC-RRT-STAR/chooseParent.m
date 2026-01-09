function [ tree, nParent, nNode ] = chooseParent( mapLoad, tree, nNode, totalSet )
% 
% function name:         chooseParent
% function objective:    select the most promising parent for specific node in S_total
% function input:
%     mapLoad:           map matrix
%     tree:              tree structure
%     nNode:             node being checked 
%     totalSet:
%         totalSet(i).x£º        x position
%         totalSet(i).y£º        y position 
%         totalSet(i).index:     index of this point in tree
%         totalSet(i).value£º    the sum of path cost of current point in S_total and its distace to node    
% function output:
%         tree£º                 updated tree structure
%         nParent:               the new parent of nNode
%         nNew:                  the updated new node 
%       

nParent                   = tree.v( nNode.preIndex );

if ( ~isempty( totalSet ) )
    for i = 1:size( totalSet, 2 )
        nCurNear          = tree.v( totalSet(i).index );
        tempDist          = totalSet(i).value;
        if ( tempDist < computeNodeCost( tree, nNode.index ) )
            if ( collisionCheck(mapLoad, [nNode.x, nNode.y], [nCurNear.x, nCurNear.y]) )
                tree.v( nNode.index ).preIndex        = nCurNear.index;
                nNode.preIndex                        = nCurNear.index;
                nParent                               = nCurNear;
                break;
            end
        end
    end
end



end





