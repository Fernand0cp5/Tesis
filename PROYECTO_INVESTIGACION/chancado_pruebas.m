%function [ RESPUESTA ] = CHANCADO_HPGR( x )
%MECANISMO DE RUPTURA 2 Y 3: CHANCADO POR EFECTO DE BORDE Y CHANCADO POR COMPRESION DE CAPAS DE PARTICULAS
%CHANCADO DEFINIDO ENTRE EL ANGULO ALFAIP Y 0
NB = 4; %N� de bloques del perfil de presi�n entre rodillos
n = 13; %N� de tama�os de clases
%Variables de entrada:
Gs = 26.6834; %Capacidad de tratamiento: Gs en [ton/hora]
alfaIP = 8.4150; %Angulo de zona de compresi�n de capas de part�culas: en [�]
P = 40.3087; %Potencia consumida por los rodillos: P en [kW]
U = 0.67; %Velocidad perif�rica de los rodillos: U en [m/s]
L = 0.25; %Largo de los rodillos: Lrod en [m]
D = 0.8; %Diametro de los rodillos: Drod en [m]
%Altura zona de compresi�n de capas de part�culas, Z
Z = (D/2)*sin(alfaIP*pi/180); %Z en [m]
%Masa contenida en cada bloque k (Hold-up), Hk
Hk = 0.5 %Hk en [ton]
%Introducci�n de factor geom�trico, yk:
for k = 1:NB,
    y(k) = (L/(2*NB))*((2*k)-NB-1); %Punto medio de cada bloque k
    NUM(k) = ((L^2)-(4*(y(k)^2))); %Numerador expresi�n de potencia por bloque k
end
SNUM = sum(NUM);
%Potencia por bloque: Ppb(k)
for k = 1:NB,
    Ppb(k) = P*((NUM(k))/SNUM); %Ppb en [kW]
end
%INTRODUCCION DE LA FUNCION SELECCION:
%Funci�n selecci�n (HERBST AND FUERSTENAU) para determinar la velocidad
%espec�fica de fractura por tama�o de mineral
%Par�metros del modelo: fabricante M1 y litolog�a Porf�dica.
S1E = 0.75;
Z1 = -1.23;
Z2 = -0.62;
%Variables de entrada:
%Tama�os de clases: X(i) en [mm]
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
%Determinaci�n de los tama�os medios geom�tricos, X
for i=1:n-1,
    X(i)=sqrt(X(i)*X(i+1));
end
for i=n,
    X(i)=X(i)/2;
end
for i=1:n,
    %Sea A = log (SiE/S1E)
    A(i) = (Z1*log(X(i)/X(1)))+(Z2*log(X(i)/X(1))^2)
    %Velocidad espec�fica de fractura por tama�o, SiE
    SiE(i) = exp(A(i))*S1E; %SiE en [ton/kWh]
end
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n,
    for k = 1:NB,
        S(i,k) = (Ppb(k)/Hk)*SiE(i)/3600 %S(i,k) en [1/s]
    end
end
S
%INTRODUCCION DE LA FUNCION RUPTURA:
%Matriz Funci�n Ruptura
%Par�metros del modelo ajustados para: Fabricante M1 y Litolog�a Porf�dica
alfa1 = 0.15;
alfa2 = 0.21;
alfa3 = 5.96;
%Variables de entrada:
%Funci�n de la distribucion de fractura primaria B(i)
%B(i): fracci�n en peso retenida acumulada
for i=1:n,
    B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
end
B
%Matriz bij: fracci�n en peso de tama�o j que por fractura pasa a tama�o i
for j=1:n,
    suma = 0;
    for i=1:n-1,
        if i>j,
            b(i,j)=B(i-j+1)-B(i-j+2);
            suma = suma + b(i,j);
        else i<=j,
            b(i,j)=0;
        end
    end
    suma
    for i=n,
        b(i,j)=1-suma;
    end
end
for i=n,
    for j=n,
        b(i,j) = 0;
    end
