loc = input ('Entrar banco de Recorr�ncia do Somat�rio: ');

%smrcr = somat�rio de recorr�ncia da localiza��o 
smrcr=zeros;
Coluna=1;
ordem9=size(loc(:,:));

while (Coluna<=ordem9(1,2))
    smrcr(1,Coluna)=sum(loc(:,Coluna));
    Coluna=Coluna+1;
end
