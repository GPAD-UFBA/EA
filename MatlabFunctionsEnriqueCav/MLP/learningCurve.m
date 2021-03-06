function [error_train, error_val] = ...
    learningCurve(X_train, Y_train, X_val, Y_val, lambda,num_iters)

m = size(X_train, 2);


for i=1:m
    thetaprov = rand(size(X_train,1),1);
    [J, theta] = linearRegCostFunction(X_train(:,1:i), Y_train(1:i), thetaprov, 0,num_iters);
    [error_train(i)] = linearRegCostFunction(X_train(:,1:i), Y_train(1:i), theta, 0,num_iters);
    [error_val(i)] = linearRegCostFunction(X_val, Y_val, theta, 0,num_iters);
end

 %[theta] = trainLinearReg(X(1:i,:), y(1:i), lambda);

end