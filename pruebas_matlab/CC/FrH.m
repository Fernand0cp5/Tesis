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
%Flujo de alimentaci�n de mineral al Harnero:
FaH = 22; % FaH en [ton/hora]
%Par�metros del Harnero (Valores utilizados por Casali en su adaptaci�n del
%modelo de Karra):
k1 = -0.638;
k2 = 8.98;
k3 = 0.00013;
%Tama�o bajo el cual se encuentra el 50% de la alimentaci�n al harnero:
d50 = ((FaH*SfaHu)/(100*1.6*k3))^(0.148); %d50 en [mm] ec. 3.46 100 corresponde
%transformacion de porcentaje a fraccion
%Eficiencia del harnero expresada en funci�n del mineral de tama�o que no cumple con la 
%especificaci�n (menor o igual al tama�o de abertura)
for i=1:n,
    E(i) = 1 - exp(k1*((Xt(i)/d50)^k2));
end
%Flujo de rechazo por tama�os (OS: sobretama�o): FrH(i) en [ton(i)/hora]
for i=1:n,
    FrH(i) = E(i)*FlaH(i);
end
Salida=[FrH];
end
