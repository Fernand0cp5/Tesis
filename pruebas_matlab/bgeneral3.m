function bgeneral3
tiemporango=[0 100];
valoresiniciales=[1.62]; %valores iniciales para Fa, Fb, Fc, Fd, T
[t,den]=ode45(@dinamico, tiemporango, valoresiniciales);
plot(t,den);
xlabel('tiempo')
legend('Densidad')
end

function vectorode =dinamico(t, vectorvariablesdep)
%definicion de variables dependientes
den=vectorvariablesdep(1);
%Ecuaciones algebraicas
D = 0.8;
L = 0.25;
s0 = 0.019;
U = 0.67;
Gs6 = 32.6;
vol5 = 3.8046e-5;
h = 0.0117;
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
