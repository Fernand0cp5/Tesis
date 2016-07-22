%Modelo de Harnero vibratorio propuesto por KARRA, adaptado por A. Casali.
%N° de tamaños de clases:
%load('Xt.mat','Xt');
Xt=[45.0000 31.5000 22.4000 16.0000 11.2000 8.0000 5.6000 2.8000 1.0000 0.5000 0.3150 0.2000 0.1250]
n = 13;
%Variables de entrada:
fptHPGRu= [100 100 99.51 87.96 75.64 63.17 50.95 37.92 26.10 20.66 17.61 15.06 12.86];
for i=1:n;
    if i<=n-1;
    faH(i)=fptHPGRu(i)-fptHPGRu(i+1);
    else
        faH(i)=fptHPGRu(i);
    end
end
faH
% %Granulometría de alimentación discreta al Harnero: f(i)aH en [%]
% faH(1) = 0; %porcentaje en peso retenido discreto, tamaño 45.000(mm)
% faH(2) = 0.49; %porcentaje en peso retenido discreto, tamaño 31.500(mm)
% faH(3) = 11.55; %porcentaje en peso retenido discreto, tamaño 22.400(mm)
% faH(4) = 12.32; %porcentaje en peso retenido discreto, tamaño 16.000(mm)
% faH(5) = 12.47; %porcentaje en peso retenido discreto, tamaño 11.200(mm)
% faH(6) = 12.22; %porcentaje en peso retenido discreto, tamaño 8.000(mm)
% faH(7) = 13.03; %porcentaje en peso retenido discreto, tamaño 5.600(mm)
% faH(8) = 11.82; %porcentaje en peso retenido discreto, tamaño 2.800(mm)
% faH(9) = 5.44; %porcentaje en peso retenido discreto, tamaño 1.000(mm)
% faH(10) = 3.05; %porcentaje en peso retenido discreto, tamaño 0.500(mm)
% faH(11) = 2.55; %porcentaje en peso retenido discreto, tamaño 0.315(mm)
% faH(12) = 2.2; %porcentaje en peso retenido discreto, tamaño 0.200(mm)
% faH(13) = 12.86; %porcentaje en peso retenido discreto, tamaño 0.125(mm)
% %Tamaños de clases: X(i) en [mm] (13 mallas)
% X(1) = 45; %tamaño 45.000 [mm]
% X(2) = 31.5; %tamaño 31.500 [mm]
% X(3) = 22.4; %tamaño 22.400 [mm]
% X(4) = 16; %tamaño 16.000 [mm]
% X(5) = 11.2; %tamaño 11.200 [mm]
% X(6) = 8; %tamaño 8.000 [mm]
% X(7) = 5.6; %tamaño 5.600 [mm]
% X(8) = 2.8; %tamaño 2.800 [mm]
% X(9) = 1; %tamaño 1.000 [mm]
% X(10) = 0.5; %tamaño 0.500 [mm]
% X(11) = 0.315; %tamaño 0.315 [mm]
% X(12) = 0.2; %tamaño 0.200 [mm]
% X(13) = 0.125; %tamaño 0.125 [mm]
%Tamaño de la Abertura del Harnero:
Xa = 12.7; % [mm]
%Algoritmo de Harnero: Suma acumulada de fracciones en peso de tamaño menor
% %o igual al tamaño de la abertura
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
[ Bajotamano ] = [ SfaHu ]%Porcentaje en peso acumulado de alimentacion del
% %Harnero bajotamano en %
