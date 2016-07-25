function Salida=Gs4a(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs5=Entrada(6);
rocm5=Entrada(7);
rocm4=Entrada(8);
vol4=Entrada(9);
alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
A4=L*(s0+D*(1-cos(alfacm4)));
V4=U*cos(alfacm4);
Gs4=3600*V4*A4*rocm4;
rocm4= (Gs5-Gs4)/vol4;
Salida=[Gs4,rocm4];
end   