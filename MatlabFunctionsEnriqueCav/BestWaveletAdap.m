bancopedfgeneralcell = input ('Entrar com banco de PeDFs: ');
div = input ('Entrar com Diverg�ncia a ser utilizada: ');
ncp = input ('Entrar com quantidade de deltas a serem avaliados:');

[bancodeltasdup] = rcradap (bancopedfgeneralcell,ncp);
[smrcr,loc] = divadap (bancodeltasdup,div);

