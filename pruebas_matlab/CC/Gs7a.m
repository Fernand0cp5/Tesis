function Salida= Gs7a(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs8=Entrada(6);
rocm8=Entrada(7);
rocm7=Entrada(8);
vol7=Entrada(9);
alfacm7=acos((rocm8*(D+s0)-rocm7*s0)/(rocm8*D));
A7=L*(s0+D*(1-cos(alfacm7)));
V7=U*cos(alfacm7);
Gs7=3600*V7*A7*rocm7;
rocm7= (Gs8-Gs7)/vol7;
Salida =[Gs7,rocm7];
end