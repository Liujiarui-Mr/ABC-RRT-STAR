function nearSet = findNearSet( tree, node, nodeRadius )
%
% function name:         findNearSet
% function objective:    find the a point set (S_near) around specific node 
% function input:
%     tree:              tree structure
%     node:              node being checked 
%     nodeRadius:        radius of S_near
% function output:
%     nearSet: the struct storing points in S_near
%         nearSet(i).x£º        x position
%         nearSet(i).y£º        y position
%         nearSet(i).index:     index of this point in tree
%         nearSet(i).value£º    the sum of path cost of current point in S_near and its distace to node
% 

length               = size( tree.v, 2 );
count                = 1;
nearSet              = struct([]);       
for i = 1:length
    nCurrent         = tree.v(i);
    tempDist         = computeDistance( [nCurrent.x, nCurrent.y], [node.x, node.y] );
    if ( (tempDist <= nodeRadius) && (i~=node.index) )
        nearSet( count ).x        = nCurrent.x;
        nearSet( count ).y        = nCurrent.y;
        nearSet( count ).index    = nCurrent.index;
        nearSet( count ).value    = tempDist + computeNodeCost(tree, nCurrent.index);
        count                     = count + 1;
    end
    
end

end