function lisethchacon
volumenrango=[0 20];
valoresiniciales=[250; 0; 25; 0; 298]; %valores iniciales para Fa, Fb, Fc, Fd, T
[v,f]=ode45(@liseth, volumenrango, valoresiniciales);
plot(v,f);
v
f
xlabel('volumen')
legend('Fa','Fb','Fc','Fd','T(K)')
end

function vectorode =liseth(v, vectorvariablesdep)
%definicion de variables dependientes
Fa=vectorvariablesdep(1);
Fb=vectorvariablesdep(2);
Fc=vectorvariablesdep(3);
Fd=vectorvariablesdep(4);
T=vectorvariablesdep(5);
%ecuaciones algebraicas
Ct0=2;
k10=20;
k20=1;
Ea1=-1000;
Ea2=-10000;
R=8.314;
T0=298;
T01=300;
T02=500;
%Vt=20;
Finerte=100;
k1=k10*exp((Ea1/R)*((1/T01)-(1/T)));
k2=k20*exp((Ea2/R)*((1/T02)-(1/T)));
Ft=Fa+Fb+Fc+Fd;
Ca=Ct0*(Fa/Ft)*(T0/T);
Cb=Ct0*(Fb/Ft)*(T0/T);
Cc=Ct0*(Fc/Ft)*(T0/T);
Cd=Ct0*(Fd/Ft)*(T0/T);
ra=-k1*Ca*Cc;
rb=k1*Ca*Cc-k2*Cb;
rc=-k1*Ca*Cc;
rd=k2*Cb;
%definicion ecuaciones diferenciales
dfadv=ra;
dfcdv=rc;
dfbdv=rb;
dfddv=rd;
dtdv=((-ra)*10000+(rd)*71500)/(100*Fa*90*Fc+81*Fb+110*Fd+20*Finerte);
vectorode=[dfadv; dfbdv; dfcdv; dfddv; dtdv];
end

