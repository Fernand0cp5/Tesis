function Salida=Masaa1b5(Entrada)
Gs5=Entrada(1);
p=Entrada(2);
Smd=Entrada(3);
ma1=Entrada(4);
load('Gs6.mat','Gs6');
load('fipHPGR.mat','fipHPGR');
load('NB.mat','NB');
ma1 = Gs6*fipHPGR(1)/NB-Gs5*p(1,1)/NB-ma1*Smd(1,1);
Salida=[ma1];
end