function Salida= Gs4(Entrada)
Gs5=Entrada(1);
rocm5= Entrada(2);
rocm4= Entrada(3);
load('vol4.mat','vol4');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
A4=L*(s0+D*(1-cos(alfacm4)));
V4=U*cos(alfacm4);
Gs4=3600*V4*A4*rocm4;
rocm4= (Gs5-Gs4)/vol4;
Salida=[Gs4,rocm4];
end     