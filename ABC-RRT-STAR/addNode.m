function [ tree, newNode ]     = addNode( tree, nearNode, newPoint )
%
% function name:           addNode
% function objective:      add the new point to the tree
% function input:
%     tree:                tree structure
%     nearNode£º           the parent node of the new point
%     newPoint£º           the new point need to be added in the tree
% function output:
%     tree:                the updated tree
%     newNode:             the new node in the tree correspoinding to above new point
% 

tree.nodeNums             = tree.nodeNums + 1;
index                     = tree.nodeNums;

tree.v(index).x           = newPoint(1);
tree.v(index).y           = newPoint(2);
tree.v(index).index       = index;
tree.v(index).preIndex    = nearNode.index;

newNode                   = tree.v( index );


end