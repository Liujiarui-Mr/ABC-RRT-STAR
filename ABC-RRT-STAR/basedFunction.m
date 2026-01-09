function Bik   = basedFunction( nodeVectorList, K, i, u )
%function name:                   basedFunction
%function objective:              compute the base function for the i-th conrol point 
%function input:
%   nodeVectorList£º              node vector list
%   K:                            order of the spline curve
%   i:                            the i-th control point
%   u:                            variable u
%function output:
%   Bik:                          value of base function for the i-th conrol point



if( K==1 )
    if( u>=nodeVectorList(i) && u<nodeVectorList(i+1) )
        Bik     = 1;
    elseif( u==1 && u>=nodeVectorList(i) && u<=nodeVectorList(i+1)  )
        Bik     = 1;
    else
        Bik     = 0;
    end
else
    
    l1          = nodeVectorList( i+K-1 ) - nodeVectorList( i );
    if( l1 == 0 )
        l1      = 1;
    end
    
    l2          = nodeVectorList( i+K ) - nodeVectorList( i+1 );
    if( l2 == 0 )
        l2      = 1;
    end
    
    Bik         = (u - nodeVectorList(i)) / (l1) * basedFunction( nodeVectorList, K-1, i, u ) + (nodeVectorList(i+K)-u)/(l2) * basedFunction(nodeVectorList, K-1, i+1, u);
        
end


end