function Salida= Gs6b(Entrada)
rocm7=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm6=Entrada(7);
alfacm6=acos((rocm7*(D+s0)-rocm6*s0)/(rocm7*D));
A6=L*(s0+D*(1-cos(alfacm6)));
V6=U*cos(alfacm6);
Gs6=3600*V6*A6*rocm6;
Salida =[Gs6];
end