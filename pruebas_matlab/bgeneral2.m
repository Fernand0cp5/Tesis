function bgeneral2
tiemporango=[0 100];
valoresiniciales=[0.8; 0.25; 0.019; 0.67; 2.329; 32.6; 3.8046e-5; 0.0117; 1.62]; %valores iniciales para Fa, Fb, Fc, Fd, T
[t,den]=ode45(@dinamico, tiemporango, valoresiniciales);
plot(t,den(9));
xlabel('tiempo')
legend('Densidad')
end

function vectorode =dinamico(t, vectorvariablesdep)
%definicion de variables dependientes
D=vectorvariablesdep(1);
L=vectorvariablesdep(2);
s0=vectorvariablesdep(3);
U=vectorvariablesdep(4);
roe=vectorvariablesdep(5);
Gs6=vectorvariablesdep(6);
vol5=vectorvariablesdep(7);
h=vectorvariablesdep(8);
den=vectorvariablesdep(9);
%Ecuaciones algebraicas
e = 4*h;
f = 5*h;
alfabajo = asin(e/(D/2));
sabajo = (s0+D*(1-cos(alfabajo)));
%Calculo densidad
syms x
in1 = ((den*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0));
denabajo = double(int(in1,'x',e,f));
%definicion ecuaciones diferenciales
dDdt=0;
dLdt=0;
ds0dt=0;
dUdt=0;
droedt=0;
dGs6dt=0;
dvol5dt=0;
dhdt=0;
ddendt=(Gs6-(3600*U*L*sabajo*denabajo))/vol5;
vectorode =[dDdt; dLdt; ds0dt; dUdt; droedt; dGs6dt;... 
           dvol5dt; dhdt; ddendt];
end
