NB = 5; 
n = 13;
alfaIP = 8.4150; %Angulo de zona de compresi�n de capas de part�culas: en [�]
P = 40.3087; %Potencia consumida por los rodillos: P en [kW]
L = 0.25; %Largo de los rodillos: Lrod en [m]
D = 0.8
Z = (D/2)*sin(alfaIP*pi/180); %Z en [m]
%Masa contenida en cada bloque k (Hold-up), Hk
%Introducci�n de factor geom�trico, yk:
for k = 1:NB,
    y(k) = (L/(2*NB))*((2*k)-NB-1) %Punto medio de cada bloque k
    NUM(k) = ((L^2)-(4*(y(k)^2))) %Numerador expresi�n de potencia por bloque k
end
SNUM = sum(NUM)
%Potencia por bloque: Ppb(k)
for k = 1:NB,
    Ppb(k) = P*((NUM(k))/SNUM) %Ppb en [kW]
end