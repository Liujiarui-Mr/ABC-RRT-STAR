function nearNode = findNearestNode( tree, point )
%
% function name:          findNearestNode
% function objective:     find the nearest node to specific point in specific tree
% function input:
%   tree:                 tree structure
%   point:                the random point 
% function out put:
%   nearNode£º            the nearest node in tree to  point    
%
%

nearNode                 = tree.v(1);
minDist                  = computeDistance( [nearNode.x, nearNode.y], point );

for i = 1:size( tree.v, 2 )
    tempNode             = tree.v(i);
    tempDist             = computeDistance( [tempNode.x, tempNode.y], point );
    if ( tempDist < minDist )
        minDist          = tempDist;
        nearNode         = tree.v(i);
    end
end


end