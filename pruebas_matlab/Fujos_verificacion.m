function Flujos_verificacion
tiemporango=[0 100000];
valoresiniciales=[2.25; 2.25; 2.25; 2.25; 2.25]; %valores iniciales para densidad 
[t,d]=ode45(@rodos, tiemporango, valoresiniciales);
t
d
figure(2)
plot(t,d(1),'r',t,d(2),'g',t,d(3),'b',t,d(4),'m',t,d(5),'k'), hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocm1','rocm2','rocm3','rocm4','rocm5')
end

function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('vol2.mat','vol2');
load('vol3.mat','vol3');
load('vol4.mat','vol4');
load('vol5.mat','vol5');

load('U.mat','U')
%definicion de variables dependientes
rocm1=vectorvariablesdep(1);
rocm2=vectorvariablesdep(2);
rocm3=vectorvariablesdep(3);
rocm4=vectorvariablesdep(4);
rocm5=vectorvariablesdep(5);
%ecuaciones algebraicas
D=0.8;
L=0.25;
s0=0.019;
%Angulo del centro de masa
alfacm1=acos((rocm1*(D+s0)-rocm1*s0)/(rocm1*D));
alfacm2=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
alfacm3=acos((rocm3*(D+s0)-rocm1*s0)/(rocm3*D));
alfacm4=acos((rocm4*(D+s0)-rocm1*s0)/(rocm4*D));
alfacm5=acos((rocm5*(D+s0)-rocm1*s0)/(rocm5*D));
%Area perpendicular al flujo masico
A1=L*(s0+D*(1-cos(alfacm1)));
A2=L*(s0+D*(1-cos(alfacm2)));
A3=L*(s0+D*(1-cos(alfacm3)));
A4=L*(s0+D*(1-cos(alfacm4)));
A5=L*(s0+D*(1-cos(alfacm5)));
%Velocidad de la franja de material
V1=U*cos(alfacm1);
V2=U*cos(alfacm2);
V3=U*cos(alfacm3);
V4=U*cos(alfacm4);
V5=U*cos(alfacm5);
%Flujos
Gs5=3600*V5*A5*rocm5;
Gs4=3600*V4*A4*rocm4;
Gs3=3600*V3*A3*rocm3;
Gs2=3600*V2*A2*rocm2;
Gs1=3600*V1*A1*rocm1;
Gs6=26.683353;
%Ecuaciones diferenciales
drocm1dt= (Gs2-Gs1)/vol1;
drocm2dt= (Gs3-Gs2)/vol2;
drocm3dt= (Gs4-Gs3)/vol3;
drocm4dt= (Gs5-Gs4)/vol4;
drocm5dt= (Gs6-Gs5)/vol5;
vectorode=[drocm1dt; drocm2dt; drocm3dt; drocm4dt; drocm5dt];
figure(1)
plot(t,Gs5,t,Gs4,t,Gs3,t,Gs2,t,Gs1),hold on
end