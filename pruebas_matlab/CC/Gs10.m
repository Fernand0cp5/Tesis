function Salida=Gs10(Entrada) 
Gs11=Entrada(30);
D=Entrada(31);
L=Entrada(32);
s0=Entrada(33);
U=Entrada(34);
roa=Entrada(35);
rocm10=Entrada(36);
load('vol10.mat','vol10');
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
rocm10= (Gs11-Gs10)/vol10;
Salida=[Gs10,rocm10]; 
end
