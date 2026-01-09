function randomPoint = findRandomPoint( mapLoad, sampleObstacle )
% 
% function name:          findRandomPoint
% function objective:     uniformly extract a random sample in the configuration space 
% function input:
%     mapLoad:            map matrix
%     sampleObstacle:     if sampling obstacle space
%         0:              only sample the free space           
%         1:              sample both the obstacle space and the free space
% function output:
%     randomPoint£º       random sample returned 
%

[mapHeight, mapWidth] = size(mapLoad);
if( sampleObstacle == 1 )
    randomPoint = rand(1, 2).*[mapWidth, mapHeight];
else
    while(1)
        randomPoint = rand(1,2).* [mapWidth, mapHeight];
        if( checkPoint(mapLoad, ceil(randomPoint)) && checkPoint(mapLoad, floor(randomPoint)) &&...
            checkPoint(mapLoad, [ceil(randomPoint(1)), floor(randomPoint(2))]) && checkPoint(mapLoad, [floor(randomPoint(1)), ceil(randomPoint(2))]) ) 
            break;
        end
    end
end


end