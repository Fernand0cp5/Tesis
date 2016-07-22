function [ alfaIP D s0 roe roa U L] = calculoalfaip2( x )
% global alfaIP D roe s0
%Variables de entrada
D = x(1);%Di�metro de los rodillos: D en [m]
s0 = x(2); %Gap operacional: s0 en [m]
ros = x(3); %Densidad del s�lido seco: ros en [t/m3]
roa = x(4); %Densidad aparente de la alimentaci�n: roa en [t/m3]
U = x(5); %Velocidad perif�rica de los rodillos: U en [m/s]
L = x(6); %%Largo de los rodillos: L en [m]
roe = 0.85*ros; %Densidad aparente en zona de extrusi�n: roe en [t/m3]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
[ RES ] = [alfaIP D s0 roe roa U L];
end

%0.8 0.019 2.74 1.62

%  [alfaIP D s0 roe roa U L]=calculoalfaip2 ([0.8 0.019 2.74 1.62 0.67 0.25])