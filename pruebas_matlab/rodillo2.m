function rodillo2
tiemporango=[0 100];
valoresiniciales=[2]; %valores iniciales para densidad 
[t,d]=ode45(@rodos, tiemporango, valoresiniciales);
plot(t,d);
t
d
xlabel('tiempo')
legend('ro')
end

function vectorode =rodos(t, vectorvariablesdep)
%definicion de variables dependientes
rocm=vectorvariablesdep(1);
%ecuaciones algebraicas
D=0.8;
L=0.25;
so=0.019;
roex = 0.85*2.74;
alfacm = acos((rocm*(so+D)-roex*so)/(rocm*D));
A=L*(so+D*(1-cos(alfacm)));
V=0.67*cos(alfacm);
%definicion ecuaciones diferenciales
drocmdt=(26.683353-3600*V*A*rocm)/3.80;
vectorode=[drocmdt];
end