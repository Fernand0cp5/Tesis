function Salida=Gs10(Entrada) 
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
roa=Entrada(7);
Gs11=Entrada(8);
rocm10=Entrada(9);
vol10=Entrada(10);
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
rocm10= (Gs11-Gs10)/vol10;
Salida=[Gs10,rocm10]
end
