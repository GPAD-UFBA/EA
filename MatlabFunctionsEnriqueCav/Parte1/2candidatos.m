bancopedfgeneralcell = input ('Entrar banco PeDfs: ');     


ordem=size(bancopedfgeneralcell);
Linha=1;
Coluna=1;
delta=zeros; 
CDP=cell(1,ordem(1,2));

while (Coluna<=ordem(1,2))
Linha=1;
delta=zeros;
    while (Linha<=ordem(1,1))
        bancopedfcell=bancopedfgeneralcell{Linha,Coluna};
        bancopedfs=bancopedfcell(:,1);
    
        L=1;
        l=1;
        n=0;
        posicoes=zeros; 
        ordem2=size(bancopedfcell(:,1));

        for cont=1:ordem2(1,1)-1 
            if (bancopedfs(L,1)==1) %In�cio no valor 1
                n=n+1; 
            elseif(bancopedfs(L,1) > bancopedfs(L+1,1) && bancopedfs(L,1) > bancopedfs(L-1,1)) %Encontrando cada pico
                n=n+1;
                posicoes(l,1)=n; %Matriz de picos
                l=l+1;
            else
                n=n+1;
            end
            L=L+1;
        end

        canddelta=zeros;
        posicoes(l+1,1)=0;
        n=1;
        L=1;
        k=0;

        while (posicoes (L+5,1)>0) 
        %Estudar uma maneira de n�o perder muitas correla��es
                %canddelta cria 5 possibilidades de delta para cada pico
                canddelta(n,1) = posicoes(L+1,1) - posicoes(L,1);
                n=n+1;
                k=k+1;
                canddelta(n,1) = posicoes(L+2,1) - posicoes(L,1);
                n=n+1;
                k=k+1;
                canddelta(n,1) = posicoes(L+3,1) - posicoes(L,1);
                n=n+1;
                k=k+1;
                canddelta(n,1) = posicoes(L+4,1) - posicoes(L,1);
                n=n+1;
                k=k+1;
                canddelta(n,1) = posicoes(L+5,1) - posicoes(L,1);
                n=n+1;
                k=k+1;  
            L=L+1;
        end
        CDP{1,Coluna}{1,Linha}=canddelta(:,:);
        Linha=Linha+1;
    end
    %Repeti��o para todas as colunas de PeDF's
Coluna=Coluna+1;
end