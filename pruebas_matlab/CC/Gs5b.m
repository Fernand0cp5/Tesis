function Salida= Gs5b(Entrada) 
rocm6=Entrada(1);
D=Entrada(2);
L=Entrada(3);
s0=Entrada(4);
U=Entrada(5);
rocm5=Entrada(7);
alfacm5=acos((rocm6*(D+s0)-rocm5*s0)/(rocm6*D));
A5=L*(s0+D*(1-cos(alfacm5)));
V5=U*cos(alfacm5);
Gs5=3600*V5*A5*rocm5;
Salida=[Gs5]; 
end