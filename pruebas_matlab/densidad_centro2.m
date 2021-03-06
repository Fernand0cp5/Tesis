%Variables de entrada
syms x
alfaIP = 8.4150*pi/180;
a = 0;
b = 0.01;
c = 0.02;
d = 0.03;
e = 0.04;
f = D/2*sin(alfaIP);
in1 = ((roe*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0))*(D/2+s0/2-sqrt((D/2)^2-x^2));
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
denume1 = double(int(in1,'x',a,b));
dendeno1 = double(int(in2,'x',a,b));
denume2 = double(int(in1,'x',b,c));
dendeno2 = double(int(in2,'x',b,c));
denume3 = double(int(in1,'x',c,d));
dendeno3 = double(int(in2,'x',c,d));
denume4 = double(int(in1,'x',d,e));
dendeno4 = double(int(in2,'x',d,e));
denume5 = double(int(in1,'x',e,f));
dendeno5 = double(int(in2,'x',e,f));
den1 = (denume1/dendeno1);
den2 = (denume2/dendeno2);
den3 = (denume3/dendeno3);
den4 = (denume4/dendeno4);
den5 = (denume5/dendeno5);
alfa1= (acos((den1*(s0+D)-roe*s0)/(den1*D)))*180/pi;
alfa2= (acos((den2*(s0+D)-roe*s0)/(den2*D)))*180/pi;
alfa3= (acos((den3*(s0+D)-roe*s0)/(den3*D)))*180/pi;
alfa4= (acos((den4*(s0+D)-roe*s0)/(den4*D)))*180/pi;
alfa5= (acos((den5*(s0+D)-roe*s0)/(den5*D)))*180/pi;
cen1 = (D/2)*sin(alfa1*pi/180);
cen2 = (D/2)*sin(alfa2*pi/180);
cen3 = (D/2)*sin(alfa3*pi/180);
cen4 = (D/2)*sin(alfa4*pi/180);
cen5 = (D/2)*sin(alfa5*pi/180);
v1 = U*cos(alfa1*pi/180);
v2 = U*cos(alfa2*pi/180);
v3 = U*cos(alfa3*pi/180);
v4 = U*cos(alfa4*pi/180);
v5 = U*cos(alfa5*pi/180);
s1 = s0+D*(1-cos(alfa1*pi/180));
s2 = s0+D*(1-cos(alfa2*pi/180));
s3 = s0+D*(1-cos(alfa3*pi/180));
s4 = s0+D*(1-cos(alfa4*pi/180));
s5 = s0+D*(1-cos(alfa5*pi/180));
A1 = L*s1;
A2 = L*s2;
A3 = L*s3;
A4 = L*s4;
A5 = L*s5;
Gs1 = 3600*den1*A1*v1;
Gs2 = 3600*den2*A2*v2;
Gs3 = 3600*den3*A3*v3;
Gs4 = 3600*den4*A4*v4;
Gs5 = 3600*den5*A5*v5;
[ RES ] = [den1 den2 den3 den4 den5 alfa1 alfa2 alfa3 alfa4 alfa5 cen1 cen2 cen3 cen4 cen5 Gs1 Gs2 Gs3 Gs4 Gs5]


%densidad_centro (alfaIP, D, s0, roe, roa, U, L)
%(0.4+0.019/2-0.4*cos(x))*(0.4*cos(x))
%((2.329*0.019)/(0.019+0.8*(1-cos(x))))*(0.4+0.019/2-0.4*cos(x))*(0.4*cos(x))
%http://www.wolframalpha.com/widgets/view.jsp?id=7492f93203fe47ae852cfe399a
%8955ff
%expresion diferencial de area: (D/2+s0/2-sqrt((D/2)^2-x^2))
%densidad (roe*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0)