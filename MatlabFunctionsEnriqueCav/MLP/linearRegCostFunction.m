function [J, grad] = linearRegCostFunction(X, y, theta, lambda)

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

k=1;
n = size(X, 1);
X = X';
grad(k,1) = -1*((1/m).*sum((h-y).*X(:,1)))  ;
    k=2;
while (k>=2 && k<=n)    
    grad(k,1) =  -1*( ((1/m).*sum((h-y).*X(:,k))) + ((lambda/m).*theta(k,:)))   ;
    k=k+1;
end



















end
