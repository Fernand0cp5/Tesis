function Salida= Gs5(Entrada) 
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Gs6=Entrada(6);
rocm6=Entrada(7);
rocm5=Entrada(8);
load('vol5.mat','vol5');
alfacm5=acos((rocm6*(D+s0)-rocm5*s0)/(rocm6*D));
A5=L*(s0+D*(1-cos(alfacm5)));
V5=U*cos(alfacm5);
Gs5=3600*V5*A5*rocm5;
rocm5= (Gs6-Gs5)/vol5;
Salida=[Gs5,rocm5]; 
end