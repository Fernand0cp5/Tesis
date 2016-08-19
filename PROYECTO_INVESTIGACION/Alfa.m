function Salida=Alfa(Entrada)
D = 0.8; %Di�metro de los rodillos: D en [m]
s0=Entrada(1);
ros = 2.74; %Densidad del s�lido seco: ros en [t/m3]
roa = 1.62; %Densidad aparente de la alimentaci�n: roa en [t/m3]
roe = 0.85*ros; %Densidad aparente enc zona de extrusi�n: roe en [t/m3]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�];
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de cada bloque (horizontal)
h = (D/2*sin(alfaIP*pi/180))/2;
Salida=h;
end