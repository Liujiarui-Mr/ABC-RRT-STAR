function pathPrune = hybridPruning( mapLoad, pathPose )
% 
% function name:          hybridPruning
% function objective:     remove redundant nodes ina single operation
% function input:
%     mapLoad:            map matrix
%     pathPose:           the complete path
% function output£º
%     pathPrune:          the pruned path
% 
% 

tempPath        = localKeypointFocusedPruning(mapLoad, pathPose);
pathPrune       = globalReverseTraversalPruning( mapLoad, tempPath );


end