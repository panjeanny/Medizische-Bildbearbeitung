function f = makeCostFunction(probs, EVecs, meanshape)                 
    f = @costFunction1;
    function c = costFunction1(p)
        
        shape=generateShapeNew(meanshape,EVecs,p);
        shape=reshape(shape,size(shape,2)/2,2);
%        shape(:,2)=-shape(:,2);
        shaped(:,1)=shape(:,1)-min(shape(:,1));                             %Anpassung der x-Werte auf neues Koordinatensystem%
        shaped(:,2)=shape(:,2)-min(shape(:,2));                             %Anpassung der y-Werte auf neues Koordinatensystem%
        scale(1)=(size(probs,2)-1)/max(shaped(:,1));
        scale(2)=(size(probs,1)-1)/max(shaped(:,2));
        shaped=shaped.*repmat(scale,64,1);
        shaped=round(shaped)+1;
        [m n]=size(probs);
        parameter_shape=zeros(m,n);
      
        for i=1:64%size(shape,1)
            parameter_shape(m+1-shaped(i,2),shaped(i,1))=1; % Umwandlung von Koordinatensystem auf MAtrix
        end
            
        [m n]=size(probs);
        GT=reshape(parameter_shape,m*n,1);
        X=reshape(probs,m*n,1);
        m = length(GT);
        input = X(:)>0;
        %   Compute cost using Cross-Entropy Error
        c = 1/m * ( -GT(input)'* log(sigmoid(X(input))));

    end
end