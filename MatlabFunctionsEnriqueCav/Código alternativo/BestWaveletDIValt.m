bancopedfgeneralcell = input ('Entrar banco PeDfs: ');
div = input ('Entrar com Divergência a ser utilizada: ');
ordem=size(bancopedfgeneralcell);
Linha=1;
Coluna=1;
delta=zeros; 
bancodeltaspsalt=cell(1,ordem(1,2));


while (Coluna<=ordem(1,2))
Linha=1;
delta=zeros;
media=zeros;
    while (Linha<=ordem(1,1))
        bancopedfcell=bancopedfgeneralcell{Linha,Coluna};
        bancopedfs=bancopedfcell(:,1);
    
        L=1;
        l=1;
        n=0;
        posicoes=zeros; 
        ordem2=size(bancopedfcell(:,1));

        for cont=1:ordem2(1,1)-1 
            if (bancopedfs(L,1)==1) %Início no valor 1
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
        %Estudar uma maneira de não perder muitas correlações
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

        canddelta(n,1)=0;
        canddelta(n+1,1)=0;
        canddelta(n+2,1)=0;
        canddelta(n+3,1)=0;
        canddelta(n+4,1)=0;
        canddelta(n+5,1)=0;
        L=1;

        l=6;
        c=1;
        v=0;
        rcr=zeros;
        while (canddelta(L+5,1)>0)
            while (l>0) 
                if (canddelta(l,1)>0 && l>L) %if (canddelta(l+5,C)>0 && l>L) antes
                    if (canddelta(L,1)==canddelta(l,1))
                        v=v+1;
                    end
                    l=l+5;
                else 
                    if (l<L)
                        if (canddelta(L,1)==canddelta(l,1))
                            v=v+1;
                        end 
                    else
                    l=L;
                    end
                    l=l-5;
                end 
            end
            rcr(L,1)=v; %Cria vetor de recorrência de cada faixa de delta P de 1 a 5 de cada pico
            L=L+1;
            l=L+5; 
            v=0;
        end
        
        mediaparcial=zeros(5,1);
        c=1;
        reset=1;
        %Média Ponderada 
        for cont=1:5
            l=cont;
            while (reset==1)
                if (l>length(rcr))
                    l=cont-5;
                else
                    mediaparcial(cont) = mediaparcial(cont) + ((canddelta(l,c)*rcr(l,c))/length(rcr)); 
                    l=l+5;
                end
                if (l<=0)
                   reset = 0;
                end
            end  
            reset=1;
        end
        
        media(1,Linha)=((sum(mediaparcial))/length(mediaparcial))/10;
        
        %Repetição para todas as resoluções Wavelet
        Linha=Linha+1;
    end
    %Repetição para todas as colunas de PeDF's
    bancodeltaspsalt{1,Coluna}=media(:,:);
Coluna=Coluna+1;
Linha=1;
end

%%
[smrcr] = divfun (bancodeltaspsalt);


