function [DV] = indivs (xvar,mu1,mu2,sigma1,sigma2,varargin)
%  Enrique de Jesus Cavalcante - Ultima atualização: 21/03/2020
%  OBJ: Medir a Divergência de KL, Jensen-Shannon, Variante Simétrica, I e 
%  a Generalizada 
%  xvar = Valores eixo X
%  vect1 = vetor 1a PDF
%  vect2 = vetor 2a PDF
%  varargin = matriz 1xN, se não recebe entradas varargin é vazia
%  ~  nega a sentença 

%Inserir:
%1. Entrar c/ PeDF;
%2. Extrair PDF's;
%3. Extrair parâmetros de média, desvio e variança;
%4. Aplicar parâmetros em [DV];
%5. Rodar para cada Divergência com Varargin.

pd1=makedist('normal','mu',mu1,'sigma',sigma1);
pd2=makedist('normal','mu',mu2,'sigma',sigma2);
vect1=pdf(pd1,xvar);
vect2=pdf(pd2,xvar);
plot(xvar,vect1,xvar,vect2);


    switch varargin{1}
%Com o varagin poderei fazer todas as possibilidades simultaneamente         
        case 'js'
            Mlogvect = log2((vect2+vect1)/2);
            [DV] = .5* (sum(vect1.*(log(vect1)-Mlogvect)) + sum(vect2.*(log(vect2)-Mlogvect)));

        case 'sym'
            KL1 = sum(vect1 .* (log(vect1)-log(vect2)));
            KL2 = sum(vect2 .* (log(vect2)-log(vect1)));
            [DV] = (KL1+KL2)/2;
            
        case 'dkl_n'
            [DV] = sum(vect1 .* (log(vect1)-log(vect2)));
            
        case 'gnr'
            [DV] = (sum(vect1 .* (log(vect1)-log(vect2))) - (sum(vect1)) + (sum(vect2))); 
        
        case 'itasa'
            [DV] = (sum((vect1/vect2)-(log10(vect1)-log10(vect2))-1)); 
            
        case 'idiv'
            [DV] = (sum((vect1 .* (log(vect1)-log(vect2)))-vect2+vect1));
            
%       case 'fdiv'    
%Adc mais divergências com case e modificar a function                       
        otherwise
            error(['Ultimo argumento' ' "' varargin{1} '" ' 'não reconhecido.'])
    end
   
    
end