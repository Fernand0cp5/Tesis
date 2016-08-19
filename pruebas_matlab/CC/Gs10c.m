function Salida=Gs10c(Entrada) 
Gs11=Entrada(1);
s0=Entrada(2);
vol10=Entrada(3);
roa=Entrada(4);
rocm10=Entrada(5);
D=0.8;
L=0.25;
U=0.67;
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
rocm10= (Gs11-Gs10)/vol10;
Salida=[Gs10,rocm10]; 
end