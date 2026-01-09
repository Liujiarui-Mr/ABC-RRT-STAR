function path = pathSmoothing( mapLoad, pathPose )
% 
%function name:           pathSmoothing
%function objective:      OASP for dynamic path smoothing
%function input:
%   mapLoad:              map matrix
%   pathPose:             complete path
%function output:
%   path:                 smoothed path     
% 


% covert to matrix form to accelerate comupation speed
pathMar      = zeros( size(pathPose.pose, 2), 2 );
for i = 1:size( pathMar, 1 )
    pathMar( i, 1 )    = pathPose.pose(i).x;
    pathMar( i, 2 )    = pathPose.pose(i).y;

end


% path processing when the number of nodes dose not meet the order configuration of the B-spline curve 
pathMarProcess         = pathProcess(pathMar); 


% implementation of the cubic-B-spline parameterization method
pathTemp               = bSpline(mapLoad, pathMarProcess, 4);



for i=1:size( pathTemp, 1 )
    path.pose(i).x         = pathTemp( i, 1 );
    path.pose(i).y         = pathTemp( i, 2 );
end




end