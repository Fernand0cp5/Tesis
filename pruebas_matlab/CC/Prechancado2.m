function Salida=Prechancado2(Entrada)
D = Entrada(1); %Diámetro de los rodillos: D en [m]
L = Entrada(2); %Largo de los rodillos: L en [m]
s0 = Entrada(3); %Gap operacional: s0 en [m]
U = Entrada(4); %Velocidad periférica de los rodillos: U en [m/s]
Rp = Entrada(5); %Presion de operación: Rp en [bar]
ros = Entrada(6); %Densidad del sólido seco: ros en [t/m3]
roa = Entrada(7); %Densidad aparente de la alimentación: roa en [t/m3]
n = Entrada(8);
%Tamaños de clases de partícula: X(i) en [mm] (13 mallas)
X(1) = 45; %tamaño 45.000 [mm]
X(2) = 31.5; %tamaño 31.500 [mm]
X(3) = 22.4; %tamaño 22.400 [mm]
X(4) = 16; %tamaño 16.000 [mm]
X(5) = 11.2; %tamaño 11.200 [mm]
X(6) = 8; %tamaño 8.000 [mm]
X(7) = 5.6; %tamaño 5.600 [mm]
X(8) = 2.8; %tamaño 2.800 [mm]
X(9) = 1; %tamaño 1.000 [mm]
X(10) = 0.5; %tamaño 0.500 [mm]
X(11) = 0.315; %tamaño 0.315 [mm]
X(12) = 0.2; %tamaño 0.200 [mm]
X(13) = 0.125; %tamaño 0.125 [mm]
Xt = X;
Salida=[Xt];
end