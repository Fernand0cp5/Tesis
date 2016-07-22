function Salida=FrH(Entrada)
SfaHu=Entrada(1);
FlaH(1)=Entrada(2);
FlaH(2)=Entrada(3);
FlaH(3)=Entrada(4);
FlaH(4)=Entrada(5);
FlaH(5)=Entrada(6);
FlaH(6)=Entrada(7);
FlaH(7)=Entrada(8);
FlaH(8)=Entrada(9);
FlaH(9)=Entrada(10);
FlaH(10)=Entrada(11);
FlaH(11)=Entrada(12);
FlaH(12)=Entrada(13);
FlaH(13)=Entrada(14);
n=13;
Xt=[45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
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
%Flujo de rechazo por tamaños (OS: sobretamaño): FrH(i) en [ton(i)/hora]
for i=1:n,
    FrH(i) = E(i)*FlaH(i);
end
Salida=[FrH];
end
