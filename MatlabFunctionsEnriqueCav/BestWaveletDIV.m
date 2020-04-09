bancopedfgeneralcell = input ('Entrar com banco de PeDFs: ');
div = input ('Entrar com Divergência a ser utilizada: ');


ordem=size(bancopedfgeneralcell);
Linha=1;
Coluna=1;
delta=zeros; 
bancodeltasdup=cell(1,ordem(1,2));

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

        rcr(L,1)=200;
        L=1;
        n=1;
        l=L+1;

        %Ver qual delta P se repete mais vezes em cada faixa de deltas Ps


        tamanho=0;
        tamanho2=size(rcr);
        while (rcr(L,1)<200) %Conta o tamanho do vetor de recorrência
            tamanho=tamanho+1;
            L=L+1;
        end
        L=1;
        t=tamanho/1.00000000001;
        
        fi=1;
        while (rcr(L+1,1)<200) %&& 
            while(fi<10000)
                    while (l>L && rcr(l,1)<200)
                        if (rcr(L,1)>=rcr(l,1))
                            v=v+1;
                            if (v==tamanho)
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
                            if (v==tamanho)
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


Coluna=1;
C=1;
fic=[1;1];
bancodeltaspsnorm=cell(zeros);
bancodeltaspsnormalizado=cell(zeros);
bancodeltaspsn=zeros;
ordem=size(bancodeltasps{1,C});
ordem2=size(bancodeltasps);


while (Coluna<=ordem2(1,2))
    banco=bancodeltasps{1,Coluna};
    while (C<=ordem(1,2))
        if (size(banco{1,C})==size(fic)) 
            bancodeltaspsn(1,C)=banco{1,C}(1,1);
        else
            bancodeltaspsn(1,C)=0;
        end
        C=C+1;
    end
    bancodeltaspsnormalizado{1,Coluna}=bancodeltaspsn(:,:);
    Coluna=Coluna+1;
    C=1;
end


Coluna=1;
C=1;
c=1;
divergencia=zeros;
sigma1=1;
sigma2=1;
xvar=-3:.1:35;
L=1;
DIV=cell(zeros);
ordem3=size(bancodeltaspsnormalizado{1,1});
ordem4=size(bancodeltaspsnormalizado(:,:));

while (Coluna<=ordem4(1,2))
    col=c+1;
    while (c<=ordem3(1,2))
    while (C<=5)
        if (bancodeltaspsnormalizado{1,Coluna}(1,c)==0 )
            divergencia(C,c)=0;
        else
            if (col==7)
                col=1;
            end
        mu1=bancodeltaspsnormalizado{1,Coluna}(1,c);
        mu2=bancodeltaspsnormalizado{1,Coluna}(1,col);
        
        pd1=makedist('normal','mu',mu1,'sigma',sigma1);
        pd2=makedist('normal','mu',mu2,'sigma',sigma2);
        vect11=pdf(pd1,xvar);
        vect22=pdf(pd2,xvar);
        vect1=vect11/10;
        vect2=vect22/10;
        %plot(xvar,vect1,xvar,vect2);
        if ~isequal(unique(xvar),sort(xvar))
            error(['KLDIV:duplicado.' ' X tem valores duplicados que serão tratados como distintos'])
        end
        %------------------------------------------------------------------------
        if ~isequal(size(xvar),size(vect1)) || ~isequal(size(xvar),size(vect2)),
          error('As entradas nao tem a mesma dimensao')
        end
        %------------------------------------------------------------------------
        %Checar se a soma dará 1: // encontrei em um forum essa parte
        if (abs(sum(vect1))>1.00001) || (abs(sum(vect2)) >1.00001),
            error('PDFs nao somam 1')
        end
        %------------------------------------------------------------------------

            switch div      
                case 1 %'js' ok
                    Qlogvect = log((vect2+vect1)/2);
                    DV = .5*(sum(vect1.*(log(vect1)-Qlogvect)) + sum(vect2.*(log(vect2)-Qlogvect)));

                case 2 %'sym' ok
                    KL1 = sum(vect1 .* (log10(vect1)-log10(vect2)));
                    KL2 = sum(vect2 .* (log10(vect2)-log10(vect1)));
                    DV = (KL1+KL2)/2;

                case 3 %'dkl_n' ok
                    DV = sum(vect1.*(log10(vect1)-log10(vect2)));

                case 4 %'itakura saito' ok
                    DV = (sum((vect1/vect2)-(log10(vect1)-log10(vect2))-1)); 

                case 5 %'gnr'
                    DV = (sum(vect1.*(log(vect1)-log(vect2))) - (sum(vect1)) + (sum(vect2))); 

                case 6 %'idiv'
                    DV = (passo*sum((vect1 .* (log(vect1)-log(vect2)))-vect2+vect1));                      
                otherwise
                    error('Ultimo argumento não reconhecido.')
            end
        divergencia(C,c)=DV;   
        end
        C=C+1;
        col=col+1;
    end
    C=1;
    c=c+1;
    col=c+1;
    end
    c=1;
    C=1;
    DIV{1,Coluna}=divergencia(:,:);
    Coluna=Coluna+1;
end
Linha=1;
Coluna=1;
C=1;
ordem6=size(DIV(:,:));
ordem5=size(DIV{1,1});
SUMDIV=cell(zeros);
soma=zeros;

while (Coluna<=ordem6(1,2))
    while (C<=ordem5(1,2))

    soma(1,C)=sum(DIV{1,Coluna}(:,C));
    if (soma(1,C)==0)
        soma(1,C)=500000;
    end
    C=C+1;
    end
    SUMDIV{1,Coluna}=soma(:,:);
    Coluna=Coluna+1;
    C=1;
end

C=1;
Coluna=1;
mindiv=zeros;
ordem7=size(SUMDIV(:,:));
ordem8=size(SUMDIV{1,1});

while (Coluna<=ordem7(1,2))
    mindiv(1,Coluna)=min(SUMDIV{1,Coluna});
    Coluna=Coluna+1;
end

Coluna=1;
c=1;
localizacao=cell(zeros);
loc=zeros;

while (Coluna<=ordem7(1,2))
    
    while (c<=ordem8(1,2))
        if (mindiv(1,Coluna)==SUMDIV{1,Coluna}(1,c))
            loc(Coluna,c)=1;
        else
            loc(Coluna,c)=0;
        end
        c=c+1;
    end 
    Coluna=Coluna+1;
    c=1;
end

%smrcr = somatório de recorrência da localização 
smrcr=zeros;
Coluna=1;
ordem9=size(loc(:,:));

while (Coluna<=ordem9(1,2))
    smrcr(1,Coluna)=sum(loc(:,Coluna));
    Coluna=Coluna+1;
end


