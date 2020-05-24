function [X, Y, X_val, Y_val, X_train, Y_train] = PreProc(PeDF, AndamentoZapata, loc)
%Y = AndamentoZapata./100;
Y = AndamentoZapata;
X=zeros(length(PeDF{1,1}),length(PeDF));
for i=1:465
[maximum pos(i)] = max(loc(i,:));  
L = mod(i,5);
    if (L==0)
        L=5;
    end
X(:,i) = PeDF{L,pos(i)}; 
end

%X = X*10;

X_train = X(1:513,1:350);
Y_train = Y(1:350,:)./100;
%Y_train = Y_train/100;
X_val = X(1:513,351:465);
Y_val = Y(351:465,:)./100;
%Y_val = Y_val/100;

for i=1:length(X_train)
    for cont=1:size(X_train,2);
        if (std(X_train(i,:))==0)
        X_trainn(i,cont) = 1;
        else
        X_trainn(i,cont) = (X_train(i,cont) - mean(X_train(i,:))) /std(X_train(i,:));
        end
    end
end
X_train = X_trainn; 



for i=1:length(X_val)
    for cont=1:size(X_val,2);
        if (std(X_val(i,:))==0)
        X_vall(i,cont) = 1;
        else
        X_vall(i,cont) = (X_val(i,cont) - mean(X_val(i,:))) /std(X_val(i,:));
        end
    end
end
X_val = X_vall; 





end
