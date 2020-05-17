xvar=-100:.1:100; 
mu1=(sum(bancodeltasdup{1,1}{:,1}))/length(bancodeltasdup{1,1}{:,1});
mu2=(sum(bancodeltasdup{1,1}{:,1}))/length(bancodeltasdup{1,1}{:,2});
sigma1= (sum(((bancodeltasdup{1,1}{:,1}) - mu1).^2))/length(bancodeltasdup{1,1}{:,1});
sigma2= (sum(((bancodeltasdup{1,1}{:,1}) - mu1).^2))/length(bancodeltasdup{1,1}{:,2});
[DV] = indivs (xvar,mu1,mu2,sigma1,sigma2,.1,'dkl_n')

fprintf('O nível Wavelet %s, tem %s por cento de acerto \n', sigma1, sigma1)