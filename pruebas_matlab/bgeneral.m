function bgeneral
tiemporango=[0 200];
valoresiniciales=[1.62]; %valores iniciales para Fa, Fb, Fc, Fd, T
[t,den]=ode45(@dinamico, tiemporango, valoresiniciales);
plot(t,den(9));
xlabel('tiempo')
legend('Densidad')
end

function vectorode =dinamico(t, vectorvariablesdep)
load('D.mat','D');
load('L.mat','L');
load('s0.mat','s0');
load('U.mat','U');
load('roe.mat','roe');
load('vol5.mat','vol5');
load('h.mat','h');
%definicion de variables dependientes
den=vectorvariablesdep(1);
%Ecuaciones algebraicas
Gs6 = 32.6;
e = 4*h;
f = 5*h;
alfabajo = asin(e/(D/2));
sabajo = (s0+D*(1-cos(alfabajo)));
%Calculo densidad
syms x
in1 = ((den*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0));
denabajo = double(int(in1,'x',e,f));
%definicion ecuaciones diferenciales
ddendt=(Gs6-(3600*U*L*sabajo*denabajo))/vol5;
vectorode =[ddendt];
end

