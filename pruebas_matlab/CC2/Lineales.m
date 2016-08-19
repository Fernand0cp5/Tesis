function Salida=Lineales(Entrada)
D=Entrada(1);
L=Entrada(2);
s0=Entrada(3);
U=Entrada(4);
Rp=Entrada(5);
ros=Entrada(6);
roa=Entrada(7);
roe = 0.85*ros; %Densidad aparente enc zona de extrusión: roe en [t/m3]
Gs11 = 3600*roe*s0*L*U; % Tonalaje tratado: Gs en [ton/hora]
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresión zona de capas de partículas: alfaIP en [°]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de cada bloque (horizontal)
h = (D/2*sin(alfaIP*pi/180))/10;
Salida=[Gs11,alfaIP,h];
end