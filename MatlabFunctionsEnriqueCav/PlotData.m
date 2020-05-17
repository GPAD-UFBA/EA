function PlotData(X,amostra)

subplot(2,3,1);
plot(X{1,amostra}); 
title ('PeDF 1');
subplot(2,3,2);
plot(X{2,amostra}); 
title ('PeDF 2');
subplot(2,3,3);
plot(X{3,amostra}); 
title ('PeDF 3');
subplot(2,3,4);
plot(X{4,amostra}); 
title ('PeDF 4');
subplot(2,3,5);
plot(X{5,amostra}); 
title ('PeDF 5');
subplot(2,3,6);
plot(X{6,amostra}); 
title ('PeDF 6');
end