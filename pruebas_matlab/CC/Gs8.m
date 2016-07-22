function Salida= Gs8(Entrada) 
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs9=Entrada(6);
rocm9=Entrada(7);
rocm8=Entrada(8);
load('vol8.mat','vol8');
alfacm8=acos((rocm9*(D+s0)-rocm8*s0)/(rocm9*D));
A8=L*(s0+D*(1-cos(alfacm8)));
V8=U*cos(alfacm8);
Gs8=3600*V8*A8*rocm8;
rocm8= (Gs9-Gs8)/vol8;
Salida=[Gs8,rocm8];
end