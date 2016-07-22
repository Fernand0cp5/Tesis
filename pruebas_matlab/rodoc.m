function rodoc
tiemporango=[0 2000];
valoresiniciales=[1; 1; 1; 1; 1]; %valores iniciales para densidad 
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
rocm3=vectorvariablesdep(3);
rocm4=vectorvariablesdep(4);
rocm5=vectorvariablesdep(5);
%ecuaciones algebraicas
D=0.8;
L=0.25;
so=0.019;
alfacm1=acos((rocm1*(D+so)-rocm1*so)/(rocm1*D));
alfacm2=acos((rocm2*(D+so)-rocm1*so)/(rocm2*D));
alfacm3=acos((rocm3*(D+so)-rocm1*so)/(rocm3*D));
alfacm4=acos((rocm4*(D+so)-rocm1*so)/(rocm4*D));
alfacm5=acos((rocm5*(D+so)-rocm1*so)/(rocm5*D));
%alfacm=7.5842*pi/180;
A1=L*(so+D*(1-cos(alfacm1)));
A2=L*(so+D*(1-cos(alfacm2)));
A3=L*(so+D*(1-cos(alfacm3)));
A4=L*(so+D*(1-cos(alfacm4)));
A5=L*(so+D*(1-cos(alfacm5)));
V1=0.67*cos(alfacm1);
V2=0.67*cos(alfacm2);
V3=0.67*cos(alfacm3);
V4=0.67*cos(alfacm4);
V5=0.67*cos(alfacm5);
%definicion ecuaciones diferenciales
dfadv1=(3600*V2*A2*rocm2-3600*V1*A1*rocm1)/27.9721;
dfadv2=(3600*V3*A3*rocm3-3600*V2*A2*rocm2)/28.9756;
dfadv3=(3600*V4*A4*rocm4-3600*V3*A3*rocm3)/30.9853;
dfadv4=(3600*V5*A5*rocm5-3600*V4*A4*rocm4)/34.0063;
dfadv5=(26.68-3600*V5*A5*rocm5)/38.0465;

vectorode=[dfadv1; dfadv2; dfadv3; dfadv4; dfadv5];
end