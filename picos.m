bancopedfgeneralcell = input ('Entrar banco PeDfs: ');
C=1;
Linha=1;
Coluna=1;
delta=zeros; 
bancodeltas=cell(1,465);

while (Coluna<=465)
Linha=1;
delta=zeros;
    while (Linha<=6)
        bancopedfcell=bancopedfgeneralcell(Linha,Coluna);
        bancopedfs=bancopedfcell{1,1};

        L=1;
        C=1;
        l=1;
        n=0;
        posicoes=zeros; 

        for cont=1:512
            if (bancopedfs(L,C)==1)
                n=n+1; 
            elseif(bancopedfs(L,C) > bancopedfs(L+1,C) && bancopedfs(L,C) > bancopedfs(L-1,C))
                n=n+1;
                posicoes(l,C)=n;
                l=l+1;
            else
                n=n+1;
            end
            L=L+1;
        end

        canddelta=zeros;
        posicoes(l+1,C)=0;
        n=1;
        L=1;
        C=1;
        k=0;

        while (posicoes (L+4,C)>0) 
        %Estudar uma maneira de não perder muitas correlações
                canddelta(n,C) = posicoes(L+1,C) - posicoes(L,C);
                n=n+1;
                k=k+1;
                canddelta(n,C) = posicoes(L+2,C) - posicoes(L,C);
                n=n+1;
                k=k+1;
                canddelta(n,C) = posicoes(L+3,C) - posicoes(L,C);
                n=n+1;
                k=k+1;
                canddelta(n,C) = posicoes(L+4,C) - posicoes(L,C);
                n=n+1;
                k=k+1;
                canddelta(n,C) = posicoes(L+5,C) - posicoes(L,C);
                n=n+1;
                k=k+1;  
            L=L+1;
        end

        canddelta(n,C)=0;
        canddelta(n+1,C)=0;
        canddelta(n+2,C)=0;
        canddelta(n+3,C)=0;
        canddelta(n+4,C)=0;
        L=1;
        C=1;
        l=6;
        c=1;

        v=0;
        rcr=zeros;
        while (canddelta(L+5,C)>0)
            while (canddelta(l+5,C)>0)
                if (canddelta(L,C)==canddelta(l,C))
                    v=v+1;
                else
                end
                l=l+5;
            end
            rcr(L,C)=v;
            L=L+1;
            l=L+6;
            v=0;
        end

        rcr(L,C)=500;
        L=1;
        C=1;
        n=1;
        l=L+1;

        %Ver qual se repete mais vezes
        %rcr é recorrência


        tamanho=0;

        while (rcr(L,C)<500)
            tamanho=tamanho+1;
            L=L+1;
        end
        L=1;
        t=tamanho/1.2;
        while (rcr(L+1,C)<500)
                if (rcr(l,C)<500)
                    while (rcr(L,C)>=rcr(l,C))
                        v=v+1;
                        if (v>t && v<t+1)
                            delta(n,Linha)=canddelta(L,C);
                            n=n+1;
                        end
                        l=l+1;
                    end
                elseif (rcr(l,C)==500) 
                    l=1;
                    while (l<L)
                        if (rcr(L,C)>=rcr(l,C))
                            v=v+1;
                            if (v>t && v<t+1)
                                delta(n,Linha)=canddelta(L,C);
                                n=n+1;
                            end
                        end 
                        l=l+1;
                    end
                end
            L=L+1;
            l=L+1;
            v=0;
        end
        Linha=Linha+1;
    end
bancodeltas{1,Coluna}=delta(:,:);
Coluna=Coluna+1;
end

    
