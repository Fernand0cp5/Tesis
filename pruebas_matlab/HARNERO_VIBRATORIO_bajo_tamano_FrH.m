function Salida=HARNERO_VIBRATORIO_bajo_tamano_FrH(Entrada)
fptHPGRu5=Entrada;
%Modelo de Harnero vibratorio propuesto por KARRA, adaptado por A. Casali.
%N� de tama�os de clases:
load('n.mat','n');
load('Xt.mat','Xt');
for i=1:n;
    if i<=n-1;
    faH(i)=fptHPGRu5(i)-fptHPGRu5(i+1);
    else
        faH(i)=fptHPGRu5(i);
    end
end
%Tama�o de la Abertura del Harnero:
Xa = 12.7; % [mm]
%Algoritmo de Harnero: Suma acumulada de fracciones en peso de tama�o menor
% %o igual al tama�o de la abertura
if Xt(1) > Xa,
    suma = 0;
    for i = 1:n,
        if Xt(i) <= Xa,
            faHu(i) = faH(i);
            suma = suma + faH(i);
            SfaHu = suma;
        else
            faHu(i) = 0;
        end
    end
else
    faHu = faH;
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
%Porcentaje en peso acumulado de alimentacion del Harnero bajotamano en %
end
