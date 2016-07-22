function Flujos_verificacionok
%tiemporango=[0 100000];
valoresiniciales=[1.9;1.9;1.9;1.9;1.9]; %valores iniciales para densidad 
[t,d]=ode1(@rodos,0,30,valoresiniciales,1);
t
d
figure(2)
plot(t,d), hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocm5','rocm4','rocm3','rocm2','rocm1')
end

function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('vol2.mat','vol2');
load('vol3.mat','vol3');
load('vol4.mat','vol4');
load('vol5.mat','vol5');
load('U.mat','U')
load('D.mat','D')
load('L.mat','L')
load('s0.mat','s0')
load('roa.mat','roa')
load('Gs6.mat','Gs6')
%definicion de variables dependientes
rocm5=vectorvariablesdep(1);
rocm4=vectorvariablesdep(2);
rocm3=vectorvariablesdep(3);
rocm2=vectorvariablesdep(4);
rocm1=vectorvariablesdep(5);
%Angulo del centro de masa
alfacm5=acos((roa*(D+s0)-rocm5*s0)/(roa*D));
alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
%Area perpendicular al flujo masico
A5=L*(s0+D*(1-cos(alfacm5)));
A4=L*(s0+D*(1-cos(alfacm4)));
A3=L*(s0+D*(1-cos(alfacm3)));
A2=L*(s0+D*(1-cos(alfacm2)));
A1=L*(s0+D*(1-cos(alfacm1)));
%Velocidad de la franja de material
V5=U*cos(alfacm5);
V4=U*cos(alfacm4);
V3=U*cos(alfacm3);
V2=U*cos(alfacm2);
V1=U*cos(alfacm1);
%Flujos
Gs5=3600*V5*A5*rocm5;
Gs4=3600*V4*A4*rocm4;
Gs3=3600*V3*A3*rocm3;
Gs2=3600*V2*A2*rocm2;
Gs1=3600*V1*A1*rocm1;
%Ecuaciones diferenciales
drocm5dt= (Gs6-Gs5)/vol5;
drocm4dt= (Gs5-Gs4)/vol4;
drocm3dt= (Gs4-Gs3)/vol3;
drocm2dt= (Gs3-Gs2)/vol2;
drocm1dt= (Gs2-Gs1)/vol1;
vectorode=[drocm5dt;drocm4dt;drocm3dt;drocm2dt;drocm1dt];
figure(1)
plot(t,Gs5,t,Gs4,t,Gs3,t,Gs2,t,Gs1),hold on
Gs3
end