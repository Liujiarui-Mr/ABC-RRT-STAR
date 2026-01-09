function statisticalResult = abcRrtStar( mapPath, rngSeed, pStart, pGoal, maxIterations, stepSize, conThr, ss1, ss2 )
% function name:                              abcRrtStar
% function objective£º                        conduct abcRrtStar algorithm
% function input:
%     mapPath:                                map path
%     rngSeed:                                set random seed for a fair comparison 
%     pStart:                                 start point (e.g. [1 1])
%     pGoal:                                  goal point (e.g. [1100 800])
%     maxIterations:                          maximum number of iterations
%     stepSize:                               step size for each node
%     conThr:                                 connection radius of two tree
%     ss1:                                    path to save visual planning result 'xxx.fig' file                                                                          
%     ss2:                                    path to save visual planning result 'xxx.png' file                                                                                         
% function return:
%     statisticalResult:                      the struct to store planning result
%         statisticalResult.timeRun:          store time cost
%         statisticalResult.treeNodeNums:     store tree node count                        
%         statisticalResult.pathNodeNums:     store path node count
%         statisticalResult.pathCost:         store path cost
%         statisticalResult.iters:            store iteration count
% 

disp('Function Running !!! ');

rng(rngSeed);                                 % set random seed 
nodeThr           = 3 * stepSize;             % initial optimization radius of S_near
pathNums          = 0;                        % the number of complete paths have been queried
minPathLength     = inf;                      % set initial path cost
pathFindFlag      = false;                    % flag indicating whether the complete path has been found 

% initilize the forward tree
T1.v(1).x                = pStart(1);         % x position 
T1.v(1).y                = pStart(2);         % y position
T1.v(1).index            = 1;                 % the index of this node in forward tree
T1.v(1).preIndex         = 0;                 % the parent index of this node in forward tree
T1.flag                  = 1;                 % the flag indicating the root of the forward tree 
T1.nodeNums              = 1;                 % record the number of tree node in forward tree
T1.connectIndex          = -1;                % record the node index where the connection occurs in the forward tree


% initialize the reverse tree
T2.v(1).x                = pGoal(1);          % x position 
T2.v(1).y                = pGoal(2);          % y position
T2.v(1).index            = 1;                 % the index of this node in reverse tree
T2.v(1).preIndex         = 0;                 % the parent index of this node in reverse tree
T2.flag                  = 2;                 % the flag indicating the root of the reverse tree 
T2.nodeNums              = 1;                 % record the number of tree node in reverse tree
T2.connectIndex          = -1;                % record the node index where the connection occurs in the reverse tree



% Map visualization
figure(1);
map                      = showMap( mapPath );
imshow( map );
hold on;

% Check the feasibility of the start point and the goal point
if( checkParams( map, pStart, pGoal ) )
    disp('the settings of start and goal success !!!');
else
    disp('the settings of start and goal failed ...');
    return;
end

% Visualize the strat point and goal point
plot( pStart(1), pStart(2), 'ro', 'MarkerSize', 10, 'MarkerFaceColor', 'r' );
plot( pGoal(1), pGoal(2), 'go', 'MarkerSize', 10, 'MarkerFaceColor', 'g' );

