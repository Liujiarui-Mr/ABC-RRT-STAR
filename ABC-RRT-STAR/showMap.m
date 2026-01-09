function map = showMap( mapPath )
% 
% function name:          showMap
% function objective:     red map data
% 
% function input:
%     mapPath:            map path
% function output
%     map:                map return for visualization
%

ret = strcmp( mapPath(end-3:end), '.png' );
if( ~ret )
    disp('map read error£ºneed a map with .png format ...');
    return;
end

mapLoad = imread(mapPath);
[~,~,dim] = size(mapLoad);
if( dim==3 )
    map = rgb2gray(mapLoad);
else
    mapLoad(mapLoad == 0)    = 255;
    mapLoad(mapLoad ~= 255)  = 0;
    map = mapLoad;
    
end

end