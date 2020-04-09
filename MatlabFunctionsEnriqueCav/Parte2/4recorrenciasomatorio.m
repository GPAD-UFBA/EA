SUMDIV = input ('Entrar banco de Somatório de Divs: ');

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
