function [X, Y, X_val, Y_val, X_train, Y_train] = PreProc(PeDF, AndamentoZapata, loc)
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

X_train = X(:,1:350);
Y_train = Y(1:350,:);
X_val = X(:,351:465);
Y_val = Y(351:465,:);

end