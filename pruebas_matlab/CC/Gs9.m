function Salida=Gs9(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs10=Entrada(6);
rocm10=Entrada(7);
rocm9=Entrada(8);
load('vol9.mat','vol9');
alfacm9=acos((rocm10*(D+s0)-rocm9*s0)/(rocm10*D));
A9=L*(s0+D*(1-cos(alfacm9)));
V9=U*cos(alfacm9);
Gs9=3600*V9*A9*rocm9;
rocm9= (Gs10-Gs9)/vol9;
Salida=[Gs9,rocm9];
end     