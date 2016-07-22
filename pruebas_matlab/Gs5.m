function Salida= Gs5(rocm5) 
load('vol5.mat','vol5');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
load('roa.mat','roa');
load('Gs6.mat','Gs6');
alfacm5 = acos((roa*(D+s0)-rocm5*s0)/(roa*D));
A5 = L*(s0+D*(1-cos(alfacm5)));
V5 = U*cos(alfacm5);
Gs5=3600*V5*A5*rocm5;
rocm5=(Gs6-Gs5)/vol5;
Salida=[Gs5,rocm5]; 
end