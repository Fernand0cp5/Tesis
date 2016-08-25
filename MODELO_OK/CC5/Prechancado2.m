function Salida=Prechancado2(Entrada)
s0=Entrada(1);
U=Entrada(2);
Rp=Entrada(3);
alfaIP=Entrada(4);
D=0.8; %Diámetro de los rodillos: D en [m]
L=0.25; %Largo de los rodillos: L en [m]
ros=2740; %Densidad del sólido seco: ros en [kg/m3]
roe=0.85*ros; %Densidad aparente enc zona de extrusión: roe en [kg/m3]
Gs11=roe*s0*L*U; % Tonalaje tratado: Gs en [kg/s]
F=100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
P=1000*2*F*U*sin((alfaIP/2)*(pi/180));
Salida=[Gs11,F,P];
end