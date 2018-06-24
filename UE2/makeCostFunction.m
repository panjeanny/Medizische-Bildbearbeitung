function f = makeCostFunction(probs, EVecs, meanshape)                 
    f = @costFunction1;
    function c = costFunction1(p)
        
        shape=generateShapeNew(meanshape,EVecs,p);
        shape=reshape(shape,size(shape,2)/2,2);
        shape=round(shape);
        shape(:,1)=shape(:,1)-min(shape(:,1));                             %Anpassung der x-Werte auf neues Koordinatensystem%
        shape(:,2)=shape(:,2)-min(shape(:,2));                             %Anpassung der y-Werte auf neues Koordinatensystem%
        scale(1)=(size(probs,2)-1)/max(shape(:,1));
        scale(2)=(size(probs,1)-1)/max(shape(:,2));
        shape=shape.*repmat(scale,64,1);
        shape=round(shape)+1;
        parameter_shape=zeros(size(probs,1),size(probs,2));
      
        for i=1:64%size(shape,1)
            parameter_shape(shape(i,2),shape(i,1))=1; % Umwandlung von Koordinatensystem auf MAtrix
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