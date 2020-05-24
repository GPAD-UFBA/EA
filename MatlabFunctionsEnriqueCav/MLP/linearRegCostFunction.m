function [J, grad] = linearRegCostFunction(X, y, theta, lambda, num_iters)

m = length(y); % number of training examples

J = 0;
grad = zeros(size(theta));


h = X'*theta;
%h = h';
set=ones(size(theta));
set(1,:)=0;
J = (  (sum((h-y).^2))   ...
    +   (lambda).*(sum((theta.^2).*set)))...
    ./(2*m);


n = size(X, 1);
X = X';

for iter = 1:num_iters
    h = X*grad;
    k=1;
    grad(k,1) = grad(k,1) +( -0.01*((1/m).*sum((h-y).*X(:,1))))  ;
    k=2;
    while (k>=2 && k<=n)    
        grad(k,1) =  grad(k,1) +(  -0.01*( ((1/m).*sum((h-y).*X(:,k))) + ((lambda/m).*grad(k,:))) )  ;
        k=k+1;
    end
end


















end
