function [J, grad] = costFunctionReg(theta, X, y, lambda)
    m = length(y); 
    J = 0;
    grad = zeros(size(theta));

    h = sigmoid(X*theta);
    theta_bias=[0;theta(2:end)];
    J = (1/m) * sum(-y.*log(h)-(1-y).*log(1-h)) + (lambda/(2*m))*(theta_bias'*theta_bias);
    grad = (1/m) * ((h-y)'*X)' + (lambda/m)*theta_bias;
end
