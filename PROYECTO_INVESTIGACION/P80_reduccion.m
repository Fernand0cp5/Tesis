%Par�metro P80: Interpretado como el tama�o de part�cula bajo el cual se
%encuentra el 80% en masa del total de material chancado
%(Tama�o del 80% pasante en el producto HPGR)
%Variables de entrada:
%Porcentaje en peso pasante acumulado de producto total, borde o centro
%HPGR: fpHPGRu en [% peso]
fpHPGRu(1) = 0.0001; %Porcentaje acumulado pasante, tama�o 45.000 [mm]
fpHPGRu(2) = 0.0002; %Porcentaje acumulado pasante, tama�o 31.500 [mm]
fpHPGRu(3) = 94.36; %Porcentaje acumulado pasante, tama�o 22.400 [mm]
fpHPGRu(4) = 86.40; %Porcentaje acumulado pasante, tama�o 16.000 [mm]
fpHPGRu(5) = 75.52; %Porcentaje acumulado pasante, tama�o 11.200 [mm]
fpHPGRu(6) = 61.99; %Porcentaje acumulado pasante, tama�o 8.000 [mm]
fpHPGRu(7) = 45.03; %Porcentaje acumulado pasante, tama�o 5.600 [mm]
fpHPGRu(8) = 28.44; %Porcentaje acumulado pasante, tama�o 2.800 [mm]
fpHPGRu(9) = 21.39; %Porcentaje acumulado pasante, tama�o 1.000 [mm]
fpHPGRu(10) = 18.23; %Porcentaje acumulado pasante, tama�o 0.500 [mm]
fpHPGRu(11) = 15.72; %Porcentaje acumulado pasante, tama�o 0.315 [mm]
fpHPGRu(12) = 13.41; %Porcentaje acumulado pasante, tama�o 0.200 [mm]
fpHPGRu(13) = 10.99; %Porcentaje acumulado pasante, tama�o 0.125 [mm]
%Tama�os de clases: X(i) en [mm]
X(1) = 45; %tama�o 45.000 [mm]
X(2) = 31.5; %tama�o 31.500 [mm]
X(3) = 22.4; %tama�o 22.400 [mm]
X(4) = 16; %tama�o 16.000 [mm]
X(5) = 11.2; %tama�o 11.200 [mm]
X(6) = 8; %tama�o 8.000 [mm]
X(7) = 5.60; %tama�o 5.600 [mm]
X(8) = 2.8; %tama�o 2.800 [mm]
X(9) = 1; %tama�o 1.000 [mm]
X(10) = 0.5; %tama�o 0.500 [mm]
X(11) = 0.315; %tama�o 0.315 [mm]
X(12) = 0.2; %tama�o 0.200 [mm]
X(13) = 0.125; %tama�o 0.125 [mm]
%Porcentaje acumulado pasante: 80% en peso
fpHPGRui = 80;
%Interpolaci�n del par�metro P80
X80 = interp1(fpHPGRu,X,fpHPGRui);
P80 = X80;
[ REDUCCION ] = [ P80 ]
