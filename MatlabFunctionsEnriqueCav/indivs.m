

function [DV] = indivs (var,mu1,mu2,sigma1,sigma2,passo,varargin)
%  Enrique de Jesus Cavalcante - Ultima atualização: 21/03/2019
%  OBJ: Medir a Divergência de KL, Jensen-Shannon, Variante Simétrica, I e 
% a Generalizada 
%  var = matriz da distribuição
%  vect1 = vetor 1a PDF
%  vect2 = vetor 2a PDF
%  varargin = matriz 1xN, se não recebe entradas varargin é vazia
%  ~ = nega a sentença 

%Inserir:
%1. Entrar c/ PeDF;
%2. Extrair PDF's;
%3. Extrair parâmetros de média, desvio e variança;
%4. Aplicar parâmetros em [DV];
%5. Rodar para cada Divergência com Varargin.

pd1=makedist('normal','mu',mu1,'sigma',sigma1);
pd2=makedist('normal','mu',mu2,'sigma',sigma2);
vect1=pdf(pd1,var);
vect2=pdf(pd2,var);


plot(var,vect1,var,vect2);
if ~isequal(unique(var),sort(var))
    error(['KLDIV:duplicado.' ' X tem valores duplicados que serão tratados como distintos'])
end

%------------------------------------------------------------------------
%if ~isequal(size(var),size(vect1)) || ~isequal(size(var),size(vect2)),
%  error('As entradas nao tem a mesma dimensao')
%end

%Checar se a soma dará 1: // encontrei em um forum essa parte
%if (abs(sum(vect1) - 1) > .0001) || (abs(sum(vect2) - 1) > .0001),
%    error('PDFs nao somam 1')
%end
%------------------------------------------------------------------------

    switch varargin{1}
%Com o varagin poderei fazer todas as possibilidades simultaneamente         
        case 'js'
            Qlogvect = log2((vect2+vect1)/2);
            [DV] = passo*.5* (sum(vect1.*(log(vect1)-Qlogvect)) + sum(vect2.*(log(vect2)-Qlogvect)));

        case 'sym'
            KL1 = passo*sum(vect1 .* (log(vect1)-log(vect2)));
            KL2 = passo*sum(vect2 .* (log(vect2)-log(vect1)));
            [DV] = (KL1+KL2)/2;
            
        case 'dkl_n'
            [DV] = sum(vect1.*(log10(vect1)-log10(vect2)));
            
        case 'gnr'
            [DV] = (passo*sum(vect1 .* (log(vect1)-log(vect2))) - (sum(vect1)) + (sum(vect2))); 
        
        case 'itasa'
            [DV] = (passo*sum((vect1/vect2)-(log10(vect1)-log10(vect2))-1)); 
            
        case 'idiv'
            [DV] = (passo*sum((vect1 .* (log(vect1)-log(vect2)))-vect2+vect1));
            
%       case 'fdiv'    
%Adc mais divergências com case e modificar a function                       
        otherwise
            error(['Ultimo argumento' ' "' varargin{1} '" ' 'não reconhecido.'])
    end
   
    
end