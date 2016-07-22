function Salida=P80_reduccion(Entrada)
fptHPGRu5=Entrada;
load('Xt.mat','Xt');
%Porcentaje acumulado pasante: 80% en peso
fpHPGRui = 80;
%Interpolación del parámetro P80
X80 = interp1(fptHPGRu5,Xt,fpHPGRui);
P80 = X80;
Salida= P80;
end