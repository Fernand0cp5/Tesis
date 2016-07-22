function Salida=EFICIENCIA_HARNERO_flujos(Entrada)
fptHPGRu5=Entrada;
SfaHu=Entrada;
%Obtencion de la eficiencia
%N� de tama�os de clases:
load('n.mat','n');
load('Xt.mat','Xt');
%Variables de entrada:
for i=1:n;
    if i<=n-1;
    faH(i)=fptHPGRu5(i)-fptHPGRu5(i+1);
    else
        faH(i)=fptHPGRu5(i);
    end
end
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
%Flujo de alimentaci�n por tama�os: FlaH(i) en [ton(i)/hora]
for i=1:n,
    FlaH(i) = FaH*faH(i)/100;
end
%Flujo de rechazo por tama�os (OS: sobretama�o): FrH(i) en [ton(i)/hora]
for i=1:n,
    FrH(i) = E(i)*FlaH(i);
end
%Flujo de descarga por tama�os (US: bajotama�o): FdH(i) en [ton(i)/hora]
for i=1:n,
    FdH(i) = FlaH(i) - FrH(i);
end
Salida = [FrH];
end