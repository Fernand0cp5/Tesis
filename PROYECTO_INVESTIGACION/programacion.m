function [ RES ] = programacion(x)
%Submodelo 1 y 2: Capacidad de tratamiento (1) y Consumo de energía
%específica.
%Variables de entrada:
D = 0.8; %Diámetro de los rodillos: D en [m]
L = 0.25; %Largo de los rodillos: L en [m]
s0 = 0.019; %Gap operacional: s0 en [m]
U = 0.67; %Velocidad periférica de los rodillos: U en [m/s]
Rp = 41; %Presion de operación: Rp en [bar]
ros = 2.74; %Densidad del sólido seco: ros en [t/m3]
roa = 1.62; %Densidad aparente de la alimentación: roa en [t/m3]
roe = 0.85*ros; %Densidad aparente en zona de extrusión: roe en [t/m3]
%Submodelo 1: Capacidad de tratamiento HPGR, Gs
Gs = 3600*roe*s0*L*U; % Tonalaje tratado: Gs en [ton/hora]
%Otras variables a estimar:
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresión zona de capas de partículas: alfaIP en [°]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
P = 2*F*U*sin((alfaIP/2)*(pi/180)); %Potencia: P en [kW]
%Submodelo 2: Consumo de energía específica HPGR (CEE), W
W = P/Gs; %W en [kWh/ton]
%Tamaño crítico previo a zona de compresión de capas de partículas, Xc
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tamaño crítico: Xc en [mm]
[ RES ] = [roe W Gs alfaIP P U L D Xc];
end
function [ SAL ] = PRECHANCADO_HPGR( x )
%MECANISMO DE RUPTURA 1: PRECHANCADO (ZONA DE COMPRESION DE PARTICULAS
%INDIVIDUALES: SP)
%N° de tamaños de clases:
n = 13;
%Variables de entrada:
%Fracción en peso de alimentación discreta al HPGR: f(i)aHPGR en
%[ton(i)/tonT] (13 mallas)
faHPGR(1) = x(2); %fracción retenido discreto, tamaño 45.000 [mm]
faHPGR(2) = x(3); %fracción retenido discreto, tamaño 31.500 [mm]
faHPGR(3) = x(4); %fracción retenido discreto, tamaño 22.400 [mm]
faHPGR(4) = x(5); %fracción retenido discreto, tamaño 16.000 [mm]
faHPGR(5) = x(6); %fracción retenido discreto, tamaño 11.200 [mm]
faHPGR(6) = x(7); %fracción retenido discreto, tamaño 8.000 [mm]
faHPGR(7) = x(8); %fracción retenido discreto, tamaño 5.600 [mm]
faHPGR(8) = x(9); %fracción retenido discreto, tamaño 2.800 [mm]
faHPGR(9) = x(10); %fracción retenido discreto, tamaño 1.000 [mm]
faHPGR(10) = x(11); %fracción retenido discreto, tamaño 0.500 [mm]
faHPGR(11) = x(12); %fracción retenido discreto, tamaño 0.315 [mm]
faHPGR(12) = x(13); %fracción retenido discreto, tamaño 0.200 [mm]
faHPGR(13) = x(14); %fracción retenido discreto, tamaño 0.125 [mm]
%Tamaños de clases de partícula: X(i) en [mm] (13 mallas)
X(1) = x(15); %tamaño 45.000 [mm]
X(2) = x(16); %tamaño 31.500 [mm]
X(3) = x(17); %tamaño 22.400 [mm]
X(4) = x(18); %tamaño 16.000 [mm]
X(5) = x(19); %tamaño 11.200 [mm]
X(6) = x(20); %tamaño 8.000 [mm]
X(7) = x(21); %tamaño 5.600 [mm]
X(8) = x(22); %tamaño 2.800 [mm]
X(9) = x(23); %tamaño 1.000 [mm]
X(10) = x(24); %tamaño 0.500 [mm]
X(11) = x(25); %tamaño 0.315 [mm]
X(12) = x(26); %tamaño 0.200 [mm]
X(13) = x(27); %tamaño 0.125 [mm]
%Tamaño crítico de partícula, previo a zona de compresión de capas de
%partículas: Xc en [mm]
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
%Matriz función ruptura
%Parámetros del modelo ajustados para: Fabricante M1 y Litología Porfídica
alfa1 = x(28);
alfa2 = x(29);
alfa3 = x(30);
%Función de la distribución de fractura primaria B(i)
%B(i): fracción en peso retenida acumulada
for i=1:n,
B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
end
%Matriz bij: fracción en peso de tamaño j que por fractura pasa a tamaño i
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
%Multiplicación bij con fspHPGR(i):
for i=1:n,
suma = 0;
for l=1:n,
suma = suma + (b(i,l)*fspHPGR(l));
PspHPGR(i) = suma;
end
suma
end
%Alimentación a zona de compresión multicapa (BP): f(i)ipHPGR en
%[ton(i)/tonT] (o bién: f(i)spHPGR, como descarga de zona de compresión de partículas individuales (SP))
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
NB = 31; %N° de bloques del perfil de presión entre rodillos
n = 13; %N° de tamaños de clases
%Variables de entrada:
Gs = x(1); %Capacidad de tratamiento: Gs en [ton/hora]
alfaIP = x(2); %Angulo de zona de compresión de capas de partículas: en [°]
P = x(3); %Potencia consumida por los rodillos: P en [kW]
U = x(4); %Velocidad periférica de los rodillos: U en [m/s]
L = x(5); %Largo de los rodillos: Lrod en [m]
D = x(6); %Diametro de los rodillos: Drod en [m]
%Altura zona de compresión de capas de partículas, Z
Z = (D/2)*sin(alfaIP*pi/180); %Z en [m]
%Masa contenida en cada bloque k (Hold-up), Hk
Hk = (1/NB)*Gs*Z/(3600*U); %Hk en [ton]
%Introducción de factor geométrico, yk:
for k = 1:NB,
y(k) = (L/(2*NB))*((2*k)-NB-1); %Punto medio de cada bloque k
NUM(k) = ((L^2)-(4*(y(k)^2))); %Numerador expresión de potencia por bloque k
end
SNUM = sum(NUM);
%Potencia por bloque: Ppb(k)
for k = 1:NB,
Ppb(k) = P*((NUM(k))/SNUM); %Ppb en [kW]
end
%INTRODUCCION DE LA FUNCION SELECCION:
%Función selección (HERBST AND FUERSTENAU) para determinar la velocidad
%específica de fractura por tamaño de mineral
%Parámetros del modelo: fabricante M1 y litología Porfídica.
S1E = x(36);
Z1 = x(37);
Z2 = x(38);
%Variables de entrada:
%Tamaños de clases: X(i) en [mm]
X(1) = x(20); %tamaño 45.000 [mm]
X(2) = x(21); %tamaño 31.500 [mm]
X(3) = x(22); %tamaño 22.400 [mm]
X(4) = x(23); %tamaño 16.000 [mm]
X(5) = x(24); %tamaño 11.200 [mm]
X(6) = x(25); %tamaño 8.000 [mm]
X(7) = x(26); %tamaño 5.600 [mm]
X(8) = x(27); %tamaño 2.800 [mm]
X(9) = x(28); %tamaño 1.000 [mm]
X(10) = x(29); %tamaño 0.500 [mm]
X(11) = x(30); %tamaño 0.315 [mm]
X(12) = x(31); %tamaño 0.200 [mm]
X(13) = x(32); %tamaño 0.125 [mm]
%Determinación de los tamaños medios geométricos, X
for i=1:n-1,
X(i)=sqrt(X(i)*X(i+1));
end
for i=n,
X(i)=X(i)/2;
end
for i=1:n,
%Sea A = log (SiE/S1E)
A(i) = (Z1*log(X(i)/X(1)))+(Z2*log(X(i)/X(1))^2);
%Velocidad específica de fractura por tamaño, SiE
SiE(i) = exp(A(i))*S1E; %SiE en [ton/kWh]
end
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n,
for k = 1:NB,
S(i,k) = (Ppb(k)/Hk)*SiE(i)/3600; %S(i,k) en [1/s]
end
end
%INTRODUCCION DE LA FUNCION RUPTURA:
%Matriz Función Ruptura
%Parámetros del modelo ajustados para: Fabricante M1 y Litología Porfídica
alfa1 = x(33);
alfa2 = x(34);
alfa3 = x(35);
%Variables de entrada:
%Función de la distribucion de fractura primaria B(i)
%B(i): fracción en peso retenida acumulada
for i=1:n,
B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
end
%Matriz bij: fracción en peso de tamaño j que por fractura pasa a tamaño i
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
%Introducción de la alimentacion a zona BP: f(i)ipHPGR (13 mallas)
fipHPGR(1) = x(7); %fracción retenido discreto, tamaño 45.000 [mm]
fipHPGR(2) = x(8); %fracción retenido discreto, tamaño 31.500 [mm]
fipHPGR(3) = x(9); %fracción retenido discreto, tamaño 22.400 [mm]
fipHPGR(4) = x(10); %fracción retenido discreto, tamaño 16.000 [mm]
fipHPGR(5) = x(11); %fracción retenido discreto, tamaño 11.200 [mm]
fipHPGR(6) = x(12); %fracción retenido discreto, tamaño 8.000 [mm]
fipHPGR(7) = x(13); %fracción retenido discreto, tamaño 5.600 [mm]
fipHPGR(8) = x(14); %fracción retenido discreto, tamaño 2.800 [mm]
fipHPGR(9) = x(15); %fracción retenido discreto, tamaño 1.000 [mm]
fipHPGR(10) = x(16); %fracción retenido discreto, tamaño 0.500 [mm]
fipHPGR(11) = x(17); %fracción retenido discreto, tamaño 0.315 [mm]
fipHPGR(12) = x(18); %fracción retenido discreto, tamaño 0.200 [mm]
fipHPGR(13) = x(19); %fracción retenido discreto, tamaño 0.125 [mm]
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
%Distribución del tamaño de partícula en zona BP,
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
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n,
suma = 0;
for k = 1:NB,
suma = suma + p(i,k);
fptHPGR(i) = suma/NB;
end
suma
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = x(39); %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n,
suma = 0;
for k = 1:round(E),
suma = suma + p(i,k);
end
suma
fpeHPGR(i) = (suma + (E - round(E))*p(i,round(E)+1))/E;
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n,
fpcHPGR(i) = (fptHPGR(i) - a*fpeHPGR(i))/(1-a);
end
%Distribución de tamaño de productos en forma acumulada pasante
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
%Granulometría de producto del HPGR (Total, Centro y Borde) par
%interpolación del parámetro de calidad de molienda P80.
n = 13, %N° de tamaños de clases
%Variables de entrada:
%Porcentaje en peso pasante acumulado de producto total, borde o centro
%HPGR: fpHPGRu en [% peso]
fpHPGRu(1) = x(1); %Porcentaje acumulado pasante, tamaño 45.000 [mm]
fpHPGRu(2) = x(2); %Porcentaje acumulado pasante, tamaño 31.500 [mm]
fpHPGRu(3) = x(3); %Porcentaje acumulado pasante, tamaño 22.400 [mm]
fpHPGRu(4) = x(4); %Porcentaje acumulado pasante, tamaño 16.000 [mm]
fpHPGRu(5) = x(5); %Porcentaje acumulado pasante, tamaño 11.200 [mm]
fpHPGRu(6) = x(6); %Porcentaje acumulado pasante, tamaño 8.000 [mm]
fpHPGRu(7) = x(7); %Porcentaje acumulado pasante, tamaño 5.600 [mm]
fpHPGRu(8) = x(8); %Porcentaje acumulado pasante, tamaño 2.800 [mm]
fpHPGRu(9) = x(9); %Porcentaje acumulado pasante, tamaño 1.000 [mm]
fpHPGRu(10) = x(10); %Porcentaje acumulado pasante, tamaño 0.500 [mm]
fpHPGRu(11) = x(11); %Porcentaje acumulado pasante, tamaño 0.315 [mm]
fpHPGRu(12) = x(12); %Porcentaje acumulado pasante, tamaño 0.200 [mm]
fpHPGRu(13) = x(13); %Porcentaje acumulado pasante, tamaño 0.125 [mm]
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
%Parámetro P80: Interpretado como el tamaño de partícula bajo el cual se
%encuentra el 80% en masa del total de material chancado
%(Tamaño del 80% pasante en el producto HPGR)
%Variables de entrada:
%Porcentaje en peso pasante acumulado de producto total, borde o centro
%HPGR: fpHPGRu en [% peso]
fpHPGRu(1) = x(1); %Porcentaje acumulado pasante, tamaño 45.000 [mm]
fpHPGRu(2) = x(2); %Porcentaje acumulado pasante, tamaño 31.500 [mm]
fpHPGRu(3) = x(3); %Porcentaje acumulado pasante, tamaño 22.400 [mm]
fpHPGRu(4) = x(4); %Porcentaje acumulado pasante, tamaño 16.000 [mm]
fpHPGRu(5) = x(5); %Porcentaje acumulado pasante, tamaño 11.200 [mm]
fpHPGRu(6) = x(6); %Porcentaje acumulado pasante, tamaño 8.000 [mm]
fpHPGRu(7) = x(7); %Porcentaje acumulado pasante, tamaño 5.600 [mm]
fpHPGRu(8) = x(8); %Porcentaje acumulado pasante, tamaño 2.800 [mm]
fpHPGRu(9) = x(9); %Porcentaje acumulado pasante, tamaño 1.000 [mm]
fpHPGRu(10) = x(10); %Porcentaje acumulado pasante, tamaño 0.500 [mm]
fpHPGRu(11) = x(11); %Porcentaje acumulado pasante, tamaño 0.315 [mm]
fpHPGRu(12) = x(12); %Porcentaje acumulado pasante, tamaño 0.200 [mm]
fpHPGRu(13) = x(13); %Porcentaje acumulado pasante, tamaño 0.125 [mm]
%Tamaños de clases: X(i) en [mm]
X(1) = x(14); %tamaño 45.000 [mm]
X(2) = x(15); %tamaño 31.500 [mm]
X(3) = x(16); %tamaño 22.400 [mm]
X(4) = x(17); %tamaño 16.000 [mm]
X(5) = x(18); %tamaño 11.200 [mm]
X(6) = x(19); %tamaño 8.000 [mm]
X(7) = x(20); %tamaño 5.600 [mm]
X(8) = x(21); %tamaño 2.800 [mm]
X(9) = x(22); %tamaño 1.000 [mm]
X(10) = x(23); %tamaño 0.500 [mm]
X(11) = x(24); %tamaño 0.315 [mm]
X(12) = x(25); %tamaño 0.200 [mm]
X(13) = x(26); %tamaño 0.125 [mm]
%Porcentaje acumulado pasante: 80% en peso
fpHPGRui = 80;
%Interpolación del parámetro P80
X80 = interp1(fpHPGRu,X,fpHPGRui);
P80 = X80;
[ REDUCCION ] = [ P80 ];
end
