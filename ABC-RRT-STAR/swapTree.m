function [ tempTree2, tempTree1 ] = swapTree( tree1, tree2 )
% 
% function name:          swapTree 
% function objective:     swap the bidireional trees
% function  input:
%     tree1:              the forward tree
%     tree2:              the reverse tree
% function output:
%     tempTree2:          the copy of the reverse tree
%     tempTree1:          the copy of the forward tree
%

tempTree2.v              = tree2.v;
tempTree2.nodeNums       = tree2.nodeNums;
tempTree2.lineHandle     = tree2.lineHandle;
tempTree2.pointHandle    = tree2.pointHandle;
tempTree2.flag           = tree2.flag;
tempTree2.connectIndex   = tree2.connectIndex;

tempTree1.v              = tree1.v;
tempTree1.nodeNums       = tree1.nodeNums;
tempTree1.lineHandle     = tree1.lineHandle;
tempTree1.pointHandle    = tree1.pointHandle;
tempTree1.flag           = tree1.flag;
tempTree1.connectIndex   = tree1.connectIndex;

end