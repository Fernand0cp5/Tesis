function Salida=Porcentaje_Producto_granulometria(Entrada)
fptHPGRu5=Entrada;
%Granulometr�a de producto del HPGR (Total, Centro y Borde) par
%interpolaci�n del par�metro de calidad de molienda P80.
%N� de tama�os de clases
load('n.mat','n');
%Variables de entrada:
for i = 1:n;
    if fptHPGRu5(i) < 100;
        fptHPGRu5(i) = fptHPGRu5(i);
    else fptHPGRu5(i)>= 100;
        fptHPGRu5(i) = (fptHPGRu5(i)*0) + (i/10000);
    end
end
Salida= [fptHPGRu5];
end
