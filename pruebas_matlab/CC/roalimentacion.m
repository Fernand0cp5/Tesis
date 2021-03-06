%Variables de entrada
syms x
D=0.8;
s0=0.03;
L=0.25;
U=0.67;
ros = 2.74; %Densidad del s�lido seco: ros en [t/m3]
roe = 0.85*ros; %Densidad aparente enc zona de extrusi�n: roe en [t/m3]
roa=1.62;
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de cada bloque (horizontal)
h = (D/2*sin(alfaIP*pi/180))/20;
%Altura de la zona de chancado
a0 = 0;
a1=h;
a2=2*h;
a3=3*h;
a4=4*h;
a5=5*h;
a6=6*h;
a7=7*h;
a8=8*h;
a9=9*h;
a10=10*h;
a11=11*h;
a12=12*h;
a13=13*h;
a14=14*h;
a15=15*h;
a16=16*h;
a17=17*h;
a18=18*h;
a19=19*h;
a20=20*h;
in1 = ((roe*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0))*(D/2+s0/2-sqrt((D/2)^2-x^2));
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
denume1 = double(int(in1,'x',a0,a1));
dendeno1 = double(int(in2,'x',a0,a1));
denume2 = double(int(in1,'x',a1,a2));
dendeno2 = double(int(in2,'x',a1,a2));
denume3 = double(int(in1,'x',a2,a3));
dendeno3 = double(int(in2,'x',a2,a3));
denume4 = double(int(in1,'x',a3,a4));
dendeno4 = double(int(in2,'x',a3,a4));
denume5 = double(int(in1,'x',a4,a5));
dendeno5 = double(int(in2,'x',a4,a5));
denume6 = double(int(in1,'x',a5,a6));
dendeno6 = double(int(in2,'x',a5,a6));
denume7 = double(int(in1,'x',a6,a7));
dendeno7 = double(int(in2,'x',a6,a7));
denume8 = double(int(in1,'x',a7,a8));
dendeno8 = double(int(in2,'x',a7,a8));
denume9 = double(int(in1,'x',a8,a9));
dendeno9 = double(int(in2,'x',a8,a9));
denume10 = double(int(in1,'x',a9,a10));
dendeno10 = double(int(in2,'x',a9,a10));
denume11 = double(int(in1,'x',a10,a11));
dendeno11 = double(int(in2,'x',a10,a11));
denume12 = double(int(in1,'x',a11,a12));
dendeno12 = double(int(in2,'x',a11,a12));
denume13 = double(int(in1,'x',a12,a13));
dendeno13 = double(int(in2,'x',a12,a13));
denume14 = double(int(in1,'x',a13,a14));
dendeno14 = double(int(in2,'x',a13,a14));
denume15 = double(int(in1,'x',a14,a15));
dendeno15 = double(int(in2,'x',a14,a15));
denume16 = double(int(in1,'x',a15,a16));
dendeno16 = double(int(in2,'x',a15,a16));
denume17 = double(int(in1,'x',a16,a17));
dendeno17 = double(int(in2,'x',a16,a17));
denume18 = double(int(in1,'x',a17,a18));
dendeno18 = double(int(in2,'x',a17,a18));
denume19 = double(int(in1,'x',a18,a19));
dendeno19 = double(int(in2,'x',a18,a19));
denume20 = double(int(in1,'x',a19,a20));
dendeno20 = double(int(in2,'x',a19,a20));
den1 = (denume1/dendeno1);
den2 = (denume2/dendeno2);
den3 = (denume3/dendeno3);
den4 = (denume4/dendeno4);
den5 = (denume5/dendeno5);
den6 = (denume6/dendeno6);
den7 = (denume7/dendeno7);
den8 = (denume8/dendeno8);
den9 = (denume9/dendeno9);
den10 = (denume10/dendeno10);
den11 = (denume11/dendeno11);
den12 = (denume12/dendeno12);
den13 = (denume13/dendeno13);
den14 = (denume14/dendeno14);
den15 = (denume15/dendeno15);
den16 = (denume16/dendeno16);
den17 = (denume17/dendeno17);
den18 = (denume18/dendeno18);
den19 = (denume19/dendeno19);
den20 = (denume20/dendeno20);


Gs6 = 3600*den1*s0*L*U % Tonalaje tratado: Gs en [ton/hora]


[ RES ] = [den1 den2 den3 den4 den5 den6 den7 den8 den9 den10...
           den11 den12 den13 den14 den15 den16 den17 den18 den19 den20]

