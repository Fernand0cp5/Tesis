function Salida=Gs4b(Entrada)
rocm5=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm4=Entrada(7);
alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
A4=L*(s0+D*(1-cos(alfacm4)));
V4=U*cos(alfacm4);
Gs4=3600*V4*A4*rocm4;
Salida=[Gs4];
end   