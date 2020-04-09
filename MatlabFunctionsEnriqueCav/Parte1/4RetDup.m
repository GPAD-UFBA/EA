bancodeltasdup = input ('Entrar banco deltas p: ');

ordem3=size(bancodeltasdup);
ordem4=size(bancodeltasdup{1,1});
Coluna=1;
L=1;
C=1;
bancodeltaspp=zeros;
bancodeltasp=zeros(300,6);
banco=zeros;
bancodeltasps=cell(1,ordem3(1,2));

while (Coluna<=ordem3(1,2))
    bancodeltasd=bancodeltasdup(1,Coluna);
    bancodeltasppp=bancodeltasd{1,1};
    while (C<=ordem4(1,2)) %(C<=6)
        bancodeltaspp=unique(bancodeltasppp(:,C));
        bancodeltasp=sort(bancodeltaspp,'descend');
        banco(L,C)=bancodeltasp;
        C=C+1;
    end
    bancodeltasps{1,Coluna}=banco(:,:);
    Coluna=Coluna+1;
    C=1;
end