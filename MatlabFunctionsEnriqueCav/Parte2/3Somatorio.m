DIV = input ('Entrar banco de Divs: ');

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
    
    C=C+1;
    end
    SUMDIV{1,Coluna}=soma(:,:);
    Coluna=Coluna+1;
    C=1;
end