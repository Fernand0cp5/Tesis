function Salida=Gs10b(Entrada) 
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
roa=Entrada(5);
rocm10=Entrada(6);
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
Salida=[Gs10]; 
end

