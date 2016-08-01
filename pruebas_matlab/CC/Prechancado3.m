function Salida=Prechancado3(Entrada)
D = Entrada(1); %Di�metro de los rodillos: D en [m]
L = Entrada(2); %Largo de los rodillos: L en [m]
s0 = Entrada(3); %Gap operacional: s0 en [m]
U = Entrada(4); %Velocidad perif�rica de los rodillos: U en [m/s]
Rp = Entrada(5); %Presion de operaci�n: Rp en [bar]
ros = Entrada(6); %Densidad del s�lido seco: ros en [t/m3]
roa = Entrada(7); %Densidad aparente de la alimentaci�n: roa en [t/m3]
n = Entrada(8);
roe = 0.85*ros; %Densidad aparente enc zona de extrusi�n: roe en [t/m3]
Gs11 = 3600*roe*s0*L*U; % Tonalaje tratado: Gs en [ton/hora]
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de cada bloque (horizontal)
h = (D/2*sin(alfaIP*pi/180))/10;
%Altura de la zona de chancado
Z = (D/2)*sin(alfaIP*pi/180);
P = 2*F*U*sin((alfaIP/2)*(pi/180));
Salida=[P,h,alfaIP,Gs11];
end