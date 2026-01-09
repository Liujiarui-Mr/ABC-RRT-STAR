function path = extractPath( tree )
% 
% function name:            extractPath
% function objective:       extract the path from specific tree 
% function input:
%     tree:                 tree structure
% function output:          
%     path£º                final path 
% 

nodeIndex                    = tree.connectIndex;
count                        = 1;
while( nodeIndex ~= 0 )
    path.pose( count ).x     = tree.v( nodeIndex ).x;
    path.pose( count ).y     = tree.v( nodeIndex ).y;
    nodeIndex                = tree.v( nodeIndex ).preIndex;
    count                    = count + 1;
end
path.cost                    = computeNodeCost(tree, tree.connectIndex);
path.flag                    = tree.flag;


end



