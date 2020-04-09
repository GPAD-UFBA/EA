loc = input ('Entrar banco de Recorrência do Somatório: ');

%smrcr = somatório de recorrência da localização 
smrcr=zeros;
Coluna=1;
ordem9=size(loc(:,:));

while (Coluna<=ordem9(1,2))
    smrcr(1,Coluna)=sum(loc(:,Coluna));
    Coluna=Coluna+1;
end
