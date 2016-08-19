function Salida= Gs1b(Entrada)
rocm2=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm1=Entrada(7);
alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
A1=L*(s0+D*(1-cos(alfacm1)));
V1=U*cos(alfacm1);
Gs1=3600*V1*A1*rocm1;
Salida =[Gs1];
end