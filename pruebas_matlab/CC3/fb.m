function Salida=fb(Entrada)
xin=Entrada(2);
Gsin=Entrada(14);
Gsout=Entrada(15);
rocm=Entrada(16);
vol=Entrada(17);
p(1)=Entrada(18);
P=Entrada(19);
Hk=rocm*vol;
k0b=87.7457696248338;
Eb=1.40605122040969;
x(1)=k0b*exp(-Eb/P);
xb=(Gsin*xin-Gsout*p(1)-Hk*p(1)*x(1))/Hk;
Salida=xb;
end