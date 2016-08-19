function Salida=Gs(Entrada) 
roa=Entrada(1);
s0=Entrada(2);
U=Entrada(3);
Gsin=Entrada(4);
vol=Entrada(5);
rocm=Entrada(6);
D=0.8;
L=0.25;
alfacm=acos((roa*(D+s0)-rocm*s0)/(roa*D));
A=L*(s0+D*(1-cos(alfacm)));
V=U*cos(alfacm);
Gsout=V*A*rocm;
rocm=(Gsin-Gsout)/vol;
Salida=[Gsout,rocm]; 
end

