function pRand = findRandomPoint2( mapLoad, pStart, pGoal, pipeBiasProb, scaling, maxPipeDistance )
%
% function name:           findRandomPoint2
% function objective:      PPBS (perform biased sampling near the pipeline through gaussian distribution) 
% function input:
%     mapLoad:             map matrix
%     pStart:              the start point
%     pGoal:               the goal point computed by PCM pipeline detection device
%     biasProb:            bias probability for pipeline-biased sampling
%     scaling:             sacling factor of gaussian distribution
%     maxPipeDistance:     the max distance between the random sample and the pipeline 
%function output:
%     pRand£º              random point computed by PPBS
% 
%

if ( rand() <= pipeBiasProb )
    
    % sampling near the pipeline 
    dist                           = computeDistance( pStart, pGoal );
    angle                          = atan2( pGoal(2)-pStart(2), pGoal(1)-pStart(1) );
    sigma                          = scaling * maxPipeDistance;
    while (1)
        randNum                    = rand();
        pBase                      = [ pStart(1) + randNum*dist*cos(angle), pStart(2) + randNum*dist*sin(angle) ];
        %plot( pBase(1), pBase(2), 'bo', 'MarkerSize', 3, 'MarkerFaceColor', 'b' );
        randAngle                  = 2*pi*rand();
        pRand                      = pBase + sigma * randn()*[cos(randAngle), sin(randAngle)];
        %plot( pRand(1), pRand(2), 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r' );
        if( checkPoint(mapLoad, ceil(pRand)) && checkPoint(mapLoad, floor(pRand)) &&...
            checkPoint(mapLoad, [ceil(pRand(1)), floor(pRand(2))]) && checkPoint(mapLoad, [floor(pRand(1)), ceil(pRand(2))]) ) 
            %plot( pRand(1), pRand(2), 'ro', 'MarkerSize', 3, 'MarkerFaceColor', 'r' );
            break;
        end
        %pause(0.02);
    end
    
else
    
    % uniformly radnom sampling
    [ mapHeight, mapWidth ]        = size(mapLoad);
    while (1)
        pRand                      = rand(1, 2).*[ mapWidth, mapHeight ];
        if( checkPoint(mapLoad, ceil(pRand)) && checkPoint(mapLoad, floor(pRand)) &&...
            checkPoint(mapLoad, [ceil(pRand(1)), floor(pRand(2))]) && checkPoint(mapLoad, [floor(pRand(1)), ceil(pRand(2))]) ) 
            break;
        end
    end
    
end




end