function Salida=Gs9(Entrada)
Gs10=Entrada(1);
rocm10=Entrada(2);
rocm9=Entrada(3);
U=Entrada(4);
D=0.8;
L=0.25;
s0=Entrada(5);
vol9=Entrada(6);
alfacm9=acos((rocm10*(D+s0)-rocm9*s0)/(rocm10*D));
A9=L*(s0+D*(1-cos(alfacm9)));
V9=U*cos(alfacm9);
Gs9=3600*V9*A9*rocm9;
rocm9= (Gs10-Gs9)/vol9;
Salida=[Gs9,rocm9];
end     