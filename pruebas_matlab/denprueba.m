function denprueba
tiemporango=[0 10];
valoresiniciales=[1.62]; %valores iniciales para Fa, Fb, Fc, Fd, T
[t,den]=ode45(@dinamico, tiemporango, valoresiniciales);
plot(t,den);
xlabel('den')
legend('Fa','Fb','Fc','Fd','T(K)')
end

function vectorode =dinamico(t, vectorvariablesdep)
%definicion de variables dependientes
den=vectorvariablesdep(1);
%ecuaciones algebraicas
D = 0.8; %Diámetro de los rodillos: D en [m]
L = 0.25; %Largo de los rodillos: L en [m]
s0 = 0.019; %Gap operacional: s0 en [m]
U = 0.67; %Velocidad periférica de los rodillos: U en [m/s]
ros = 2.74; %Densidad del sólido seco: ros en [t/m3]
roa = 1.62; %Densidad aparente de la alimentación: roa en [t/m3]
roe = 0.85*ros;
Gs6 = 32.6;
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
h = (D/2*sin(alfaIP*pi/180))/5;
e = 4*h;
f = 5*h;
alfabajo = asin(e/(D/2));
sabajo = (s0+D*(1-cos(alfabajo)));
syms x
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
area5 = double(int(in2,'x',e,f));
vol5 = area5*L;
in1 = ((den*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0));
denabajo = double(int(in1,'x',e,f));
%definicion ecuaciones diferenciales
ddendt=(Gs6-(3600*U*L*sabajo*denabajo))/vol5;
vectorode =[ddendt];
end


