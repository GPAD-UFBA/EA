function [bancodeltasdup] = rcradap (bancopedfgeneralcell,ncp)

%bancopedfgeneralcell = input('Banco PeDF: ');
ordem=size(bancopedfgeneralcell);
Linha=1;
Coluna=1;
delta=zeros; 
bancodeltasdup=cell(1,ordem(1,2));

while (Coluna<=ordem(1,2))
Linha=1;
delta=zeros;
    while (Linha<=ordem(1,1))
   %%
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

%% -- -- %%
canddelta=(canddelta(1:(length(canddelta)-11),1));
rcr = (rcr(1:(length(rcr)),1));
[atualcanddelta pos] = sort(canddelta);
atualrcr=zeros(size(rcr));
for cont=1:length(rcr)
    atualrcr(cont,1)= rcr(pos(cont),1);
end
atual=zeros(length(atualcanddelta),3);
atual(:,1)=atualcanddelta;
atual(:,2)=atualrcr;
for cont=1:length(rcr)
pos(cont,1) = mod(pos(cont,1),5);
    if(pos(cont,1)==0)
        pos(cont,1)=5;
    end
end

%% ----Verificar Deltas---- %%
atual(:,3)=pos;
rcrdeltas=zeros(size(length(atual),2));
i=1; k=0; 
mudanca=1;
for cont=1:length(atual)
    set=0;
    if (cont==1)
        rcrdeltas(1,1:2)=atual(1,1:2);
        k=1;
    else
        if (atual(cont,1)==atual(cont-1,1))
            k=k+1;
            a=i;
            for i=cont:-1:k
                if (atual(i,2)==atual(k,2))
                else
                    set=1;
                    if (a==k && set==1)
                        rcrdeltas(mudanca,2)= rcrdeltas(mudanca,2) + atual(cont,2);
                    end
                end
                a=a-1;
            end
        else
            mudanca=mudanca+1;
            rcrdeltas(mudanca,1:2)=atual(cont,1:2);
            k=1;
        end
    end

end

%% -- -- %%
canddeltasintermediario=zeros(size(length(rcrdeltas),1));
[rcrdeltasintermediario pos] = sort(rcrdeltas(:,2),1,'descend');
for cont=1:length(rcrdeltas)
    canddeltasintermediario(cont,1)= rcrdeltas(pos(cont),1);
end
deltas=zeros(size(rcrdeltas));
deltas(:,1)=canddeltasintermediario;
deltas(:,2)=rcrdeltasintermediario;

%% -- Setando a quantidade de deltas Ps que queremos -- %%
deltasp=zeros;
if (ncp==0)
    deltasp=deltas;
else
    for i=1:ncp
        deltasp(i,1) = deltas(i,1);
        deltasp(i,2) = deltas(i,2);
    end
end

%% -- Fazendo a média dos Deltas P -- %%

DP = sum(deltasp(:,1).*deltasp(:,2))/sum(deltasp(:,2));


%% -- Fazendo a repetição para todo o conjunto de PeDFs-- %%
       
        bancocanddeltas{1,Linha}=DP;
        %Repetição para todas as resoluções Wavelet
        Linha=Linha+1; 
    end
     
    %Repetição para todas as colunas de PeDF's
bancodeltasdup{1,Coluna}=bancocanddeltas(:,:);
Coluna=Coluna+1;
end

end
