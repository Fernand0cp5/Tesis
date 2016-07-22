function Salida=EFICIENCIA_HARNERO_flujos(Entrada)
fptHPGRu5=Entrada;
SfaHu=Entrada;
%Obtencion de la eficiencia
%N° de tamaños de clases:
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
%Flujo de rechazo por tamaños (OS: sobretamaño): FrH(i) en [ton(i)/hora]
for i=1:n,
    FrH(i) = E(i)*FlaH(i);
end
%Flujo de descarga por tamaños (US: bajotamaño): FdH(i) en [ton(i)/hora]
for i=1:n,
    FdH(i) = FlaH(i) - FrH(i);
end
Salida = [FrH];
end