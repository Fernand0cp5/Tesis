function Salida= Gs1a(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs2=Entrada(6);
rocm2=Entrada(7);
rocm1=Entrada(8);
vol1=Entrada(9);
alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
A1=L*(s0+D*(1-cos(alfacm1)));
V1=U*cos(alfacm1);
Gs1=3600*V1*A1*rocm1;
rocm1= (Gs2-Gs1)/vol1;
Salida =[Gs1,rocm1];
end
