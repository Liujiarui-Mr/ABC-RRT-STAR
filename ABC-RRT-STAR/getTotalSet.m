function totalSet    = getTotalSet( nearSet, ancestorSet )
%
% function name:         getTotalSet
% function objective:    merge S_near and S_extend into a point set (S_total) 
% function input:
%     tree:              tree structure
%     nearSet:           S_near
%     ancestorSet:       S_extend
% function output:
%     ancestorSet: the struct storing points in S_total
%         nearSet(i).x£º        x position
%         nearSet(i).y£º        y position
%         nearSet(i).index:     index of this point in tree
%         nearSet(i).value£º    the sum of path cost of current point in S_total and its distace to node
% 


% merge S_near and S_extend into S_total
totalSet                = struct();
totalSet                = [nearSet, ancestorSet];

% remove the dupilicate elements in S_total
func                    = @(data) sprintf( '%s_%s_%s_%s', data.x, data.y, data.index, data.value );
keys                    = arrayfun( func, totalSet, 'UniformOutput', false );
[~, idx1]               = unique(keys, 'stable');
totalSet                = totalSet(idx1);

%sort S_total
[~, idx2]               = sort( [totalSet.value] );
totalSet                = totalSet(idx2);



end