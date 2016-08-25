function Salida=Porcentaje_Producto_granulometria(Entrada)
fptHPGRu(1)=Entrada(1);
fptHPGRu(2)=Entrada(2);
fptHPGRu(3)=Entrada(3);
fptHPGRu(4)=Entrada(4);
fptHPGRu(5)=Entrada(5);
fptHPGRu(6)=Entrada(6);
fptHPGRu(7)=Entrada(7);
fptHPGRu(8)=Entrada(8);
fptHPGRu(9)=Entrada(9);
fptHPGRu(10)=Entrada(10);
fptHPGRu(11)=Entrada(11);
fptHPGRu(12)=Entrada(12);
fptHPGRu(13)=Entrada(13);
%Granulometría de producto del HPGR (Total, Centro y Borde) par
%interpolación del parámetro de calidad de molienda P80.
%N° de tamaños de clases
n=13;
%Variables de entrada:
for i = 1:n;
    if fptHPGRu(i) < 100;
        fptHPGRu(i) = fptHPGRu(i);
    else fptHPGRu(i)>= 100;
        fptHPGRu(i) = (fptHPGRu(i)*0) + (i/10000);
    end
end
%Porcentaje acumulado pasante: 80% en peso
fpHPGRui = 80;
Xt=[45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
%Interpolación del parámetro P80
X80 = interp1(fptHPGRu,Xt,fpHPGRui);
P80 = X80;
Salida= P80;
end