timeStart                          = tic;
for iters = 1:maxIterations
    
    % uniformly random sampling
    pRand                          = findRandomPoint( map, 0 );
    
    % PPBS sampling
    %pRand                          = findRandomPoint2( map, pStart, pGoal, 0.7, 0.3, 100 );
    %plot( pRand(1), pRand(2), 'go', 'MarkerSize', 3, 'MarkerFaceColor', 'g' );
    
    % find the nearest node in forward tree
    nNearest                       = findNearestNode( T1, pRand );
    
    % generate a new point based on nNearest and pRand
    pNew                           = findSteerPoint(pRand, [nNearest.x, nNearest.y], stepSize);
    
    % check the feasibility of the path from nNearest to pNew
    if ( collisionCheck( map, pNew, [nNearest.x, nNearest.y] ) )
        
        % add the new point pNew to the forward tree 
        [ T1, nNew ]               = addNode( T1, nNearest, pNew );
        
    else
        
        % BDRG is triggered once the node nNearest encounters failed extension
        if (T1.flag == 1)
            pNew                   = findNewPoint(map, pGoal, [nNearest.x, nNearest.y], pNew, stepSize, 8);
        else
            pNew                   = findNewPoint(map, pStart, [nNearest.x, nNearest.y], pNew, stepSize, 8);
        end
        [T1, nNew]                 = addNode( T1, nNearest, pNew );
        
    end
    
    % implementation of FFTO
    nearSet                        = findNearSet(T1, nNew, nodeThr);
    
    ancestorSet                    = findAncestorSet( T1, nNew, nearSet );
    
    totalSet                       = getTotalSet( nearSet, ancestorSet );
    
    [ T1, nParent, nNew ]          = chooseParent( map, T1, nNew, totalSet );
    if ( T1.flag == 1 )
        T1.lineHandle( T1.nodeNums )         = plot( [nParent.x, nNew.x], [nParent.y, nNew.y], 'Color', [0.5 0.5 0.5] );
        T1.pointHandle( T1.nodeNums )        = plot( nNew.x, nNew.y, 'Marker', 'o', 'MarkerSize', 2, 'Color', 'm', 'MarkerFaceColor', 'm' );
    elseif (T1.flag == 2)
        T1.lineHandle( T1.nodeNums )         = plot( [nParent.x, nNew.x], [nParent.y, nNew.y], 'Color', [1 0.6 0] );
        T1.pointHandle( T1.nodeNums )        = plot( nNew.x, nNew.y, 'Marker', 'o', 'MarkerSize', 2, 'Color', [0 0.69 0.94], 'MarkerFaceColor', [0 0.69 0.94] );
    end
    
    
    [ T1, lRewire ]                          = rewireTree(map, T1, nNew, nearSet);
    if ( ~isempty(lRewire) )
        for j = 1:size( lRewire, 1 )
           rewireNode                        = T1.v( lRewire(j) );
           newNode                           = T1.v( rewireNode.preIndex );
           delete( T1.lineHandle(lRewire(j)) ); 
           if (T1.flag == 1)
               T1.lineHandle( lRewire(j) )   = plot( [newNode.x,rewireNode.x], [newNode.y, rewireNode.y], 'Color', [0.5 0.5 0.5] );  %[0.5 0.5 0.5]
           elseif(T1.flag == 2)
               T1.lineHandle( lRewire(j) )   = plot( [newNode.x,rewireNode.x], [newNode.y, rewireNode.y], 'Color', [1 0.6 0] );       %[1 0.6 0]
           end 
        end
    end
    
    
    % implementation of RTCR
    nNearestPia                              = findNearestNode(T2, [nNew.x, nNew.y]);
    nTempNearPia                             = nNearestPia;
    if ( (computeDistance( [nNearestPia.x, nNearestPia.y], [nNew.x, nNew.y] ) <= conThr) && (collisionCheck(map, [nNew.x, nNew.y], [nNearestPia.x, nNearestPia.y])) )
        
        pathFindFlag                         = true;
        T1.connectIndex                      = nNew.index;
        T2.connectIndex                      = nNearestPia.index;
        
    else
       
        while(1)
            pNewPia                                = findSteerPoint( [nNew.x, nNew.y], [nTempNearPia.x, nTempNearPia.y], stepSize );
            if ( nTempNearPia.preIndex ~= 0 )
                if ( collisionCheck( map, pNewPia, [T2.v(nTempNearPia.preIndex).x, T2.v(nTempNearPia.preIndex).y] ) )
                    nParentPia                    = T2.v( nTempNearPia.preIndex );
                else
                    if ( collisionCheck( map, pNewPia, [nTempNearPia.x, nTempNearPia.y] ) )
                        nParentPia                = nTempNearPia;
                    else
                        break;
                    end
                end
            else
                if ( collisionCheck( map, pNewPia, [nTempNearPia.x, nTempNearPia.y] ) )
                    nParentPia                    = nNearestPia;
                else
                    break;
                end
            end
            
            [ T2, nNewPia ]                       = addNode(T2, nParentPia, pNewPia);
            if (T2.flag == 2)
                T2.lineHandle(T2.nodeNums)        = plot( [nParentPia.x, nNewPia.x], [nParentPia.y, nNewPia.y], 'Color', [1 0.6 0] );
                T2.pointHandle(T2.nodeNums)       = plot( nNewPia.x, nNewPia.y, 'Marker', 'o', 'MarkerSize', 2, 'Color', [0 0.69 0.94], 'MarkerFaceColor', [0 0.69 0.94] );
            elseif(T2.flag == 1)
                T2.lineHandle(T2.nodeNums)        = plot( [nParentPia.x, nNewPia.x], [nParentPia.y, nNewPia.y], 'Color', [0.5 0.5 0.5] );
                T2.pointHandle(T2.nodeNums)       = plot( nNewPia.x, nNewPia.y, 'Marker', 'o', 'MarkerSize', 2, 'Color', 'm', 'MarkerFaceColor', 'm' );
            end
            
            nTempNode                             = findNearestNode( T1, [nNewPia.x, nNewPia.y] );
            if ( (computeDistance( [nTempNode.x, nTempNode.y], [nNewPia.x, nNewPia.y] ) <= conThr) && ( collisionCheck( map, [nNewPia.x, nNewPia.y], [nTempNode.x, nTempNode.y] ) ) )
                pathFindFlag                      = true;
                T1.connectIndex                   = nTempNode.index;
                T2.connectIndex                   = nNewPia.index;
                break;
            end
            nTempNearPia                          = nNewPia;           
            %pause(0.02);
        end
        
    end
    
    if ( pathFindFlag )
        %extract two path in two trees respectively
        path1                                    = extractPath( T1 );
        path2                                    = extractPath( T2 );
        pathOriginal                             = getPath( path1, path2 );
        
        % determine whether update the path 
        if ( pathOriginal.cost < minPathLength )
            % record metrics
            statisticalResult.timeRun               = toc( timeStart );                   
            statisticalResult.treeNodeNums          = size(T1.v, 2) + size(T2.v, 2);       
            statisticalResult.iters                 = iters;                               
            minPathLength                        = pathOriginal.cost;
            
            % path visualization
            if ( pathNums == 0 )
                pathOriginalHandle               = showPath(pathOriginal, 'g', 2);
            else
                delete(pathOriginalHandle);
                pathOriginalHandle               = showPath(pathOriginal, 'g', 2);
            end
            
            % hybrid path pruning
            pathPrune                            = hybridPruning(map, pathOriginal);
            pathPrune.cost                       = computePathCost(pathPrune);
            if ( pathNums == 0 )
                pathPruningHandle                = showPath( pathPrune, 'b', 2 );
            else
                delete(pathPruningHandle);
                pathPruningHandle                = showPath( pathPrune, 'b', 2 );
            end
            
            % update the path cost and path nodes
            statisticalResult.pathCost           = pathPrune.cost;
            statisticalResult.pathNodeNums       = size( pathPrune.pose, 2 );
            
            % implementation of OASP
            pathSmooth                           = pathSmoothing(map, pathPrune);
            pathSmooth.cost                      = computePathCost(pathSmooth);
            if ( pathNums == 0 )
                pathSmoothingHandle              = showPath( pathSmooth, 'r', 2 );
            else
                delete(pathSmoothingHandle);
                pathSmoothingHandle              = showPath( pathSmooth, 'r', 2 );
            end
            
            % save the planning result
            if ( pathNums == 0 )
                saveas( gcf, strcat( ss1, '_', num2str(statisticalResult.timeRun), '.png' ) );
                saveas( gcf, strcat( ss2, '_', num2str(statisticalResult.timeRun), '.fig' ) );
                return;
            end
            
            % update the number of path
            pathNums                             = pathNums + 1;
            
        end
    end
    
    % swap the bidirectional trees conditionally    
    if ( size(T1.v, 2) > size(T2.v, 2) )
        [ T1, T2 ]                               = swapTree(T1, T2);                
    end
    
    %pause(0.01);
end


end


