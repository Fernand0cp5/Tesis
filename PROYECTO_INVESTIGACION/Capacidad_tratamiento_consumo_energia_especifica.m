function [ RES ] = Capacidad_tratamiento_consumo_energia_especifica(x)
%Submodelo 1 y 2: Capacidad de tratamiento (1) y Consumo de energ�a
%espec�fica
%Variables de entrada:
D = x(1); %Di�metro de los rodillos: D en [m]
L = x(2); %Largo de los rodillos: L en [m]
s0 = x(3); %Gap operacional: s0 en [m]
U = x(4); %Velocidad perif�rica de los rodillos: U en [m/s]
Rp = x(5); %Presion de operaci�n: Rp en [bar]
ros = x(6); %Densidad del s�lido seco: ros en [t/m3]
roa = x(7); %Densidad aparente de la alimentaci�n: roa en [t/m3]
roe = 0.85*ros; %Densidad aparente enc zona de extrusi�n: roe en [t/m3]
%Submodelo 1: Capacidad de tratamiento HPGR, Gs
Gs = 3600*roe*s0*L*U % Tonalaje tratado: Gs en [ton/hora]
%Otras variables a estimar:
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi
P = 2*F*U*sin((alfaIP/2)*(pi/180))%Potencia: P en [kW]
%Submodelo 2: Consumo de energ�a espec�fica HPGR (CEE), W
W = P/Gs; %W en [kWh/ton]
%Tama�o cr�tico previo a zona de compresi�n de capas de part�culas, Xc
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tama�o cr�tico: Xc en [mm]
[ RES ] = [roe W Gs alfaIP P U L D Xc];
end


%%0.8	0.25 0.019 0.67 41 2.74 1.62
