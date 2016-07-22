function Salida=SfaHu(Entrada)
faH=Entrada;
%Modelo de Harnero vibratorio propuesto por KARRA, adaptado por A. Casali.
%N° de tamaños de clases:
n=13;
Xt=[45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
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
Salida=[SfaHu];
end