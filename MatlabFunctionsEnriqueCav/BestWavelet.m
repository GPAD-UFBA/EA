bancopedfgeneralcell = input ('Entrar com banco de PeDFs: ');
div = input ('Entrar com Diverg�ncia a ser utilizada: ');
prefdelta = input ('Entrar com diverg�ncia:');
quant = input ('Entrar com somat�rio de recorr�ncia de andamento: ');
[bancodeltaspsnormalizado] = rcrpornivel (bancopedfgeneralcell, prefdelta);
[smrcr,loc,smrcrquant,a] = divfun (bancodeltaspsnormalizado,div,quant);
