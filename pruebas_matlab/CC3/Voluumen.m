function Salida=Voluumen(Entrada) 
% Volumen por bloque-------------
syms x
Z=Entrada(1);
s0=Entrada(2);
D=0.8;
L=0.25;
h=Z/10;
a = 0;
bb = h;
c = 2*h;
d = 3*h;
e = 4*h;
f = 5*h;
g = 6*h;
hh = 7*h;
i = 8*h;
j = 9*h;
k = 10*h;
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
area1 = double(int(in2,'x',a,bb));
area2 = double(int(in2,'x',bb,c));
area3 = double(int(in2,'x',c,d));
area4 = double(int(in2,'x',d,e));
area5 = double(int(in2,'x',e,f));
area6 = double(int(in2,'x',f,g));
area7 = double(int(in2,'x',g,hh));
area8 = double(int(in2,'x',hh,i));
area9 = double(int(in2,'x',i,j));
area10 = double(int(in2,'x',j,k));
vol1 = (L*area1);
vol2 = (L*area2);
vol3 = (L*area3);
vol4 = (L*area4);
vol5 = (L*area5);
vol6 = (L*area6);
vol7 = (L*area7);
vol8 = (L*area8);
vol9 = (L*area9);
vol10 = (L*area10);
Salida = [vol10,vol9,vol8,vol7,vol6,vol5,vol4,vol3,vol2,vol1];
end

