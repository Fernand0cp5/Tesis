function Salida=FlaH(Entrada)
SfaHu=Entrada(1);
faH(1)=Entrada(2);
faH(2)=Entrada(3);
faH(3)=Entrada(4);
faH(4)=Entrada(5);
faH(5)=Entrada(6);
faH(6)=Entrada(7);
faH(7)=Entrada(8);
faH(8)=Entrada(9);
faH(9)=Entrada(10);
faH(10)=Entrada(11);
faH(11)=Entrada(12);
faH(11)=Entrada(13);
faH(13)=Entrada(14);
load('n.mat','n');
load('Xt.mat','Xt');
%Flujo de alimentación de mineral al Harnero:
FaH = 22; % FaH en [ton/hora]
%Parámetros del Harnero (Valores utilizados por Casali en su adaptación del
%modelo de Karra):
k1 = -0.638;
k2 = 8.98;
k3 = 0.00013;
%Tamaño bajo el cual se encuentra el 50% de la alimentación al harnero:
d50 = ((FaH*SfaHu)/(100*1.6*k3))^(0.148); %d50 en [mm] ec. 3.46 100 corresponde
%transformacion de porcentaje a fraccion
%Eficiencia del harnero expresada en función del mineral de tamaño que no cumple con la 
%especificación (menor o igual al tamaño de abertura)
for i=1:n,
    E(i) = 1 - exp(k1*((Xt(i)/d50)^k2));
end
%Flujo de alimentación por tamaños: FlaH(i) en [ton(i)/hora]
for i=1:n,
    FlaH(i) = FaH*faH(i)/100;
end
Salida=[FlaH];
end