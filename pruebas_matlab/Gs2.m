function Salida= Gs2(Entrada)
Gs3=Entrada(1);
rocm3= Entrada(2);
rocm2= Entrada(3);
load('vol2.mat','vol2');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
A2=L*(s0+D*(1-cos(alfacm2)));
V2=U*cos(alfacm2);
Gs2=3600*V2*A2*rocm2;
rocm2= (Gs3-Gs2)/vol2;
Salida =[Gs2,rocm2];
end