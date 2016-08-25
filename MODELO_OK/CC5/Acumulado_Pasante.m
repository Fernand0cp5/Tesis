function Salida=Acumulado_Pasante(Entrada)
fptHPGR(1)=Entrada(1);
fptHPGR(2)=Entrada(2);
fptHPGR(3)=Entrada(3);
fptHPGR(4)=Entrada(4);
fptHPGR(5)=Entrada(5);
fptHPGR(6)=Entrada(6);
fptHPGR(7)=Entrada(7);
fptHPGR(8)=Entrada(8);
fptHPGR(9)=Entrada(9);
fptHPGR(10)=Entrada(10);
fptHPGR(11)=Entrada(11);
fptHPGR(12)=Entrada(12);
fptHPGR(13)=Entrada(13);
n=13;
fptHPGRu(1)=1;
for i = 2:n;
    fptHPGRu(i) = fptHPGRu(i-1) - fptHPGR(i-1);
end
fptHPGRu(1:n)=fptHPGRu(1:n)*100;
Salida=fptHPGRu;
end