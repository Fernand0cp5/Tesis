%Modelo HArnero Vibratorio continuacion
%Obtencion de la eficiencia
%N� de tama�os de clases:
n = 13;
%Variables de entrada:
%Flujo de alimentaci�n de mineral al Harnero:
FaH = 22; % FaH en [ton/hora]
%Granulometr�a de alimentaci�n discreta al Harnero: f(i)aH en [%]
faH(1) = 0; %porcentaje en peso retenido discreto, tama�o 45.000(mm)
faH(2) = 0.49; %porcentaje en peso retenido discreto, tama�o 31.500(mm)
faH(3) = 11.55; %porcentaje en peso retenido discreto, tama�o 22.400(mm)
faH(4) = 12.32; %porcentaje en peso retenido discreto, tama�o 16.000(mm)
faH(5) = 12.47; %porcentaje en peso retenido discreto, tama�o 11.200(mm)
faH(6) = 12.22; %porcentaje en peso retenido discreto, tama�o 8.000(mm)
faH(7) = 13.03; %porcentaje en peso retenido discreto, tama�o 5.600(mm)
faH(8) = 11.82; %porcentaje en peso retenido discreto, tama�o 2.800(mm)
faH(9) = 5.44; %porcentaje en peso retenido discreto, tama�o 1.000(mm)
faH(10) = 3.05; %porcentaje en peso retenido discreto, tama�o 0.500(mm)
faH(11) = 2.55; %porcentaje en peso retenido discreto, tama�o 0.315(mm)
faH(12) = 2.2; %porcentaje en peso retenido discreto, tama�o 0.200(mm)
faH(13) = 12.86; %porcentaje en peso retenido discreto, tama�o 0.125(mm)
%Porcentaje en peso acumulado de alimentacion Bajotama�o la abertura del
%Harnero (US):
SfaHu = 75.64; %[%]
%Tama�os de clases: X(i) en [mm] (13 mallas)
X(1) = 45; %tama�o 45.000 [mm]
X(2) = 31.5; %tama�o 31.500 [mm]
X(3) = 22.4; %tama�o 22.400 [mm]
X(4) = 16; %tama�o 16.000 [mm]
X(5) = 11.2; %tama�o 11.200 [mm]
X(6) = 8; %tama�o 8.000 [mm]
X(7) = 5.6; %tama�o 5.600 [mm]
X(8) = 2.8; %tama�o 2.800 [mm]
X(9) = 1; %tama�o 1.000 [mm]
X(10) = 0.5; %tama�o 0.500 [mm]
X(11) = 0.315; %tama�o 0.315 [mm]
X(12) = 0.2; %tama�o 0.200 [mm]
X(13) = 0.125; %tama�o 0.125 [mm]
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
E(i) = 1 - exp(k1*((X(i)/d50)^k2));
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
[ Clasificacion ] = [FrH FdH]


