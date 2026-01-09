function [ tree, lRewire ]   = rewireTree( mapLoad, tree, nNode, nearSet )
%
% function name:      rewireTree
% function objective: rewire path connection for points in S_near
% function input:
%     mapLoad:        map matrix
%     tree:           tree structure
%     node:           node being checked
%     nearSet: the struct storing points in S_near
%         nearSet(i).x:        x position
%         nearSet(i).y:        y position
%         nearSet(i).index:     index of this point in tree
%         nearSet(i).value:    the sum of path cost of current point in S_near and its distace to node
% function output:
%    tree:             updated tree structure 
%    rewireIndexList:  list storing the node index with updated path connection relation ship  
% 


lRewire                        = zeros(0, 1);
rewireCount                    = 1;

if ( ~isempty(nearSet) )
    nParent                                                 = tree.v( nNode.preIndex );
    cParent                                                 = computeNodeCost(tree, nParent.index);
    cNode                                                   = computeNodeCost( tree, nNode.index );
    for i=1:size(nearSet, 2)
        nCurNear                                            = tree.v( nearSet(i).index );
        cTemp                                               = cParent + computeDistance( [ nCurNear.x, nCurNear.y ], [ nParent.x, nParent.y ] );
        if (  (cTemp - computeNodeCost(tree, nCurNear.index)) < -1e-4  )
            if ( collisionCheck( mapLoad, [ nCurNear.x, nCurNear.y ], [ nParent.x, nParent.y ] ) )
                tree.v( nCurNear.index ).preIndex           = nParent.index;
                lRewire( rewireCount, 1 )                   = nCurNear.index;
                rewireCount                                 = rewireCount + 1;
            else
                cTemp                                       = cNode + computeDistance( [ nCurNear.x, nCurNear.y ], [ nNode.x, nNode.y ] );
                if ( (cTemp - computeNodeCost(tree, nCurNear.index)) <-1e-4 )
                    if ( collisionCheck( mapLoad, [ nCurNear.x, nCurNear.y ], [ nNode.x, nNode.y ] ) )
                        tree.v( nCurNear.index ).preIndex   = nNode.index;
                        lRewire( rewireCount, 1 )           = nCurNear.index;
                        rewireCount                         = rewireCount + 1;
                    end
                end
            end
        end
    end
 
    lRewire = unique( lRewire, 'rows', 'stable' );
end


end





