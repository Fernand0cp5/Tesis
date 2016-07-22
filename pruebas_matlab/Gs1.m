function Salida= Gs1(Entrada)
Gs2=Entrada(1);
rocm2= Entrada(2);
rocm1= Entrada(3);
load('vol1.mat','vol1');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
A1=L*(s0+D*(1-cos(alfacm1)));
V1=U*cos(alfacm1);
Gs1=3600*V1*A1*rocm1;
rocm1= (Gs2-Gs1)/vol1;
Salida =[Gs1,rocm1];
end
