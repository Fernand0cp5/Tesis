function rod_general
tiemporango=[0 0.1];
valoresiniciales=[1; 1; 1; 1; 1]; %valores iniciales para densidad 
[t,d]=ode45(@rodos, tiemporango, valoresiniciales);
plot(t,d);
d
t
xlabel('tiempo')
legend('ro')
end

function vectorode =rodos(t, vectorvariablesdep)
load('vol5.mat','vol5')
load('vol4.mat','vol4')
load('vol3.mat','vol3')
load('vol2.mat','vol2')
load('vol1.mat','vol1')
load('h.mat','h')
%definicion de variables dependientes
rocm1=vectorvariablesdep(1);
rocm2=vectorvariablesdep(2);
rocm3=vectorvariablesdep(3);
rocm4=vectorvariablesdep(4);
rocm5=vectorvariablesdep(5);
%ecuaciones algebraicas
D=0.8;
L=0.25;
s0=0.019;
Gs6 = 26.683353;
U = 0.67;
a = 0;
b = h;
c = 2*h;
d = 3*h;
e = 4*h;
f = 5*h;
%Densidad del centro de masa
syms x
in1 = ((rocm1*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0))*(D/2+s0/2-sqrt((D/2)^2-x^2));
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
denume1 = double(int(in1,'x',a,b));
dendeno1 = double(int(in2,'x',a,b));
rocm1= (denume1/dendeno1);%Densidad del cm bloque 1
denume2 = double(int(in1,'x',b,c));
dendeno2 = double(int(in2,'x',b,c));
rocm2= (denume2/dendeno2);%Densidad del cm bloque 2
denume3 = double(int(in1,'x',c,d));
dendeno3 = double(int(in2,'x',c,d));
rocm3= (denume3/dendeno3);%Densidad del cm bloque 3
denume4 = double(int(in1,'x',d,e));
dendeno4 = double(int(in2,'x',d,e));
rocm4= (denume4/dendeno4);%Densidad del cm bloque 4
denume5 = double(int(in1,'x',e,f));
dendeno5 = double(int(in2,'x',e,f));
rocm5= (denume5/dendeno5);%Densidad del cm bloque 5
%Angulo del centro de masa
alfa1= acos((rocm1*(s0+D)-rocm1*s0)/(rocm1*D));
alfa2= acos((rocm2*(s0+D)-rocm1*s0)/(rocm2*D));
alfa3= acos((rocm3*(s0+D)-rocm1*s0)/(rocm3*D));
alfa4= acos((rocm4*(s0+D)-rocm1*s0)/(rocm4*D));
alfa5= acos((rocm5*(s0+D)-rocm1*s0)/(rocm5*D));
%Area perpendicular al flujo masico
A1 = L*(s0+D*(1-cos(alfa1)));
A2 = L*(s0+D*(1-cos(alfa2)));
A3 = L*(s0+D*(1-cos(alfa3)));
A4 = L*(s0+D*(1-cos(alfa4)));
A5 = L*(s0+D*(1-cos(alfa5)));
%Velocidad de la franja de material
v1 = U*cos(alfa1);
v2 = U*cos(alfa2);
v3 = U*cos(alfa3);
v4 = U*cos(alfa4);
v5 = U*cos(alfa5);
%definicion ecuaciones diferenciales
drocm1dt=(3600*(v2*A2*rocm2-v1*A1*rocm1))/vol1;
drocm2dt=(3600*(v3*A3*rocm3-v2*A2*rocm2))/vol2;
drocm3dt=(3600*(v4*A4*rocm4-v3*A3*rocm3))/vol3;
drocm4dt=(3600*(v5*A5*rocm5-v4*A4*rocm4))/vol4;
drocm5dt=(Gs6-3600*v5*A5*rocm5)/vol5;
vectorode=[drocm1dt; drocm2dt; drocm3dt; drocm4dt; drocm5dt];
end