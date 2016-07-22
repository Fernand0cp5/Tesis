function Salida=SfaHu(Entrada)
faH=Entrada;
%Modelo de Harnero vibratorio propuesto por KARRA, adaptado por A. Casali.
%N° de tamaños de clases:
load('n.mat','n');
load('Xt.mat','Xt');
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