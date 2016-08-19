function Salida=Voluumen(Entrada) 
% Volumen por bloque-------------
syms x
D=0.8;
L=0.25;
s0=Entrada(1);
h=Entrada(2);
a = 0;
bb = h;
c = 2*h;
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
area1 = double(int(in2,'x',a,bb));
area2 = double(int(in2,'x',bb,c));
vol1 = (L*area1)*1E6;
vol2 = (L*area2)*1E6;
Salida = [vol2,vol1];
end