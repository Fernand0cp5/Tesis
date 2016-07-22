function Salida=ChancadoPpb(Entrada)
P=Entrada(27);
L=Entrada(31);
NB=5;
n=13;
%Introducción de factor geométrico, yk:
for k = 1:NB;
    y(k) = (L/(2*NB))*((2*k)-NB-1); %Punto medio de cada bloque k
    NUM(k) = ((L^2)-(4*(y(k)^2))); %Numerador expresión de potencia por bloque k
end
SNUM = sum(NUM);
%Potencia por bloque: Ppb(k)
for k = 1:NB;
    Ppb(k) = P*((NUM(k))/SNUM); %Ppb en [kW]
end
Salida=[Ppb];
end