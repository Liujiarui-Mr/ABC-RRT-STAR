function [ tempPath1, tempPath2 ] = pathSplit( mapLoad, path, point )
%
% function name:               pathSplit
% function objective:          split the path when collision occurs during smoothing
% function input:
%     mapLoad:                 load the map matrix for point check 
%     path:                    the input path
%     point:                   the point where the collision occurs
% function output:
%     path1:                   the first path segment 
%     path2:                   the second path segment 
% 


splitFlag               = false;
for i=1:(size(path, 1)-1)
    detaX1              = path(i, 1)   - point(1);
    detaX2              = path(i+1, 1) - point(1);
    detaY1              = path(i,2)    - point(2);
    detaY2              = path(i+1, 2) - point(2);
    if ( (detaX1 * detaX2 < 0) || (detaY1 * detaY2 < 0) )
        index           = i;
        splitFlag       = true;
        break;
    end
end


if ( splitFlag )
    newControlPoint     = [ (path(index, 1) + path(index+1, 1))/2, (path(index, 2) + path(index+1, 2))/2 ];
    if ( ( checkPoint(mapLoad,ceil(newControlPoint)) && checkPoint(mapLoad, floor(newControlPoint)) && ...
            checkPoint(mapLoad, [ceil(newControlPoint(1)), floor(newControlPoint(2))]) && checkPoint(mapLoad, [floor(newControlPoint(1)), ceil(newControlPoint(2))]) ) )
        tempPath1           = [path(1:index,:);newControlPoint];
        tempPath2           = [newControlPoint; path(index+1:end,:)];
    else
        while (1)
            randNo              = rand();
            newControlPoint     = [ path(index, 1) + randNo * (path(index+1, 1) - path(index, 1)), path(index, 2) + randNo * (path(index+1, 2) - path(index, 2)) ];
            if ( ( checkPoint(mapLoad,ceil(newControlPoint)) && checkPoint(mapLoad, floor(newControlPoint)) && ...
                checkPoint(mapLoad, [ceil(newControlPoint(1)), floor(newControlPoint(2))]) && checkPoint(mapLoad, [floor(newControlPoint(1)), ceil(newControlPoint(2))]) ) )
                tempPath1           = [path(1:index,:);newControlPoint];
                tempPath2           = [newControlPoint; path(index+1:end,:)];
                break;
            end
        end
    end
    
end

end
