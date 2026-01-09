function costValue = computeNodeCost( tree, nodeIndex )
% 
% function name:        computeNodeCost
% function objective:   compute the path cost of specific node based on its index  
% function input:
%     tree:            tree structure
%     nodeIndex:       the index of the node
% function output:
%     costValue:        the path cost of node being queried
% 

index             = nodeIndex;
costValue         = 0;

while( index ~= 1 )
    
    nCur          = tree.v( index );
    nPar          = tree.v( nCur.preIndex );
    costValue     = costValue + computeDistance( [nCur.x, nCur.y], [nPar.x, nPar.y] );
    index         = nPar.index;
    
end


end


