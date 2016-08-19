function Salida=Gs8b(Entrada)
rocm9=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm8=Entrada(7);
alfacm8=acos((rocm9*(D+s0)-rocm8*s0)/(rocm9*D));
A8=L*(s0+D*(1-cos(alfacm8)));
V8=U*cos(alfacm8);
Gs8=3600*V8*A8*rocm8;
Salida=[Gs8];
end