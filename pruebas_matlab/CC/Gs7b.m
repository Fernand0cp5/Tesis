function Salida= Gs7b(Entrada)
rocm8=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm7=Entrada(7);
alfacm7=acos((rocm8*(D+s0)-rocm7*s0)/(rocm8*D));
A7=L*(s0+D*(1-cos(alfacm7)));
V7=U*cos(alfacm7);
Gs7=3600*V7*A7*rocm7;
Salida =[Gs7];
end