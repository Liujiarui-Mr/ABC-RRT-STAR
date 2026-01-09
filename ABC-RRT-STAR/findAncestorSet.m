function ancestorSet  = findAncestorSet( tree, node, nearSet )
%
% function name:         findAncestorSet
% function objective:    find the a point set (S_extend) around specific node based on S_near 
% function input:
%     tree:              tree structure
%     node:              node being checked 
%     nearSet:           S_near
% function output:
%     ancestorSet: the struct storing points in S_extend
%         nearSet(i).x£º        x position
%         nearSet(i).y£º        y position
%         nearSet(i).index:     index of this point in tree
%         nearSet(i).value£º    the sum of path cost of current point in S_extend and its distace to node
% 

if ( ~isempty(nearSet) )
    ancestorSet             = struct('x', {}, 'y', {}, 'index', {}, 'value', {});
    count                   = 1;
    for i=1:size(nearSet, 2)
        curAncIndex         = tree.v( nearSet(i).index ).preIndex;
        if ( curAncIndex ~= 0 )
            curAncNode      = tree.v( curAncIndex );
            tempDist        = computeDistance( [curAncNode.x, curAncNode.y], [node.x, node.y] );
            ancestorSet( count ).x        = curAncNode.x;
            ancestorSet( count ).y        = curAncNode.y;
            ancestorSet( count ).index    = curAncNode.index;
            ancestorSet( count ).value    = tempDist + computeNodeCost( tree, curAncNode.index );
            count                         = count + 1;
        end
    end
    ancestorSet(count:end)                    = [];
    
end

end






