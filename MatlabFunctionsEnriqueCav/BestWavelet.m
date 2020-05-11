bancopedfgeneralcell = input ('Entrar com banco de PeDFs: ');
div = input ('Entrar com Divergência a ser utilizada: ');
prefdelta = input ('Entrar com divergência:');
quant = input ('Entrar com somatório de recorrência de andamento: ');
[bancodeltaspsnormalizado] = rcrpornivel (bancopedfgeneralcell, prefdelta);
[smrcr,loc,smrcrquant,a] = divfun (bancodeltaspsnormalizado,div,quant);
