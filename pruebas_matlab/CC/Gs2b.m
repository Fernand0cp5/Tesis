function Salida= Gs2b(Entrada)
rocm3=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm2=Entrada(7);
alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
A2=L*(s0+D*(1-cos(alfacm2)));
V2=U*cos(alfacm2);
Gs2=3600*V2*A2*rocm2;
Salida =[Gs2];
end