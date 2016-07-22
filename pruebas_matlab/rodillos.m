function rodillos
tiemporango=[0 10000];
valoresiniciales=[2.25; 2.25]; %valores iniciales para densidad 
[v,f]=ode45(@rodos, tiemporango, valoresiniciales);
plot(v,f);
v
f
xlabel('tiempo')
legend('ro')
end

function vectorode =rodos(v, vectorvariablesdep)
%definicion de variables dependientes
rocm1=vectorvariablesdep(1);
rocm2=vectorvariablesdep(2);
%ecuaciones algebraicas
D=0.8;
L=0.25;
so=0.019;
roext=0.85*2.74;
alfacm1=acos((rocm1*(D+so)-rocm1*so)/(rocm1*D));
alfacm2=acos((rocm2*(D+so)-rocm1*so)/(rocm2*D));
%alfacm=7.5842*pi/180;
A1=L*(so+D*(1-cos(alfacm1)));
A2=L*(so+D*(1-cos(alfacm2)));
V1=0.67*cos(alfacm1);
V2=0.67*cos(alfacm2);



%definicion ecuaciones diferenciales
dfadv1=(3600*V2*A2*rocm2-3600*V1*A1*rocm1)/3.8;
dfadv2=(26.68-3600*V2*A2*rocm2)/3.8;
vectorode=[dfadv1; dfadv2];
end