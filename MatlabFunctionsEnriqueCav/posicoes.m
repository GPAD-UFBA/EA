bancopedfgeneralcell = input ('Entrar banco PeDfs: ');
ordem=size(bancopedfgeneralcell);
Linha=1;
Coluna=1;
delta=zeros; 
PP=cell(1,ordem(1,2));

while (Coluna<=ordem(1,2))
Linha=1;
delta=zeros;
posicao=zeros;
    while (Linha<=ordem(1,1))
        bancopedfcell=bancopedfgeneralcell{Linha,Coluna};
        bancopedfs=bancopedfcell(:,1);
    
        L=1;
        l=1;
        n=0;
        ordem2=size(bancopedfcell(:,1));

            for cont=1:ordem2(1,1)-1
                if (bancopedfs(L,1)==1) %Início no valor 1
                    n=n+1; 
                elseif(bancopedfs(L,1) > bancopedfs(L+1,1) && bancopedfs(L,1) > bancopedfs(L-1,1)) %Encontrando cada pico
                    n=n+1;
                    posicao(l,Linha)=n; %Matriz de picos
                    l=l+1;
                else
                    n=n+1;
                end
                L=L+1;
            end
        %Repetição para todas as resoluções Wavelet
        Linha=Linha+1;
    end
    %Repetição para todas as colunas de PeDF's
PP{1,Coluna}=posicao(:,:);
Coluna=Coluna+1;
end