function Salida= Gs3(Entrada) 
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs4=Entrada(6);
rocm4=Entrada(7);
rocm3=Entrada(8);
load('vol3.mat','vol3');
alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
A3=L*(s0+D*(1-cos(alfacm3)));
V3=U*cos(alfacm3);
Gs3=3600*V3*A3*rocm3;
rocm3= (Gs4-Gs3)/vol3;
Salida=[Gs3,rocm3];
end