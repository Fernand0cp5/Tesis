function Salida=Prechancado3(Entrada)
s0=Entrada(1);
ros=2740; %Densidad del sólido seco: ros en [kg/m3]
roa=1620; %Densidad aparente de la alimentación: roa en [kg/m3]
roe=0.85*ros; %Densidad aparente enc zona de extrusión: roe en [kg/m3]
D=0.8; %Diámetro de los rodillos: D en [m]
%Angulo de compresión zona de capas de partículas: alfaIP en [°]
alfaIP=acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de la zona de chancado
Z=(D/2)*sin(alfaIP*pi/180);
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tamaño crítico: Xc en [mm]
Salida=[alfaIP,Z,Xc];
end