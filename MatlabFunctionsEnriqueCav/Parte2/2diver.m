bancodeltaspsnormalizado = input ('Entrar banco Deltas Ps Norm: ');
div = input ('Entrar com Div a ser utilizada: ');

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
