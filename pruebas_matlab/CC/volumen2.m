% Volumen por bloque-------------
syms x
D=0.8;
s0=0.019;
L=0.25;
load ('h.mat','h');
load('Z.mat','Z');
a = 0;
bb = h;
c = 2*h;
d = 3*h;
e = 4*h;
f = 5*h;
g = 6*h;
hh = 7*h;
i = 8*h;
j = 9*h;
k = 10*h;
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
area1 = double(int(in2,'x',a,bb));
area2 = double(int(in2,'x',bb,c));
area3 = double(int(in2,'x',c,d));
area4 = double(int(in2,'x',d,e));
area5 = double(int(in2,'x',e,f));
area6 = double(int(in2,'x',f,g));
area7 = double(int(in2,'x',g,hh));
area8 = double(int(in2,'x',hh,i));
area9 = double(int(in2,'x',i,j));
area10 = double(int(in2,'x',j,k));
areat = double(int(in2,'x',a,Z));
vol1 = (L*area1)*1E6;
vol2 = (L*area2)*1E6;
vol3 = (L*area3)*1E6;
vol4 = (L*area4)*1E6;
vol5 = (L*area5)*1E6;
vol6 = (L*area6)*1E6;
vol7 = (L*area7)*1E6;
vol8 = (L*area8)*1E6;
vol9 = (L*area9)*1E6;
vol10 = (L*area10)*1E6
volt = (L*areat)*1E6;
[Resp] = [vol1 vol2 vol3 vol4 vol5 vol6 vol7 vol8 vol9 vol10 volt]
save('vol1.mat','vol1')
save('vol2.mat','vol2')
save('vol3.mat','vol3')
save('vol4.mat','vol4')
save('vol5.mat','vol5')
save('vol6.mat','vol6')
save('vol7.mat','vol7')
save('vol8.mat','vol8')
save('vol9.mat','vol9')
save('vol10.mat','vol10')
save('volt.mat','volt')

