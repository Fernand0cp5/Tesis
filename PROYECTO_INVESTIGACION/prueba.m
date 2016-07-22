syms x
D = 0.8;
s0 = 0.019;
roe = 2.329;
roa = 1.62;
a = 0;
b = (0.4*sin(8.4150*pi/180))
%expden = ((roe*s0)/((D*(1-(sqrt((D/2)^2-b^2)/(D/2))))+s0))
in1 = (roe*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0)*(D/2+s0/2-sqrt((D/2)^2-x^2));
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));%((D/2)+(s0/2)-((D/2)*sqrt((D/2)^2-x^2)));
numden1 = double((int(in1,'x',a,b)))
denden2 = double((int(in2,'x',a,b)))
den1 = (numden1/denden2)
alfa1 = (acos((den1*(s0+D)-roe*s0)/(den1*D)))*180/pi
cen1 = (D/2)*sin(alfa1*pi/180)

%Expresi�on diferencial de �rea: (D/2+s0/2-sqrt((D/2)^2-x^2))
%(-2*sqrt((D/2)^2-x^2)+(2*(D/2)+s0))
%(roe*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0)