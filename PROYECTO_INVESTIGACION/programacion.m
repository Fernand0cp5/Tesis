function [ RES ] = programacion(x)
%Submodelo 1 y 2: Capacidad de tratamiento (1) y Consumo de energ�a
%espec�fica.
%Variables de entrada:
D = 0.8; %Di�metro de los rodillos: D en [m]
L = 0.25; %Largo de los rodillos: L en [m]
s0 = 0.019; %Gap operacional: s0 en [m]
U = 0.67; %Velocidad perif�rica de los rodillos: U en [m/s]
Rp = 41; %Presion de operaci�n: Rp en [bar]
ros = 2.74; %Densidad del s�lido seco: ros en [t/m3]
roa = 1.62; %Densidad aparente de la alimentaci�n: roa en [t/m3]
roe = 0.85*ros; %Densidad aparente en zona de extrusi�n: roe en [t/m3]
%Submodelo 1: Capacidad de tratamiento HPGR, Gs
Gs = 3600*roe*s0*L*U; % Tonalaje tratado: Gs en [ton/hora]
%Otras variables a estimar:
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
P = 2*F*U*sin((alfaIP/2)*(pi/180)); %Potencia: P en [kW]
%Submodelo 2: Consumo de energ�a espec�fica HPGR (CEE), W
W = P/Gs; %W en [kWh/ton]
%Tama�o cr�tico previo a zona de compresi�n de capas de part�culas, Xc
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tama�o cr�tico: Xc en [mm]
[ RES ] = [roe W Gs alfaIP P U L D Xc];
end
function [ SAL ] = PRECHANCADO_HPGR( x )
%MECANISMO DE RUPTURA 1: PRECHANCADO (ZONA DE COMPRESION DE PARTICULAS
%INDIVIDUALES: SP)
%N� de tama�os de clases:
n = 13;
%Variables de entrada:
%Fracci�n en peso de alimentaci�n discreta al HPGR: f(i)aHPGR en
%[ton(i)/tonT] (13 mallas)
faHPGR(1) = x(2); %fracci�n retenido discreto, tama�o 45.000 [mm]
faHPGR(2) = x(3); %fracci�n retenido discreto, tama�o 31.500 [mm]
faHPGR(3) = x(4); %fracci�n retenido discreto, tama�o 22.400 [mm]
faHPGR(4) = x(5); %fracci�n retenido discreto, tama�o 16.000 [mm]
faHPGR(5) = x(6); %fracci�n retenido discreto, tama�o 11.200 [mm]
faHPGR(6) = x(7); %fracci�n retenido discreto, tama�o 8.000 [mm]
faHPGR(7) = x(8); %fracci�n retenido discreto, tama�o 5.600 [mm]
faHPGR(8) = x(9); %fracci�n retenido discreto, tama�o 2.800 [mm]
faHPGR(9) = x(10); %fracci�n retenido discreto, tama�o 1.000 [mm]
faHPGR(10) = x(11); %fracci�n retenido discreto, tama�o 0.500 [mm]
faHPGR(11) = x(12); %fracci�n retenido discreto, tama�o 0.315 [mm]
faHPGR(12) = x(13); %fracci�n retenido discreto, tama�o 0.200 [mm]
faHPGR(13) = x(14); %fracci�n retenido discreto, tama�o 0.125 [mm]
%Tama�os de clases de part�cula: X(i) en [mm] (13 mallas)
X(1) = x(15); %tama�o 45.000 [mm]
X(2) = x(16); %tama�o 31.500 [mm]
X(3) = x(17); %tama�o 22.400 [mm]
X(4) = x(18); %tama�o 16.000 [mm]
X(5) = x(19); %tama�o 11.200 [mm]
X(6) = x(20); %tama�o 8.000 [mm]
X(7) = x(21); %tama�o 5.600 [mm]
X(8) = x(22); %tama�o 2.800 [mm]
X(9) = x(23); %tama�o 1.000 [mm]
X(10) = x(24); %tama�o 0.500 [mm]
X(11) = x(25); %tama�o 0.315 [mm]
X(12) = x(26); %tama�o 0.200 [mm]
X(13) = x(27); %tama�o 0.125 [mm]
%Tama�o cr�tico de part�cula, previo a zona de compresi�n de capas de
%part�culas: Xc en [mm]
Xc = x(1);
%Algoritmo de Prechancado:
if X(1) > Xc,
suma = 0;
for i=1:n,
if X(i) >= Xc,
fspHPGR(i) = faHPGR(i);
fbpHPGR(i) = 0;
suma = suma + faHPGR(i);
SfspHPGR = suma;
else
fspHPGR(i) = 0;
fbpHPGR(i) = faHPGR(i);
end
end
suma
for i=1:n,
fspHPGR(i) = fspHPGR(i)/SfspHPGR;
fbpHPGR(i) = fbpHPGR(i)/(1-SfspHPGR);
end
%INTRODUCCION DE LA FUNCION RUPTURA:
%Matriz funci�n ruptura
%Par�metros del modelo ajustados para: Fabricante M1 y Litolog�a Porf�dica
alfa1 = x(28);
alfa2 = x(29);
alfa3 = x(30);
%Funci�n de la distribuci�n de fractura primaria B(i)
%B(i): fracci�n en peso retenida acumulada
for i=1:n,
B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
end
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
%Multiplicaci�n bij con fspHPGR(i):
for i=1:n,
suma = 0;
for l=1:n,
suma = suma + (b(i,l)*fspHPGR(l));
PspHPGR(i) = suma;
end
suma
end
%Alimentaci�n a zona de compresi�n multicapa (BP): f(i)ipHPGR en
%[ton(i)/tonT] (o bi�n: f(i)spHPGR, como descarga de zona de compresi�n de part�culas individuales (SP))
for i=1:n,
fipHPGR(i) = (SfspHPGR*PspHPGR(i)+(1-SfspHPGR)*fbpHPGR(i));
end
else
fipHPGR = faHPGR;
end
[ SAL ] = [fipHPGR];
end
function [ RESPUESTA ] = CHANCADO_HPGR( x )
%MECANISMO DE RUPTURA 2 Y 3: CHANCADO POR EFECTO DE BORDE Y CHANCADO POR COMPRESION DE CAPAS DE PARTICULAS
NB = 31; %N� de bloques del perfil de presi�n entre rodillos
n = 13; %N� de tama�os de clases
%Variables de entrada:
Gs = x(1); %Capacidad de tratamiento: Gs en [ton/hora]
alfaIP = x(2); %Angulo de zona de compresi�n de capas de part�culas: en [�]
P = x(3); %Potencia consumida por los rodillos: P en [kW]
U = x(4); %Velocidad perif�rica de los rodillos: U en [m/s]
L = x(5); %Largo de los rodillos: Lrod en [m]
D = x(6); %Diametro de los rodillos: Drod en [m]
%Altura zona de compresi�n de capas de part�culas, Z
Z = (D/2)*sin(alfaIP*pi/180); %Z en [m]
%Masa contenida en cada bloque k (Hold-up), Hk
Hk = (1/NB)*Gs*Z/(3600*U); %Hk en [ton]
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
S1E = x(36);
Z1 = x(37);
Z2 = x(38);
%Variables de entrada:
%Tama�os de clases: X(i) en [mm]
X(1) = x(20); %tama�o 45.000 [mm]
X(2) = x(21); %tama�o 31.500 [mm]
X(3) = x(22); %tama�o 22.400 [mm]
X(4) = x(23); %tama�o 16.000 [mm]
X(5) = x(24); %tama�o 11.200 [mm]
X(6) = x(25); %tama�o 8.000 [mm]
X(7) = x(26); %tama�o 5.600 [mm]
X(8) = x(27); %tama�o 2.800 [mm]
X(9) = x(28); %tama�o 1.000 [mm]
X(10) = x(29); %tama�o 0.500 [mm]
X(11) = x(30); %tama�o 0.315 [mm]
X(12) = x(31); %tama�o 0.200 [mm]
X(13) = x(32); %tama�o 0.125 [mm]
%Determinaci�n de los tama�os medios geom�tricos, X
for i=1:n-1,
X(i)=sqrt(X(i)*X(i+1));
end
for i=n,
X(i)=X(i)/2;
end
for i=1:n,
%Sea A = log (SiE/S1E)
A(i) = (Z1*log(X(i)/X(1)))+(Z2*log(X(i)/X(1))^2);
%Velocidad espec�fica de fractura por tama�o, SiE
SiE(i) = exp(A(i))*S1E; %SiE en [ton/kWh]
end
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n,
for k = 1:NB,
S(i,k) = (Ppb(k)/Hk)*SiE(i)/3600; %S(i,k) en [1/s]
end
end
%INTRODUCCION DE LA FUNCION RUPTURA:
%Matriz Funci�n Ruptura
%Par�metros del modelo ajustados para: Fabricante M1 y Litolog�a Porf�dica
alfa1 = x(33);
alfa2 = x(34);
alfa3 = x(35);
%Variables de entrada:
%Funci�n de la distribucion de fractura primaria B(i)
%B(i): fracci�n en peso retenida acumulada
for i=1:n,
B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
end
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
%Variables de entrada para modelar la Matriz de REID:
%Introducci�n de la alimentacion a zona BP: f(i)ipHPGR (13 mallas)
fipHPGR(1) = x(7); %fracci�n retenido discreto, tama�o 45.000 [mm]
fipHPGR(2) = x(8); %fracci�n retenido discreto, tama�o 31.500 [mm]
fipHPGR(3) = x(9); %fracci�n retenido discreto, tama�o 22.400 [mm]
fipHPGR(4) = x(10); %fracci�n retenido discreto, tama�o 16.000 [mm]
fipHPGR(5) = x(11); %fracci�n retenido discreto, tama�o 11.200 [mm]
fipHPGR(6) = x(12); %fracci�n retenido discreto, tama�o 8.000 [mm]
fipHPGR(7) = x(13); %fracci�n retenido discreto, tama�o 5.600 [mm]
fipHPGR(8) = x(14); %fracci�n retenido discreto, tama�o 2.800 [mm]
fipHPGR(9) = x(15); %fracci�n retenido discreto, tama�o 1.000 [mm]
fipHPGR(10) = x(16); %fracci�n retenido discreto, tama�o 0.500 [mm]
fipHPGR(11) = x(17); %fracci�n retenido discreto, tama�o 0.315 [mm]
fipHPGR(12) = x(18); %fracci�n retenido discreto, tama�o 0.200 [mm]
fipHPGR(13) = x(19); %fracci�n retenido discreto, tama�o 0.125 [mm]
%Valores de partida
A(1,1) = fipHPGR(1);
%MATRIZ DE REID
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
suma
else i=j,
suma = 0;
for l=1:i-1,
suma = suma + A(i,l);
A(i,j) = fipHPGR(i) - suma;
end
suma
end
end
end
end
%Distribuci�n del tama�o de part�cula en zona BP,
for k = 1:NB,
for i = 1:n-1,
suma = 0;
for j = 1:i,
suma = suma + A(i,j)*exp(-1*S(j,k)*Z/U);
p(i,k) = suma;
end
suma
end
for i = n,
p(i,k) = 1 - sum(p(1:n-1,k));
end
end
%Distribucion de tama�o de part�cula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n,
suma = 0;
for k = 1:NB,
suma = suma + p(i,k);
fptHPGR(i) = suma/NB;
end
suma
end
%Distribuci�n de tama�o de part�cula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = x(39); %Par�metro fracci�n en peso que circula en los bordes
E = 0.5*a*NB; %N� de bloques, E, correspondiente a los bordes
for i=1:n,
suma = 0;
for k = 1:round(E),
suma = suma + p(i,k);
end
suma
fpeHPGR(i) = (suma + (E - round(E))*p(i,round(E)+1))/E;
end
%Distribuci�n de tama�o de part�cula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n,
fpcHPGR(i) = (fptHPGR(i) - a*fpeHPGR(i))/(1-a);
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
[ RESPUESTA ] = [ fptHPGRu(1:n) fpeHPGRu(1:n) fpcHPGRu(1:n) ];
end
function [ Granulometria ] = Porcentaje_Producto( x )
%Granulometr�a de producto del HPGR (Total, Centro y Borde) par
%interpolaci�n del par�metro de calidad de molienda P80.
n = 13, %N� de tama�os de clases
%Variables de entrada:
%Porcentaje en peso pasante acumulado de producto total, borde o centro
%HPGR: fpHPGRu en [% peso]
fpHPGRu(1) = x(1); %Porcentaje acumulado pasante, tama�o 45.000 [mm]
fpHPGRu(2) = x(2); %Porcentaje acumulado pasante, tama�o 31.500 [mm]
fpHPGRu(3) = x(3); %Porcentaje acumulado pasante, tama�o 22.400 [mm]
fpHPGRu(4) = x(4); %Porcentaje acumulado pasante, tama�o 16.000 [mm]
fpHPGRu(5) = x(5); %Porcentaje acumulado pasante, tama�o 11.200 [mm]
fpHPGRu(6) = x(6); %Porcentaje acumulado pasante, tama�o 8.000 [mm]
fpHPGRu(7) = x(7); %Porcentaje acumulado pasante, tama�o 5.600 [mm]
fpHPGRu(8) = x(8); %Porcentaje acumulado pasante, tama�o 2.800 [mm]
fpHPGRu(9) = x(9); %Porcentaje acumulado pasante, tama�o 1.000 [mm]
fpHPGRu(10) = x(10); %Porcentaje acumulado pasante, tama�o 0.500 [mm]
fpHPGRu(11) = x(11); %Porcentaje acumulado pasante, tama�o 0.315 [mm]
fpHPGRu(12) = x(12); %Porcentaje acumulado pasante, tama�o 0.200 [mm]
fpHPGRu(13) = x(13); %Porcentaje acumulado pasante, tama�o 0.125 [mm]
for i = 1:n;
if fpHPGRu(i) < 100;
fpHPGRu(i) = fpHPGRu(i);
else fpHPGRu(i) >= 100;
fpHPGRu(i) = (fpHPGRu(i)*0) + (i/10000);
end
end
[ Granulometria ] = [ fpHPGRu ]
end
function [ REDUCCION ] = P80( x )
%Par�metro P80: Interpretado como el tama�o de part�cula bajo el cual se
%encuentra el 80% en masa del total de material chancado
%(Tama�o del 80% pasante en el producto HPGR)
%Variables de entrada:
%Porcentaje en peso pasante acumulado de producto total, borde o centro
%HPGR: fpHPGRu en [% peso]
fpHPGRu(1) = x(1); %Porcentaje acumulado pasante, tama�o 45.000 [mm]
fpHPGRu(2) = x(2); %Porcentaje acumulado pasante, tama�o 31.500 [mm]
fpHPGRu(3) = x(3); %Porcentaje acumulado pasante, tama�o 22.400 [mm]
fpHPGRu(4) = x(4); %Porcentaje acumulado pasante, tama�o 16.000 [mm]
fpHPGRu(5) = x(5); %Porcentaje acumulado pasante, tama�o 11.200 [mm]
fpHPGRu(6) = x(6); %Porcentaje acumulado pasante, tama�o 8.000 [mm]
fpHPGRu(7) = x(7); %Porcentaje acumulado pasante, tama�o 5.600 [mm]
fpHPGRu(8) = x(8); %Porcentaje acumulado pasante, tama�o 2.800 [mm]
fpHPGRu(9) = x(9); %Porcentaje acumulado pasante, tama�o 1.000 [mm]
fpHPGRu(10) = x(10); %Porcentaje acumulado pasante, tama�o 0.500 [mm]
fpHPGRu(11) = x(11); %Porcentaje acumulado pasante, tama�o 0.315 [mm]
fpHPGRu(12) = x(12); %Porcentaje acumulado pasante, tama�o 0.200 [mm]
fpHPGRu(13) = x(13); %Porcentaje acumulado pasante, tama�o 0.125 [mm]
%Tama�os de clases: X(i) en [mm]
X(1) = x(14); %tama�o 45.000 [mm]
X(2) = x(15); %tama�o 31.500 [mm]
X(3) = x(16); %tama�o 22.400 [mm]
X(4) = x(17); %tama�o 16.000 [mm]
X(5) = x(18); %tama�o 11.200 [mm]
X(6) = x(19); %tama�o 8.000 [mm]
X(7) = x(20); %tama�o 5.600 [mm]
X(8) = x(21); %tama�o 2.800 [mm]
X(9) = x(22); %tama�o 1.000 [mm]
X(10) = x(23); %tama�o 0.500 [mm]
X(11) = x(24); %tama�o 0.315 [mm]
X(12) = x(25); %tama�o 0.200 [mm]
X(13) = x(26); %tama�o 0.125 [mm]
%Porcentaje acumulado pasante: 80% en peso
fpHPGRui = 80;
%Interpolaci�n del par�metro P80
X80 = interp1(fpHPGRu,X,fpHPGRui);
P80 = X80;
[ REDUCCION ] = [ P80 ];
end
