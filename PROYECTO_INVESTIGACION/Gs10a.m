function Salida=Gs10a(Entrada) 
rocm10=Entrada(1);
D=0.8;
L=0.25;
s0=0.019;
U=0.67;
roa=1.61;
load('vol10.mat','vol10');
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
AA = [5 6 7 8]
Salida=[Gs10]; 
end
