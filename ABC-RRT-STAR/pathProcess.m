function path = pathProcess( pathTemp )
%
% function name:          pathProcess
% function objective:     path processing through interpolation when the number of nodes does not meet the order configuration of B-spline curve  
% function input:
%   pathTemp:             path before processing 
% function out put:
%   path:                 path after process through interpolation    
%
%


path                           = [];
count                          = 1;
switch ( size(pathTemp, 1) )
    case 2
        path(count, 1)         = pathTemp(1, 1);
        path(count, 2)         = pathTemp(1, 2);
        count                  = count + 1;
        for i=1:size( pathTemp, 1 )
            path(count, 1)     = pathTemp(1, 1) + (i/3) * ( pathTemp(end, 1) - pathTemp(1, 1) );
            path(count, 2)     = pathTemp(1, 2) + (i/3) * ( pathTemp(end, 2) - pathTemp(1, 2) );
            count              = count + 1;
        end
        path(count, 1)         = pathTemp(end, 1);
        path(count, 2)         = pathTemp(end, 2);
    case 3
        path(count, 1)         = pathTemp(1, 1);
        path(count, 2)         = pathTemp(1, 2);
        count                  = count + 1;
        for i = 1:( size(pathTemp, 1)-1 )
            path(count, 1)     = pathTemp(i, 1) + 0.5 * ( pathTemp(i+1, 1) - pathTemp(i, 1) );
            path(count, 2)     = pathTemp(i, 2) + 0.5 * ( pathTemp(i+1, 2) - pathTemp(i, 2) );
            count              = count + 1;
            path(count, 1)     = pathTemp(i+1, 1);
            path(count, 2)     = pathTemp(i+1, 2);
            count              = count + 1;
        end
    otherwise
        path                  = pathTemp;
end


end