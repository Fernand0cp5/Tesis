function Salida=P80_reduccion(Entrada)
fptHPGRu1=Entrada;
Xt=[45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
%Porcentaje acumulado pasante: 80% en peso
fpHPGRui = 80;
%Interpolación del parámetro P80
X80 = interp1(fptHPGRu1,Xt,fpHPGRui);
P80 = X80;
Salida= P80;
end