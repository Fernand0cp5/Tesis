function Salida= Gs6a(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs7=Entrada(6);
rocm7=Entrada(7);
rocm6=Entrada(8);
vol6=Entrada(9);
alfacm6=acos((rocm7*(D+s0)-rocm6*s0)/(rocm7*D));
A6=L*(s0+D*(1-cos(alfacm6)));
V6=U*cos(alfacm6);
Gs6=3600*V6*A6*rocm6;
rocm6= (Gs7-Gs6)/vol6;
Salida =[Gs6,rocm6];
end