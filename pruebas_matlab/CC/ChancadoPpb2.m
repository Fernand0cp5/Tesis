function Salida=ChancadoPpb2(Entrada)
P=Entrada(1);
L=Entrada(5);
NB=5;
n=13;
%Introducci�n de factor geom�trico, yk:
for k = 1:NB;
    y(k) = (L/(2*NB))*((2*k)-NB-1); %Punto medio de cada bloque k
    NUM(k) = ((L^2)-(4*(y(k)^2))); %Numerador expresi�n de potencia por bloque k
end
SNUM = sum(NUM);
%Potencia por bloque: Ppb(k)
for k = 1:NB;
    Ppb(k) = P*((NUM(k))/SNUM); %Ppb en [kW]
end
Salida=[Ppb];
end