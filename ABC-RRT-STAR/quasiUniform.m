function nodeVectorList = quasiUniform( N, K )
%function name:            quasiUniform
%function objective:       calculate the quasi uniform node vector based on the number of path points N and the defined curve order K
%function input:
%   N:                     number of the control points
%   K:                     the order of the spline curve
%function output£º
%   nodeVectorList:        the quasi uniform node vector


n                  = N-1;
m                  = n+K+1;            
nodeVectorList     = zeros(1, m);
remindNodeNum      = m-2*K;            

if( remindNodeNum == 0 )
    nodeVectorList(1, K+1:end) = 1;
else
    flag           = 1;
    while(flag<=remindNodeNum)
        nodeVectorList(1, K+flag) = nodeVectorList(1, K+flag-1)+ 1/(remindNodeNum+1);   
        flag=flag+1;
    end
    nodeVectorList(1,m-K+1:end) =1;
end


end