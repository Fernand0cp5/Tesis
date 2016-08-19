function Salida= Gs3b(Entrada) 
rocm4=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm3=Entrada(7);
alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
A3=L*(s0+D*(1-cos(alfacm3)));
V3=U*cos(alfacm3);
Gs3=3600*V3*A3*rocm3;
Salida=[Gs3];
end