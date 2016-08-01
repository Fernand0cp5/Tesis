function Salida=Prechancado2(Entrada)
D = Entrada(1); %Di�metro de los rodillos: D en [m]
L = Entrada(2); %Largo de los rodillos: L en [m]
s0 = Entrada(3); %Gap operacional: s0 en [m]
U = Entrada(4); %Velocidad perif�rica de los rodillos: U en [m/s]
Rp = Entrada(5); %Presion de operaci�n: Rp en [bar]
ros = Entrada(6); %Densidad del s�lido seco: ros en [t/m3]
roa = Entrada(7); %Densidad aparente de la alimentaci�n: roa en [t/m3]
n = Entrada(8);
%Tama�os de clases de part�cula: X(i) en [mm] (13 mallas)
X(1) = 45; %tama�o 45.000 [mm]
X(2) = 31.5; %tama�o 31.500 [mm]
X(3) = 22.4; %tama�o 22.400 [mm]
X(4) = 16; %tama�o 16.000 [mm]
X(5) = 11.2; %tama�o 11.200 [mm]
X(6) = 8; %tama�o 8.000 [mm]
X(7) = 5.6; %tama�o 5.600 [mm]
X(8) = 2.8; %tama�o 2.800 [mm]
X(9) = 1; %tama�o 1.000 [mm]
X(10) = 0.5; %tama�o 0.500 [mm]
X(11) = 0.315; %tama�o 0.315 [mm]
X(12) = 0.2; %tama�o 0.200 [mm]
X(13) = 0.125; %tama�o 0.125 [mm]
Xt = X;
Salida=[Xt];
end