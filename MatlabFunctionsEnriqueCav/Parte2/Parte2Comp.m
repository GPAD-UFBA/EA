bancodeltasps = input ('Entrar banco Deltas Ps: ');

div = input ('Entrar com Div a ser utilizada: ');

Linha=1;
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