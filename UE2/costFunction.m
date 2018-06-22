function f = costFunction(p,X,y)
    f = 0;
    %   Compute cost using Cross-Entropy Error

    m = length(y); % number of training example

    f = 1/m * ( -y' * log(sigmoid(X*p)) - (1-y)' * log(1 - sigmoid(X*p)));
end
        
