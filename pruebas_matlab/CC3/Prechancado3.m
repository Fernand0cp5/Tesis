function Salida=Prechancado3(Entrada)
s0=Entrada(1);
U=Entrada(2);
D=0.8; %Di�metro de los rodillos: D en [m]
L=0.25; %Largo de los rodillos: L en [m]
Rp=41; %Presion de operaci�n: Rp en [bar]
ros=2740; %Densidad del s�lido seco: ros en [kg/m3]
roa=1620; %Densidad aparente de la alimentaci�n: roa en [kg/m3]
roe=0.85*ros; %Densidad aparente enc zona de extrusi�n: roe en [kg/m3]
Gs11=roe*s0*L*U; % Tonalaje tratado: Gs en [kg/s]
F=100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�]
alfaIP=acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de la zona de chancado
Z=(D/2)*sin(alfaIP*pi/180);
P=1000*2*F*U*sin((alfaIP/2)*(pi/180));
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tama�o cr�tico: Xc en [mm]
Salida=[Xc,Gs11,P,Z];
end