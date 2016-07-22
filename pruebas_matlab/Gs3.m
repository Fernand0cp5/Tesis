function Salida= Gs3(Entrada) 
Gs4=Entrada(1);
rocm4= Entrada(2);
rocm3= Entrada(3);
load('vol3.mat','vol3');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
A3=L*(s0+D*(1-cos(alfacm3)));
V3=U*cos(alfacm3);
Gs3=3600*V3*A3*rocm3;
rocm3= (Gs4-Gs3)/vol3;
Salida=[Gs3,rocm3];
end