function Salida=fk(Entrada)
xin=Entrada(11);
Gsin=Entrada(14);
Gsout=Entrada(15);
rocm=Entrada(16);
vol=Entrada(17);
p(1)=Entrada(18);
p(2)=Entrada(19);
p(3)=Entrada(20);
p(4)=Entrada(21);
p(5)=Entrada(22);
p(6)=Entrada(23);
p(7)=Entrada(24);
p(8)=Entrada(25);
p(9)=Entrada(26);
p(10)=Entrada(27);
P=Entrada(28);
Hk=rocm*vol;
k0b=87.7457696248338;
k0c=141.029744964245;
k0d=71.4294606149581;
k0e=41.3066717870455;
k0f=25.2122982702647;
k0g=12.5629663251887;
k0h=2.04950853081263;
k0i=0.634669866657347;
k0j=0.491511624014426;
k0k=0.411246294227835;
Eb=1.40605122040969;
Ec=1.85185098278557;
Ed=1.31155513877292;
Ee=1.18881489358611;
Ef=1.15067347312727;
Eg=1.1340803433176;
Eh=1.12939048943927;
Ei=1.12578915167814;
Ej=1.12838386172401;
Ek=1.12711394072794;
x(1)=k0b*exp(-Eb/P);
x(2)=k0c*exp(-Ec/P);
x(3)=k0d*exp(-Ed/P);
x(4)=k0e*exp(-Ee/P);
x(5)=k0f*exp(-Ef/P);
x(6)=k0g*exp(-Eg/P);
x(7)=k0h*exp(-Eh/P);
x(8)=k0i*exp(-Ei/P);
x(9)=k0j*exp(-Ej/P);
x(10)=k0k*exp(-Ek/P);
xk=(Gsin*xin-Gsout*p(10)+Hk*p(1)*x(1)*0.0057+Hk*p(2)*x(2)*0.0080+Hk*p(3)*x(3)*0.0139+Hk*p(4)*x(4)*0.0167+Hk*p(5)*x(5)*0.0119+Hk*p(6)*x(6)*0.0101+Hk*p(7)*x(7)*0.0216+Hk*p(8)*x(8)*0.1084+Hk*p(9)*x(9)*0.7474-Hk*p(10)*x(10))/Hk;
Salida=xk;
end