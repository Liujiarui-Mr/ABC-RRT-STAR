function  finalPath  = bSpline( mapLoad, pathLoad, K )
%function name:         bSpline
%function objective:    implementation of OASP
%function input:
%   pathLoad:           path matrix
%   mapLoad:            map matrix
%   K:                  set the order of the spline curve
%function output:
%   finalPath:         the smoothed path    
% 

k                          = K - 1;                   
N                          = size( pathLoad, 1 );
n                          = N - 1;                   

if ( K > n+1 )
    disp('the order of the spline curve is too high ...');
    return;
end

Bik                        = zeros(N, 1);          
nodeVector                 = quasiUniform(N, K);    
tempPointNums              = size( pathLoad, 1 );
smoothPath                 = [];
path1                      = pathLoad;
path2                      = [];
step                       = 0.05;

% nn                         = 1;

finalPath                  = [];
while (1)
    for u=0:step:1
        for i=1:tempPointNums
            Bik(i, 1)                  = basedFunction( nodeVector, K, i, u );                  
        end
        f                              = [ path1(:,1)'* Bik, path1(:, 2)'*Bik ];                
        [ colliFlag, colliPoint ]      = splineCollisionCheck( mapLoad, f, smoothPath );
%         fHandle(nn)                    = plot( f(1), f(2), 'Marker','o', 'MarkerFaceColor','r' );
%         nn                             = nn + 1;
        if ( colliFlag == 0 )
%             plot( colliPoint(1), colliPoint(2), 'Marker','o', 'MarkerFaceColor','m' );
            [path1, tempPath]          = pathSplit(mapLoad, path1, colliPoint);
            path2                      = [tempPath; path2];
            path1                      = pathProcess(path1);
            tempPointNums              = size(path1, 1);
            Bik                        = zeros(tempPointNums, 1);
            nodeVector                 = quasiUniform(tempPointNums, K);
           
            smoothPath                 = [];
%             delete(fHandle);
%             nn                         =1;
            break;
        else
            smoothPath                 = [smoothPath; f];
        end
%         pause(0.01);
    end
    
    if (colliFlag == true)
        finalPath                      = [finalPath;smoothPath];
        smoothPath                     = [];
        if (isempty(path2))
            break;
        else
            path1                      = path2;
            path2                      = [];
            path1                      = pathProcess(path1);
            tempPointNums              = size(path1, 1);
            Bik                        = zeros(tempPointNums, 1);
            nodeVector                 = quasiUniform(tempPointNums, K);

%             delete(fHandle);
%             nn                         =1;
        end
        
    end
end

finalPath     = unique( finalPath, 'rows', 'stable' );
% plot(finalPath(:,1), finalPath(:,2), 'Color', 'c', 'LineWidth', 3);






end