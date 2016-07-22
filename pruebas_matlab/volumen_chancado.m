% Volumen zona chancado-------------
syms x
load('D.mat','D');
load('s0.mat','s0');
load ('h.mat','h');
load('L.mat','L');
a = 0;
f = 5*h;
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
area1 = double(int(in2,'x',a,f));
vol1 = (L*area1)*1E6;
[Resp] = [vol1]
save('vol1.mat','vol1')
