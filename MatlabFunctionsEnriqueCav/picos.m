bancopedfgeneralcell = input ('Entrar banco PeDfs: ');
ordem=size(bancopedfgeneralcell);
Linha=1;
Coluna=1;
delta=zeros; 
bancodeltasdup=cell(1,ordem(1,2));

while (Coluna<=ordem(1,2))
Linha=1;
delta=zeros;
    while (Linha<=ordem(1,1))
        bancopedfcell=bancopedfgeneralcell(Linha,Coluna);
        bancopedfs=bancopedfcell{1,1};

        L=1;
        l=1;
        n=0;
        posicoes=zeros; 

        for cont=1:512
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

        rcr(L,1)=500;
        L=1;
        n=1;
        l=L+1;

        %Ver qual delta P se repete mais vezes em cada faixa de deltas Ps


        tamanho=0;
        while (rcr(L,1)<500) %Conta o tamanho do vetor de recorrência
            tamanho=tamanho+1;
            L=L+1;
        end
        L=1;
        t=tamanho/1.00000000001;
        fi=1;
        while (rcr(L+1,1)<500) %&& 
            while(fi<10000)
                    while (l>L && rcr(l,1)<500)
                        if (rcr(L,1)>=rcr(l,1))
                            v=v+1;
                            if (v>t && v<t+1)
                                delta(n,Linha)=canddelta(L,1);
                                n=n+1;
                            end
                        end
                    l=l+1;
                    end
                    l=1;
                    while (l<=L)
                        if (rcr(L,1)>=rcr(l,1))
                            v=v+1;
                            if (v>t && v<t+1)
                                delta(n,Linha)=canddelta(L,1);
                                n=n+1;
                            end
                        end 
                        l=l+1;
                    end
                    delta(n,Linha)=0;
                    fi=10000;

            end
            fi=1;
            L=L+1;
            l=L+1;
            v=0;
        end

        %Repetição para todas as resoluções Wavelet
        Linha=Linha+1;
    end
    %Repetição para todas as colunas de PeDF's
bancodeltasdup{1,Coluna}=delta(:,:);
Coluna=Coluna+1;
end

ordem3=size(bancodeltasdup);
ordem4=size(bancodeltasdup{1,1});
Coluna=1;
L=1;
C=1;
bancodeltaspp=zeros;
bancodeltasp=zeros;
banco=cell(zeros);
bancodeltasps=cell(1,ordem3(1,2));

while (Coluna<=ordem3(1,2))
    bancodeltasd=bancodeltasdup(1,Coluna);
    bancodeltasppp=bancodeltasd{1,1};
    while (C<=ordem4(1,2)) %(C<=6)
        bancodeltaspp=unique(bancodeltasppp(:,C));
        bancodeltasp=sort(bancodeltaspp,'descend');
        banco{1,C}=bancodeltasp;
        C=C+1;
    end
    bancodeltasps{1,Coluna}=banco(1,:);
    Coluna=Coluna+1;
    C=1;
end


