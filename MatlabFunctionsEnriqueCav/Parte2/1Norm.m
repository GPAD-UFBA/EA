bancodeltasps = input ('Entrar banco Deltas Ps: ');

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