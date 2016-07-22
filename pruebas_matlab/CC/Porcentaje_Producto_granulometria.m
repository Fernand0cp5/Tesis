function Salida=Porcentaje_Producto_granulometria(Entrada)
fptHPGRu1=Entrada;
%Granulometría de producto del HPGR (Total, Centro y Borde) par
%interpolación del parámetro de calidad de molienda P80.
%N° de tamaños de clases
n=13;
%Variables de entrada:
for i = 1:n;
    if fptHPGRu1(i) < 100;
        fptHPGRu1(i) = fptHPGRu1(i);
    else fptHPGRu1(i)>= 100;
        fptHPGRu1(i) = (fptHPGRu1(i)*0) + (i/10000);
    end
end
Salida= [fptHPGRu1];
end
