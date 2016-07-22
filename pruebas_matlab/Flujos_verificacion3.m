function Flujos_verificacion3
%tiemporango=[0 100000];
valoresiniciales=[2.25]; %valores iniciales para densidad 
[t,d]=ode1(@rodos,0,50, valoresiniciales,0.1);
t
d
figure(2)
plot(t,d), hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocm1')
end

function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('U.mat','U')
%definicion de variables dependientes
rocm1=vectorvariablesdep(1);
%ecuaciones algebraicas
D=0.8;
L=0.25;
s0=0.019;
%Angulo del centro de masa
alfacm1=acos((rocm1*(D+s0)-rocm1*s0)/(rocm1*D));
%Area perpendicular al flujo masico
A1=L*(s0+D*(1-cos(alfacm1)));
%Velocidad de la franja de material
V1=U*cos(alfacm1);
%Flujos
Gs1=3600*V1*A1*rocm1;
Gs6=26.683353;
%Ecuaciones diferenciales
drocm1dt= (Gs6-Gs1)/vol1;
vectorode=[drocm1dt];
figure(1)
plot(t,Gs1),hold on
V1
end