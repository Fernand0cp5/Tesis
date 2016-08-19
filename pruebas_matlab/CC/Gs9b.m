function Salida=Gs9b(Entrada)
rocm10=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm9=Entrada(7);
alfacm9=acos((rocm10*(D+s0)-rocm9*s0)/(rocm10*D));
A9=L*(s0+D*(1-cos(alfacm9)));
V9=U*cos(alfacm9);
Gs9=3600*V9*A9*rocm9;
Salida=[Gs9];
end     