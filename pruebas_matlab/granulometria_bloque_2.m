%Granulometria bloque 2 
NB = 5; %N° de bloques del perfil de presión entre rodillos
n = 13; %N° de tamaños de clases
%Variables de entrada:
%Gs6 = 26.6834; %Capacidad de tratamiento: Gs en [ton/hora]
alfaIP = 8.4150; %Angulo de zona de compresión de capas de partículas: en [°]
P = 40.3087; %Potencia consumida por los rodillos: P en [kW]
U = 0.67; %Velocidad periférica de los rodillos: U en [m/s]
L = 0.25; %Largo de los rodillos: Lrod en [m]
D = 0.8; %Diametro de los rodillos: Drod en [m]
%Altura zona de compresión de capas de partículas, Z
%Z = (D/2)*sin(alfaIP*pi/180); %Z en [m]
%Masa contenida en cada bloque k (Hold-up), Hk
Hk = (1/NB)*Gs3*h/(3600*U); %Hk en [ton]
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
S1E = 0.75;
Z1 = -1.23;
Z2 = -0.62;
%Variables de entrada:
%Tamaños de clases: X(i) en [mm]
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
alfa1 = 0.15;
alfa2 = 0.21;
alfa3 = 5.96;
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
fipHPGR(1) = 0; %fracción retenido discreto, tamaño 45.000 [mm]
fipHPGR(2) = 0.0179; %fracción retenido discreto, tamaño 31.500 [mm]
fipHPGR(3) = 0.5111; %fracción retenido discreto, tamaño 22.400 [mm]
fipHPGR(4) = 0.1519; %fracción retenido discreto, tamaño 16.000 [mm]
fipHPGR(5) = 0.0642; %fracción retenido discreto, tamaño 11.200 [mm]
fipHPGR(6) = 0.0482; %fracción retenido discreto, tamaño 8.000 [mm]
fipHPGR(7) = 0.05789; %fracción retenido discreto, tamaño 5.600 [mm]
fipHPGR(8) = 0.0435; %fracción retenido discreto, tamaño 2.800 [mm]
fipHPGR(9) = 0.0232; %fracción retenido discreto, tamaño 1.000 [mm]
fipHPGR(10) = 0.0126; %fracción retenido discreto, tamaño 0.500 [mm]
fipHPGR(11) = 0.0112; %fracción retenido discreto, tamaño 0.315 [mm]
fipHPGR(12) = 0.0107; %fracción retenido discreto, tamaño 0.200 [mm]
fipHPGR(13) = 0.0477; %fracción retenido discreto, tamaño 0.125 [mm]
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
end
%Distribución del tamaño de partícula en zona BP,
%Granulometria por bloques 
for k = 1:NB,
    for i = 1:n-1,
        suma = 0;
        for j = 1:i,
            suma = suma + A(i,j)*exp(-1*S(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p(i,k) = suma;
        end
        suma;
    end
    for i = n,
        p(i,k) = 1 - sum(p(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n,
    suma = 0;
    for k = 1:NB,
        suma = suma + p(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n,
    suma = 0;
    for k = 1:round(E),
        suma = suma + p(i,k);
    end
    suma;
    fpeHPGR(i) = (suma + (E - round(E))*p(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n,
    fpcHPGR(i) = (fptHPGR(i) - a*fpeHPGR(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
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
Xtc = [45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
%Modelo dinamico
x0(1) = 0;
x0(2) = 0;
x0(3) = 0;
x0(4) = 0;
x0(5) = 0;
x0(6) = 0;
x0(7) = 0;
x0(8) = 0;
x0(9) = 0;
x0(10) = 0;
x0(11) = 0;
x0(12) = 0;
x0(13) = 0;
Smd = 3600*S;
tf = 5;
tspan = [0 tf];
fg1 = @(t1,xx) [Gs3*fipHPGR(1)-Gs2*p(1,1)-xx(1)*sum(b(2:13,1).*Smd(2:13,1));...
            Gs3*fipHPGR(2)-Gs2*p(2,1)+xx(1)*b(2,1)*Smd(1,1)-xx(2)*sum(b(3:13,2).*Smd(3:13,1));...
            Gs3*fipHPGR(3)-Gs2*p(3,1)+xx(1)*b(3,1)*Smd(1,1)+xx(2)*b(3,2)*Smd(2,1)-xx(3)*sum(b(4:13,3).*Smd(4:13,1));...
            Gs3*fipHPGR(4)-Gs2*p(4,1)+xx(1)*b(4,1)*Smd(1,1)+xx(2)*b(4,2)*Smd(2,1)+xx(3)*b(4,3)*Smd(3,1)-xx(4)*sum(b(5:13,4).*Smd(5:13,1));...
            Gs3*fipHPGR(5)-Gs2*p(5,1)+xx(1)*b(5,1)*Smd(1,1)+xx(2)*b(5,2)*Smd(2,1)+xx(3)*b(5,3)*Smd(3,1)+xx(4)*b(5,4)*Smd(4,1)-xx(5)*sum(b(6:13,5).*Smd(6:13,1));...
            Gs3*fipHPGR(6)-Gs2*p(6,1)+xx(1)*b(6,1)*Smd(1,1)+xx(2)*b(6,2)*Smd(2,1)+xx(3)*b(6,3)*Smd(3,1)+xx(4)*b(6,4)*Smd(4,1)+xx(5)*b(6,5)*Smd(5,1)-xx(6)*sum(b(7:13,6).*Smd(7:13,1));...
            Gs3*fipHPGR(7)-Gs2*p(7,1)+xx(1)*b(7,1)*Smd(1,1)+xx(2)*b(7,2)*Smd(2,1)+xx(3)*b(7,3)*Smd(3,1)+xx(4)*b(7,4)*Smd(4,1)+xx(5)*b(7,5)*Smd(5,1)+xx(6)*b(7,6)*Smd(6,1)-xx(7)*sum(b(8:13,7).*Smd(8:13,1));...
            Gs3*fipHPGR(8)-Gs2*p(8,1)+xx(1)*b(8,1)*Smd(1,1)+xx(2)*b(8,2)*Smd(2,1)+xx(3)*b(8,3)*Smd(3,1)+xx(4)*b(8,4)*Smd(4,1)+xx(5)*b(8,5)*Smd(5,1)+xx(6)*b(8,6)*Smd(6,1)+xx(7)*b(8,7)*Smd(7,1)-xx(8)*sum(b(9:13,8).*Smd(9:13,1));...
            Gs3*fipHPGR(9)-Gs2*p(9,1)+xx(1)*b(9,1)*Smd(1,1)+xx(2)*b(9,2)*Smd(2,1)+xx(3)*b(9,3)*Smd(3,1)+xx(4)*b(9,4)*Smd(4,1)+xx(5)*b(9,5)*Smd(5,1)+xx(6)*b(9,6)*Smd(6,1)+xx(7)*b(9,7)*Smd(7,1)+xx(8)*b(9,8)*Smd(8,1)-xx(9)*sum(b(10:13,9).*Smd(10:13,1));...
            Gs3*fipHPGR(10)-Gs2*p(10,1)+xx(1)*b(10,1)*Smd(1,1)+xx(2)*b(10,2)*Smd(2,1)+xx(3)*b(10,3)*Smd(3,1)+xx(4)*b(10,4)*Smd(4,1)+xx(5)*b(10,5)*Smd(5,1)+xx(6)*b(10,6)*Smd(6,1)+xx(7)*b(10,7)*Smd(7,1)+xx(8)*b(10,8)*Smd(8,1)+xx(9)*b(10,9)*Smd(9,1)-xx(10)*sum(b(11:13,10).*Smd(11:13,1));...
            Gs3*fipHPGR(11)-Gs2*p(11,1)+xx(1)*b(11,1)*Smd(1,1)+xx(2)*b(11,2)*Smd(2,1)+xx(3)*b(11,3)*Smd(3,1)+xx(4)*b(11,4)*Smd(4,1)+xx(5)*b(11,5)*Smd(5,1)+xx(6)*b(11,6)*Smd(6,1)+xx(7)*b(11,7)*Smd(7,1)+xx(8)*b(11,8)*Smd(8,1)+xx(9)*b(11,9)*Smd(9,1)+xx(10)*b(11,10)*Smd(10,1)-xx(11)*sum(b(12:13,11).*Smd(12:13,1));...
            Gs3*fipHPGR(12)-Gs2*p(12,1)+xx(1)*b(12,1)*Smd(1,1)+xx(2)*b(12,2)*Smd(2,1)+xx(3)*b(12,3)*Smd(3,1)+xx(4)*b(12,4)*Smd(4,1)+xx(5)*b(12,5)*Smd(5,1)+xx(6)*b(12,6)*Smd(6,1)+xx(7)*b(12,7)*Smd(7,1)+xx(8)*b(12,8)*Smd(8,1)+xx(9)*b(12,9)*Smd(9,1)+xx(10)*b(12,10)*Smd(10,1)+xx(11)*b(12,11)*Smd(11,1)-xx(12)*sum(b(13,12)*Smd(13,1));...
            Gs3*fipHPGR(13)-Gs2*p(13,1)+xx(1)*b(13,1)*Smd(1,1)+xx(2)*b(13,2)*Smd(2,1)+xx(3)*b(13,3)*Smd(3,1)+xx(4)*b(13,4)*Smd(4,1)+xx(5)*b(13,5)*Smd(5,1)+xx(6)*b(13,6)*Smd(6,1)+xx(7)*b(13,7)*Smd(7,1)+xx(8)*b(13,8)*Smd(8,1)+xx(9)*b(13,9)*Smd(9,1)+xx(10)*b(13,10)*Smd(10,1)+xx(11)*b(13,11)*Smd(11,1)+xx(12)*b(13,12)*Smd(12,1)+0*xx(13)];
          
fg2 = @(t2,yy) [Gs3*fipHPGR(1)-Gs2*p(1,2)-yy(1)*sum(b(2:13,1).*Smd(2:13,2));...
            Gs3*fipHPGR(2)-Gs2*p(2,2)+yy(1)*b(2,1)*Smd(1,2)-yy(2)*sum(b(3:13,2).*Smd(3:13,2));...
            Gs3*fipHPGR(3)-Gs2*p(3,2)+yy(1)*b(3,1)*Smd(1,2)+yy(2)*b(3,2)*Smd(2,2)-yy(3)*sum(b(4:13,3).*Smd(4:13,2));...
            Gs3*fipHPGR(4)-Gs2*p(4,2)+yy(1)*b(4,1)*Smd(1,2)+yy(2)*b(4,2)*Smd(2,2)+yy(3)*b(4,3)*Smd(3,2)-yy(4)*sum(b(5:13,4).*Smd(5:13,2));...
            Gs3*fipHPGR(5)-Gs2*p(5,2)+yy(1)*b(5,1)*Smd(1,2)+yy(2)*b(5,2)*Smd(2,2)+yy(3)*b(5,3)*Smd(3,2)+yy(4)*b(5,4)*Smd(4,2)-yy(5)*sum(b(6:13,5).*Smd(6:13,2));...
            Gs3*fipHPGR(6)-Gs2*p(6,2)+yy(1)*b(6,1)*Smd(1,2)+yy(2)*b(6,2)*Smd(2,2)+yy(3)*b(6,3)*Smd(3,2)+yy(4)*b(6,4)*Smd(4,2)+yy(5)*b(6,5)*Smd(5,2)-yy(6)*sum(b(7:13,6).*Smd(7:13,2));...
            Gs3*fipHPGR(7)-Gs2*p(7,2)+yy(1)*b(7,1)*Smd(1,2)+yy(2)*b(7,2)*Smd(2,2)+yy(3)*b(7,3)*Smd(3,2)+yy(4)*b(7,4)*Smd(4,2)+yy(5)*b(7,5)*Smd(5,2)+yy(6)*b(7,6)*Smd(6,2)-yy(7)*sum(b(8:13,7).*Smd(8:13,2));...
            Gs3*fipHPGR(8)-Gs2*p(8,2)+yy(1)*b(8,1)*Smd(1,2)+yy(2)*b(8,2)*Smd(2,2)+yy(3)*b(8,3)*Smd(3,2)+yy(4)*b(8,4)*Smd(4,2)+yy(5)*b(8,5)*Smd(5,2)+yy(6)*b(8,6)*Smd(6,2)+yy(7)*b(8,7)*Smd(7,2)-yy(8)*sum(b(9:13,8).*Smd(9:13,2));...
            Gs3*fipHPGR(9)-Gs2*p(9,2)+yy(1)*b(9,1)*Smd(1,2)+yy(2)*b(9,2)*Smd(2,2)+yy(3)*b(9,3)*Smd(3,2)+yy(4)*b(9,4)*Smd(4,2)+yy(5)*b(9,5)*Smd(5,2)+yy(6)*b(9,6)*Smd(6,2)+yy(7)*b(9,7)*Smd(7,2)+yy(8)*b(9,8)*Smd(8,2)-yy(9)*sum(b(10:13,9).*Smd(10:13,2));...
            Gs3*fipHPGR(10)-Gs2*p(10,2)+yy(1)*b(10,1)*Smd(1,2)+yy(2)*b(10,2)*Smd(2,2)+yy(3)*b(10,3)*Smd(3,2)+yy(4)*b(10,4)*Smd(4,2)+yy(5)*b(10,5)*Smd(5,2)+yy(6)*b(10,6)*Smd(6,2)+yy(7)*b(10,7)*Smd(7,2)+yy(8)*b(10,8)*Smd(8,2)+yy(9)*b(10,9)*Smd(9,2)-yy(10)*sum(b(11:13,10).*Smd(11:13,2));...
            Gs3*fipHPGR(11)-Gs2*p(11,2)+yy(1)*b(11,1)*Smd(1,2)+yy(2)*b(11,2)*Smd(2,2)+yy(3)*b(11,3)*Smd(3,2)+yy(4)*b(11,4)*Smd(4,2)+yy(5)*b(11,5)*Smd(5,2)+yy(6)*b(11,6)*Smd(6,2)+yy(7)*b(11,7)*Smd(7,2)+yy(8)*b(11,8)*Smd(8,2)+yy(9)*b(11,9)*Smd(9,2)+yy(10)*b(11,10)*Smd(10,2)-yy(11)*sum(b(12:13,11).*Smd(12:13,2));...
            Gs3*fipHPGR(12)-Gs2*p(12,2)+yy(1)*b(12,1)*Smd(1,2)+yy(2)*b(12,2)*Smd(2,2)+yy(3)*b(12,3)*Smd(3,2)+yy(4)*b(12,4)*Smd(4,2)+yy(5)*b(12,5)*Smd(5,2)+yy(6)*b(12,6)*Smd(6,2)+yy(7)*b(12,7)*Smd(7,2)+yy(8)*b(12,8)*Smd(8,2)+yy(9)*b(12,9)*Smd(9,2)+yy(10)*b(12,10)*Smd(10,2)+yy(11)*b(12,11)*Smd(11,2)-yy(12)*sum(b(13,12)*Smd(13,2));...
            Gs3*fipHPGR(13)-Gs2*p(13,2)+yy(1)*b(13,1)*Smd(1,2)+yy(2)*b(13,2)*Smd(2,2)+yy(3)*b(13,3)*Smd(3,2)+yy(4)*b(13,4)*Smd(4,2)+yy(5)*b(13,5)*Smd(5,2)+yy(6)*b(13,6)*Smd(6,2)+yy(7)*b(13,7)*Smd(7,2)+yy(8)*b(13,8)*Smd(8,2)+yy(9)*b(13,9)*Smd(9,2)+yy(10)*b(13,10)*Smd(10,2)+yy(11)*b(13,11)*Smd(11,2)+yy(12)*b(13,12)*Smd(12,2)+0*yy(13)];   
        
fg3 = @(t3,zz) [Gs3*fipHPGR(1)-Gs2*p(1,3)-zz(1)*sum(b(2:13,1).*Smd(2:13,3));...
            Gs3*fipHPGR(2)-Gs2*p(2,3)+zz(1)*b(2,1)*Smd(1,3)-zz(2)*sum(b(3:13,2).*Smd(3:13,3));...
            Gs3*fipHPGR(3)-Gs2*p(3,3)+zz(1)*b(3,1)*Smd(1,3)+zz(2)*b(3,3)*Smd(2,3)-zz(3)*sum(b(4:13,3).*Smd(4:13,3));...
            Gs3*fipHPGR(4)-Gs2*p(4,3)+zz(1)*b(4,1)*Smd(1,3)+zz(2)*b(4,3)*Smd(2,3)+zz(3)*b(4,3)*Smd(3,3)-zz(4)*sum(b(5:13,4).*Smd(5:13,3));...
            Gs3*fipHPGR(5)-Gs2*p(5,3)+zz(1)*b(5,1)*Smd(1,3)+zz(2)*b(5,3)*Smd(2,3)+zz(3)*b(5,3)*Smd(3,3)+zz(4)*b(5,4)*Smd(4,3)-zz(5)*sum(b(6:13,5).*Smd(6:13,3));...
            Gs3*fipHPGR(6)-Gs2*p(6,3)+zz(1)*b(6,1)*Smd(1,3)+zz(2)*b(6,3)*Smd(2,3)+zz(3)*b(6,3)*Smd(3,3)+zz(4)*b(6,4)*Smd(4,3)+zz(5)*b(6,5)*Smd(5,3)-zz(6)*sum(b(7:13,6).*Smd(7:13,3));...
            Gs3*fipHPGR(7)-Gs2*p(7,3)+zz(1)*b(7,1)*Smd(1,3)+zz(2)*b(7,3)*Smd(2,3)+zz(3)*b(7,3)*Smd(3,3)+zz(4)*b(7,4)*Smd(4,3)+zz(5)*b(7,5)*Smd(5,3)+zz(6)*b(7,6)*Smd(6,3)-zz(7)*sum(b(8:13,7).*Smd(8:13,3));...
            Gs3*fipHPGR(8)-Gs2*p(8,3)+zz(1)*b(8,1)*Smd(1,3)+zz(2)*b(8,3)*Smd(2,3)+zz(3)*b(8,3)*Smd(3,3)+zz(4)*b(8,4)*Smd(4,3)+zz(5)*b(8,5)*Smd(5,3)+zz(6)*b(8,6)*Smd(6,3)+zz(7)*b(8,7)*Smd(7,3)-zz(8)*sum(b(9:13,8).*Smd(9:13,3));...
            Gs3*fipHPGR(9)-Gs2*p(9,3)+zz(1)*b(9,1)*Smd(1,3)+zz(2)*b(9,3)*Smd(2,3)+zz(3)*b(9,3)*Smd(3,3)+zz(4)*b(9,4)*Smd(4,3)+zz(5)*b(9,5)*Smd(5,3)+zz(6)*b(9,6)*Smd(6,3)+zz(7)*b(9,7)*Smd(7,3)+zz(8)*b(9,8)*Smd(8,3)-zz(9)*sum(b(10:13,9).*Smd(10:13,3));...
            Gs3*fipHPGR(10)-Gs2*p(10,3)+zz(1)*b(10,1)*Smd(1,3)+zz(2)*b(10,3)*Smd(2,3)+zz(3)*b(10,3)*Smd(3,3)+zz(4)*b(10,4)*Smd(4,3)+zz(5)*b(10,5)*Smd(5,3)+zz(6)*b(10,6)*Smd(6,3)+zz(7)*b(10,7)*Smd(7,3)+zz(8)*b(10,8)*Smd(8,3)+zz(9)*b(10,9)*Smd(9,3)-zz(10)*sum(b(11:13,10).*Smd(11:13,3));...
            Gs3*fipHPGR(11)-Gs2*p(11,3)+zz(1)*b(11,1)*Smd(1,3)+zz(2)*b(11,3)*Smd(2,2)+zz(3)*b(11,3)*Smd(3,3)+zz(4)*b(11,4)*Smd(4,3)+zz(5)*b(11,5)*Smd(5,3)+zz(6)*b(11,6)*Smd(6,3)+zz(7)*b(11,7)*Smd(7,3)+zz(8)*b(11,8)*Smd(8,3)+zz(9)*b(11,9)*Smd(9,3)+zz(10)*b(11,10)*Smd(10,3)-zz(11)*sum(b(12:13,11).*Smd(12:13,3));...
            Gs3*fipHPGR(12)-Gs2*p(12,3)+zz(1)*b(12,1)*Smd(1,3)+zz(2)*b(12,3)*Smd(2,3)+zz(3)*b(12,3)*Smd(3,3)+zz(4)*b(12,4)*Smd(4,3)+zz(5)*b(12,5)*Smd(5,3)+zz(6)*b(12,6)*Smd(6,3)+zz(7)*b(12,7)*Smd(7,3)+zz(8)*b(12,8)*Smd(8,3)+zz(9)*b(12,9)*Smd(9,3)+zz(10)*b(12,10)*Smd(10,3)+zz(11)*b(12,11)*Smd(11,3)-zz(12)*sum(b(13,12)*Smd(13,3));...
            Gs3*fipHPGR(13)-Gs2*p(13,3)+zz(1)*b(13,1)*Smd(1,3)+zz(2)*b(13,3)*Smd(2,3)+zz(3)*b(13,3)*Smd(3,3)+zz(4)*b(13,4)*Smd(4,3)+zz(5)*b(13,5)*Smd(5,3)+zz(6)*b(13,6)*Smd(6,3)+zz(7)*b(13,7)*Smd(7,3)+zz(8)*b(13,8)*Smd(8,3)+zz(9)*b(13,9)*Smd(9,3)+zz(10)*b(13,10)*Smd(10,3)+zz(11)*b(13,11)*Smd(11,3)+zz(12)*b(13,12)*Smd(12,3)+0*zz(13)];
        
fg4 = @(t4,ww) [Gs3*fipHPGR(1)-Gs2*p(1,4)-ww(1)*sum(b(2:13,1).*Smd(2:13,4));...
            Gs3*fipHPGR(2)-Gs2*p(2,4)+ww(1)*b(2,1)*Smd(1,4)-ww(2)*sum(b(3:13,2).*Smd(3:13,4));...
            Gs3*fipHPGR(3)-Gs2*p(3,4)+ww(1)*b(3,1)*Smd(1,4)+ww(2)*b(3,3)*Smd(2,4)-ww(3)*sum(b(4:13,3).*Smd(4:13,4));...
            Gs3*fipHPGR(4)-Gs2*p(4,4)+ww(1)*b(4,1)*Smd(1,4)+ww(2)*b(4,3)*Smd(2,4)+ww(3)*b(4,3)*Smd(3,4)-ww(4)*sum(b(5:13,4).*Smd(5:13,4));...
            Gs3*fipHPGR(5)-Gs2*p(5,4)+ww(1)*b(5,1)*Smd(1,4)+ww(2)*b(5,3)*Smd(2,4)+ww(3)*b(5,3)*Smd(3,4)+ww(4)*b(5,4)*Smd(4,4)-ww(5)*sum(b(6:13,5).*Smd(6:13,4));...
            Gs3*fipHPGR(6)-Gs2*p(6,4)+ww(1)*b(6,1)*Smd(1,4)+ww(2)*b(6,3)*Smd(2,4)+ww(3)*b(6,3)*Smd(3,4)+ww(4)*b(6,4)*Smd(4,4)+ww(5)*b(6,5)*Smd(5,4)-ww(6)*sum(b(7:13,6).*Smd(7:13,4));...
            Gs3*fipHPGR(7)-Gs2*p(7,4)+ww(1)*b(7,1)*Smd(1,4)+ww(2)*b(7,3)*Smd(2,4)+ww(3)*b(7,3)*Smd(3,4)+ww(4)*b(7,4)*Smd(4,4)+ww(5)*b(7,5)*Smd(5,4)+ww(6)*b(7,6)*Smd(6,4)-ww(7)*sum(b(8:13,7).*Smd(8:13,4));...
            Gs3*fipHPGR(8)-Gs2*p(8,4)+ww(1)*b(8,1)*Smd(1,4)+ww(2)*b(8,3)*Smd(2,4)+ww(3)*b(8,3)*Smd(3,4)+ww(4)*b(8,4)*Smd(4,4)+ww(5)*b(8,5)*Smd(5,4)+ww(6)*b(8,6)*Smd(6,4)+ww(7)*b(8,7)*Smd(7,4)-ww(8)*sum(b(9:13,8).*Smd(9:13,4));...
            Gs3*fipHPGR(9)-Gs2*p(9,4)+ww(1)*b(9,1)*Smd(1,4)+ww(2)*b(9,3)*Smd(2,4)+ww(3)*b(9,3)*Smd(3,4)+ww(4)*b(9,4)*Smd(4,4)+ww(5)*b(9,5)*Smd(5,4)+ww(6)*b(9,6)*Smd(6,4)+ww(7)*b(9,7)*Smd(7,4)+ww(8)*b(9,8)*Smd(8,4)-ww(9)*sum(b(10:13,9).*Smd(10:13,4));...
            Gs3*fipHPGR(10)-Gs2*p(10,4)+ww(1)*b(10,1)*Smd(1,4)+ww(2)*b(10,3)*Smd(2,4)+ww(3)*b(10,3)*Smd(3,4)+ww(4)*b(10,4)*Smd(4,4)+ww(5)*b(10,5)*Smd(5,4)+ww(6)*b(10,6)*Smd(6,4)+ww(7)*b(10,7)*Smd(7,4)+ww(8)*b(10,8)*Smd(8,4)+ww(9)*b(10,9)*Smd(9,4)-ww(10)*sum(b(11:13,10).*Smd(11:13,4));...
            Gs3*fipHPGR(11)-Gs2*p(11,4)+ww(1)*b(11,1)*Smd(1,4)+ww(2)*b(11,3)*Smd(2,4)+ww(3)*b(11,3)*Smd(3,4)+ww(4)*b(11,4)*Smd(4,4)+ww(5)*b(11,5)*Smd(5,4)+ww(6)*b(11,6)*Smd(6,4)+ww(7)*b(11,7)*Smd(7,4)+ww(8)*b(11,8)*Smd(8,4)+ww(9)*b(11,9)*Smd(9,4)+ww(10)*b(11,10)*Smd(10,4)-ww(11)*sum(b(12:13,11).*Smd(12:13,4));...
            Gs3*fipHPGR(12)-Gs2*p(12,4)+ww(1)*b(12,1)*Smd(1,4)+ww(2)*b(12,3)*Smd(2,4)+ww(3)*b(12,3)*Smd(3,4)+ww(4)*b(12,4)*Smd(4,4)+ww(5)*b(12,5)*Smd(5,4)+ww(6)*b(12,6)*Smd(6,4)+ww(7)*b(12,7)*Smd(7,4)+ww(8)*b(12,8)*Smd(8,4)+ww(9)*b(12,9)*Smd(9,4)+ww(10)*b(12,10)*Smd(10,4)+ww(11)*b(12,11)*Smd(11,4)-ww(12)*sum(b(13,12)*Smd(13,4));...
            Gs3*fipHPGR(13)-Gs2*p(13,4)+ww(1)*b(13,1)*Smd(1,4)+ww(2)*b(13,3)*Smd(2,4)+ww(3)*b(13,3)*Smd(3,4)+ww(4)*b(13,4)*Smd(4,4)+ww(5)*b(13,5)*Smd(5,4)+ww(6)*b(13,6)*Smd(6,4)+ww(7)*b(13,7)*Smd(7,4)+ww(8)*b(13,8)*Smd(8,4)+ww(9)*b(13,9)*Smd(9,4)+ww(10)*b(13,10)*Smd(10,4)+ww(11)*b(13,11)*Smd(11,4)+ww(12)*b(13,12)*Smd(12,4)+0*ww(13)];

fg5 = @(t5,ff) [Gs3*fipHPGR(1)-Gs2*p(1,5)-ff(1)*sum(b(2:13,1).*Smd(2:13,5));...
            Gs3*fipHPGR(2)-Gs2*p(2,5)+ff(1)*b(2,1)*Smd(1,5)-ff(2)*sum(b(3:13,2).*Smd(3:13,5));...
            Gs3*fipHPGR(3)-Gs2*p(3,5)+ff(1)*b(3,1)*Smd(1,5)+ff(2)*b(3,3)*Smd(2,5)-ff(3)*sum(b(4:13,3).*Smd(4:13,5));...
            Gs3*fipHPGR(4)-Gs2*p(4,5)+ff(1)*b(4,1)*Smd(1,5)+ff(2)*b(4,3)*Smd(2,5)+ff(3)*b(4,3)*Smd(3,5)-ff(4)*sum(b(5:13,4).*Smd(5:13,5));...
            Gs3*fipHPGR(5)-Gs2*p(5,5)+ff(1)*b(5,1)*Smd(1,5)+ff(2)*b(5,3)*Smd(2,5)+ff(3)*b(5,3)*Smd(3,5)+ff(4)*b(5,4)*Smd(4,5)-ff(5)*sum(b(6:13,5).*Smd(6:13,5));...
            Gs3*fipHPGR(6)-Gs2*p(6,5)+ff(1)*b(6,1)*Smd(1,5)+ff(2)*b(6,3)*Smd(2,5)+ff(3)*b(6,3)*Smd(3,5)+ff(4)*b(6,4)*Smd(4,5)+ff(5)*b(6,5)*Smd(5,5)-ff(6)*sum(b(7:13,6).*Smd(7:13,5));...
            Gs3*fipHPGR(7)-Gs2*p(7,5)+ff(1)*b(7,1)*Smd(1,5)+ff(2)*b(7,3)*Smd(2,5)+ff(3)*b(7,3)*Smd(3,5)+ff(4)*b(7,4)*Smd(4,5)+ff(5)*b(7,5)*Smd(5,5)+ff(6)*b(7,6)*Smd(6,5)-ff(7)*sum(b(8:13,7).*Smd(8:13,5));...
            Gs3*fipHPGR(8)-Gs2*p(8,5)+ff(1)*b(8,1)*Smd(1,5)+ff(2)*b(8,3)*Smd(2,5)+ff(3)*b(8,3)*Smd(3,5)+ff(4)*b(8,4)*Smd(4,5)+ff(5)*b(8,5)*Smd(5,5)+ff(6)*b(8,6)*Smd(6,5)+ff(7)*b(8,7)*Smd(7,5)-ff(8)*sum(b(9:13,8).*Smd(9:13,5));...
            Gs3*fipHPGR(9)-Gs2*p(9,5)+ff(1)*b(9,1)*Smd(1,5)+ff(2)*b(9,3)*Smd(2,5)+ff(3)*b(9,3)*Smd(3,5)+ff(4)*b(9,4)*Smd(4,5)+ff(5)*b(9,5)*Smd(5,5)+ff(6)*b(9,6)*Smd(6,5)+ff(7)*b(9,7)*Smd(7,5)+ff(8)*b(9,8)*Smd(8,5)-ff(9)*sum(b(10:13,9).*Smd(10:13,5));...
            Gs3*fipHPGR(10)-Gs2*p(10,5)+ff(1)*b(10,1)*Smd(1,5)+ff(2)*b(10,3)*Smd(2,5)+ff(3)*b(10,3)*Smd(3,5)+ff(4)*b(10,4)*Smd(4,5)+ff(5)*b(10,5)*Smd(5,5)+ff(6)*b(10,6)*Smd(6,5)+ff(7)*b(10,7)*Smd(7,5)+ff(8)*b(10,8)*Smd(8,5)+ff(9)*b(10,9)*Smd(9,5)-ff(10)*sum(b(11:13,10).*Smd(11:13,5));...
            Gs3*fipHPGR(11)-Gs2*p(11,5)+ff(1)*b(11,1)*Smd(1,5)+ff(2)*b(11,3)*Smd(2,5)+ff(3)*b(11,3)*Smd(3,5)+ff(4)*b(11,4)*Smd(4,5)+ff(5)*b(11,5)*Smd(5,5)+ff(6)*b(11,6)*Smd(6,5)+ff(7)*b(11,7)*Smd(7,5)+ff(8)*b(11,8)*Smd(8,5)+ff(9)*b(11,9)*Smd(9,5)+ff(10)*b(11,10)*Smd(10,5)-ff(11)*sum(b(12:13,11).*Smd(12:13,5));...
            Gs3*fipHPGR(12)-Gs2*p(12,5)+ff(1)*b(12,1)*Smd(1,5)+ff(2)*b(12,3)*Smd(2,5)+ff(3)*b(12,3)*Smd(3,5)+ff(4)*b(12,4)*Smd(4,5)+ff(5)*b(12,5)*Smd(5,5)+ff(6)*b(12,6)*Smd(6,5)+ff(7)*b(12,7)*Smd(7,5)+ff(8)*b(12,8)*Smd(8,5)+ff(9)*b(12,9)*Smd(9,5)+ff(10)*b(12,10)*Smd(10,5)+ff(11)*b(12,11)*Smd(11,5)-ff(12)*sum(b(13,12)*Smd(13,5));...
            Gs3*fipHPGR(13)-Gs2*p(13,5)+ff(1)*b(13,1)*Smd(1,5)+ff(2)*b(13,3)*Smd(2,5)+ff(3)*b(13,3)*Smd(3,5)+ff(4)*b(13,4)*Smd(4,5)+ff(5)*b(13,5)*Smd(5,5)+ff(6)*b(13,6)*Smd(6,5)+ff(7)*b(13,7)*Smd(7,5)+ff(8)*b(13,8)*Smd(8,5)+ff(9)*b(13,9)*Smd(9,5)+ff(10)*b(13,10)*Smd(10,5)+ff(11)*b(13,11)*Smd(11,5)+ff(12)*b(13,12)*Smd(12,5)+0*ff(13)];
        
[t1,xx] = ode45(fg1,tspan,x0);
[t2,yy] = ode45(fg2,tspan,x0);
[t3,zz] = ode45(fg3,tspan,x0);
[t4,ww] = ode45(fg4,tspan,x0);
[t5,ff] = ode45(fg5,tspan,x0);
subplot(2,3,1);
plot(t1,xx)
title('Bloque 1')
subplot(2,3,2);
plot(t2,yy)
title('Bloque 2')
subplot(2,3,3);
plot(t3,zz)
title('Bloque 3')
subplot(2,3,4);
plot(t4,ww)
title('Bloque 4')
subplot(2,3,5);
plot(t5,ff)
title('Bloque 5')
legend('m1','m2','m3','m4','m5','m6','m7','m8','m9','m10','m11','m12','m13','Location','northoutside','Orientation','horizontal')
subplot(2,3,6);
plot(Xtc,fptHPGRu)
title('Tamaño de clase vs %Acumulado pasante total')