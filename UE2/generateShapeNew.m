function [shape] = generateShapeNew( meanshape, EVecs, p )

    b = p(1:end-4); %die Werte vor den translation x, trans y, rotation, skalierung

    rotation=p(end-3); 
    skalierung=p(end-2); 
    transx=p(end-1); 
    transy=p(end);
           

    shape=EVecs*b + meanshape;  %create normal shape
    
    xvals = shape(1:64,1);
    yvals = shape(65:end,1);
    

    
    vecshape = horzcat( xvals+transx, yvals+transy ); %verwandle in array von vektoren ( x, y )' und translation
    
    
    %Rotationsmatrix mit Skalierung erstellen...Rotation gegen
    %Uhrzeigersinn um Winkel: rotation
    rotskalmatrix = [(  cos(rotation)*skalierung ), (-sin(rotation)*skalierung) ;
                     (  sin(rotation)*skalierung ), ( cos(rotation)*skalierung) ];
    
                    
    %shape = reshape( 

    
    for j = 1 : 64
       vecshape(j,:) = vecshape(j,:)*rotskalmatrix;
    end
    
    shape = horzcat( vecshape(:,1)', vecshape(:,2)' ); %Plot shape braucht horizontales "array"
    
 
%     plotShape( meanshape, shape );
    
    
end