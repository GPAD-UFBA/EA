%% =========== Part 1: Loading Data ===================================
load ('C:\Users\Enrique\Documents\8. GPAD\EA\MatlabFunctionsEnriqueCav\BancoUtilizadoeDerivados\LocAdap');
load ('C:\Users\Enrique\Documents\8. GPAD\EA\MatlabFunctionsEnriqueCav\BancoUtilizadoeDerivados\Banco de PeDFs\PeDF_SF');
load ('C:\Users\Enrique\Documents\8. GPAD\EA\MatlabFunctionsEnriqueCav\BancoUtilizadoeDerivados\Banco de PeDFs\AndamentosZapata'); 
[X, Y, X_val, Y_val, X_train, Y_train] = PreProc(PeDF, AndamentoZapata, loc);

%% =========== Part 2: Regularized Linear Regression Cost =============
theta = rand(size(X_train,1),1);
[J, grad] = linearRegCostFunction(X_train, Y_train, theta, 1);

fprintf(['Cost at theta =  %f '], J);
fprintf('Program paused. Press enter to continue.\n');
pause;
fprintf(['Gradient at theta = [%f; %f] '], grad(1), grad(2));  
fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 3: Learning Curve for Linear Regression =============
m = length(Y_train);

lambda = 0;
[error_train, error_val] = ...
    learningCurve(X_train, Y_train, ...
                  X_val, Y_val, ...
                  lambda);

plot(1:m, error_train, 1:m, error_val);
pause;
fprintf('Program paused. Press enter to continue.\n');
title('Learning curve for linear regression')
legend('Train', 'Cross Validation')
xlabel('Number of training examples')
ylabel('Error')
axis([0 13 0 150])

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i)/10000, error_val(i)/10000);
end

fprintf('Program paused. Press enter to continue.\n');
pause;

%% =========== Part 4: Teste =========================================


theta = rand(size(X_train,1),1);
[J, grad] = linearRegCostFunction(X_train, Y_train, theta, 0);
[Y_vali pos] = sort(Y_val);

Y_predition  = (X_val'*grad); 

for i=1:length(pos)
    Y_pred(i) = Y_predition(pos(i));
end
Y_pred = (Y_pred');
plot(Y_pred); hold on;
plot(Y_vali); hold off;







