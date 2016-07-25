function Salida= Gs2a(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs3=Entrada(6);
rocm3=Entrada(7);
rocm2=Entrada(8);
vol2=Entrada(9);
alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
A2=L*(s0+D*(1-cos(alfacm2)));
V2=U*cos(alfacm2);
Gs2=3600*V2*A2*rocm2;
rocm2= (Gs3-Gs2)/vol2;
Salida =[Gs2,rocm2];
end