function Flujos_verificacionok
%tiemporango=[0 100000];
valoresiniciales=[1.9]; %valores iniciales para densidad 
[t,d]=ode1(@rodos,0,60,valoresiniciales,0.1);
t
d
figure(2)
plot(t,d), hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocm1')
end

function vectorode =rodos(t, vectorvariablesdep)
load('volt.mat','volt');
load('U.mat','U')
load('D.mat','D')
load('L.mat','L')
load('s0.mat','s0')
load('roa.mat','roa')
load('Gs6.mat','Gs6')
%definicion de variables dependientes
rocm1=vectorvariablesdep(1);
%Angulo del centro de masa
alfacm1=acos((roa*(D+s0)-rocm1*s0)/(roa*D));
%Area perpendicular al flujo masico
A1=L*(s0+D*(1-cos(alfacm1)));
%Velocidad de la franja de material
V1=U*cos(alfacm1);
%Flujos
Gs1=3600*V1*A1*rocm1;
%Ecuaciones diferenciales
drocm1dt= (Gs6-Gs1)/volt;
vectorode=[drocm1dt];
figure(1)
plot(t,Gs1),hold on
end