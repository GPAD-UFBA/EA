bancopedfgeneralcell = input ('Entrar com banco de PeDFs: ');
div = input ('Entrar com Diverg�ncia a ser utilizada: ');
prefdelta = input ('Entrar com divisor do banco:');

[bancodeltaspsnormalizado] = rcrpornivel (bancopedfgeneralcell, prefdelta);

fprintf('\n')
fprintf('Se todas as PeDFs de uma musica apresentam o mesmo DeltaP ent�o pode-se usar qualquer n�vel\n')
for i=5:-1:1
[smrcr,loc,smrcrquant,a] = divfun (bancodeltaspsnormalizado,div,i);
[maximum nivelwavelet] = max(smrcrquant,[],2);
fprintf('Recorr�ncia = %i ----- O n�vel Wavelet %i tem %i por cento de acerto \n',i, nivelwavelet, round(100/a*maximum))
end

%%---------------------------
%Gaussianas Equivalentes
