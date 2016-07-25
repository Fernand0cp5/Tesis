function Salida=Gs10a(Entrada) 
Gs11=Entrada(4);
D=Entrada(5);
L=Entrada(6);
s0=Entrada(7);
U=Entrada(8);
roa=Entrada(9);
rocm10=Entrada(10);
vol10=Entrada(11);
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
rocm10= (Gs11-Gs10)/vol10;
Salida=[Gs10,rocm10]; 
end