end
b
%Variables de entrada para modelar la Matriz de REID:
%Introducci�n de la alimentacion a zona BP: f(i)ipHPGR (13 mallas)
fipHPGR(1) = 0; %fracci�n retenido discreto, tama�o 45.000 [mm]
fipHPGR(2) = 0.0179; %fracci�n retenido discreto, tama�o 31.500 [mm]
fipHPGR(3) = 0.5111; %fracci�n retenido discreto, tama�o 22.400 [mm]
fipHPGR(4) = 0.1519; %fracci�n retenido discreto, tama�o 16.000 [mm]
fipHPGR(5) = 0.0642; %fracci�n retenido discreto, tama�o 11.200 [mm]
fipHPGR(6) = 0.0482; %fracci�n retenido discreto, tama�o 8.000 [mm]
fipHPGR(7) = 0.05789; %fracci�n retenido discreto, tama�o 5.600 [mm]
fipHPGR(8) = 0.0435; %fracci�n retenido discreto, tama�o 2.800 [mm]
fipHPGR(9) = 0.0232; %fracci�n retenido discreto, tama�o 1.000 [mm]
fipHPGR(10) = 0.0126; %fracci�n retenido discreto, tama�o 0.500 [mm]
fipHPGR(11) = 0.0112; %fracci�n retenido discreto, tama�o 0.315 [mm]
fipHPGR(12) = 0.0107; %fracci�n retenido discreto, tama�o 0.200 [mm]
fipHPGR(13) = 0.0477; %fracci�n retenido discreto, tama�o 0.125 [mm]
%Valores de partida
A(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A(l,j)/(SiE(i)-SiE(j));
                    A(i,j) = suma;
                end
                suma;
            else i=j,
                suma = 0;
                for l=1:i-1,
                    suma = suma + A(i,l);
                    A(i,j) = fipHPGR(i) - suma;
                end
                suma;
            end
        end
    end
    A
end
%Distribuci�n del tama�o de part�cula en zona BP,
for k = 1:NB,
    for i = 1:n-1,
        suma = 0;
        for j = 1:i,
            suma = suma + A(i,j)*exp(-1*S(j,k)*Z/U);% Distribuci�n granulom�trica
            %de producto de la zona de compresi�n de capas de part�culas, para cada bloque k, [ton(i)/ton
            p(i,k) = suma;
        end
        suma;
    end
    for i = n,
        p(i,k) = 1 - sum(p(1:n-1,k));
    end
end
p
%Distribucion de tama�o de part�cula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n,
    suma = 0;
    for k = 1:NB,
        suma = suma + p(i,k);
        fptHPGR(i) = suma/NB;%GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
    suma;
end
p
%Distribuci�n de tama�o de part�cula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Par�metro fracci�n en peso que circula en los bordes
E = 0.5*a*NB; %N� de bloques, E, correspondiente a los bordes
for i=1:n,
    suma = 0;
    for k = 1:round(E),
        suma = suma + p(i,k);
    end
    suma;
    fpeHPGR(i) = (suma + (E - round(E))*p(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribuci�n de tama�o de part�cula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n,
    fpcHPGR(i) = (fptHPGR(i) - a*fpeHPGR(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribuci�n de tama�o de productos en forma acumulada pasante
for i = 1,
    fptHPGRu(i) = 1;
    fpeHPGRu(i) = 1;
    fpcHPGRu(i) = 1;
end
for i = 2:n,
    fptHPGRu(i) = fptHPGRu(i-1) - fptHPGR(i-1);
    fpeHPGRu(i) = fpeHPGRu(i-1) - fpeHPGR(i-1);
    fpcHPGRu(i) = fpcHPGRu(i-1) - fpcHPGR(i-1);
end
fptHPGRu(1:n) = fptHPGRu(1:n)*100;
fpeHPGRu(1:n) = fpeHPGRu(1:n)*100;
fpcHPGRu(1:n) = fpcHPGRu(1:n)*100;
[ RESPUESTA ] = [ fptHPGRu(1:n) fpeHPGRu(1:n) fpcHPGRu(1:n) ]