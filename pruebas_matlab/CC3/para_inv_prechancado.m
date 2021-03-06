%**********************PARAMETROS INVARIANTES*****************************
%************************PRECHANCADO**************************************
D = 0.8; %Di�metro de los rodillos: D en [m]
L = 0.25; %Largo de los rodillos: L en [m]
s0 = 0.019; %Gap operacional: s0 en [m]
U = 0.67; %Velocidad perif�rica de los rodillos: U en [m/s]
Rp = 41; %Presion de operaci�n: Rp en [bar]
ros = 2.74; %Densidad del s�lido seco: ros en [t/m3]
roa = 1.62; %Densidad aparente de la alimentaci�n: roa en [t/m3]
roe = 0.85*ros; %Densidad aparente enc zona de extrusi�n: roe en [t/m3]
Gs11 = 3600*roe*s0*L*U; % Tonalaje tratado: Gs en [ton/hora]
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresi�n zona de capas de part�culas: alfaIP en [�]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi
%Altura de cada bloque (horizontal)
h = (D/2*sin(alfaIP*pi/180))/1
%Altura de la zona de chancado
Z = (D/2)*sin(alfaIP*pi/180)
P = 2*F*U*sin((alfaIP/2)*(pi/180))
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tama�o cr�tico: Xc en [mm]
n = 13;
faHPGR(1) = 0.0239; %fracci�n retenido discreto, tama�o 45.000 [mm]
faHPGR(2) = 0.4001; %fracci�n retenido discreto, tama�o 31.500 [mm]
faHPGR(3) = 0.2089; %fracci�n retenido discreto, tama�o 22.400 [mm]
faHPGR(4) = 0.1090; %fracci�n retenido discreto, tama�o 16.000 [mm]
faHPGR(5) = 0.0549; %fracci�n retenido discreto, tama�o 11.200 [mm]
faHPGR(6) = 0.0441; %fracci�n retenido discreto, tama�o 8.000 [mm]
faHPGR(7) = 0.0542; %fracci�n retenido discreto, tama�o 5.600 [mm]
faHPGR(8) = 0.0374; %fracci�n retenido discreto, tama�o 2.800 [mm]
faHPGR(9) = 0.0159; %fracci�n retenido discreto, tama�o 1.000 [mm]
faHPGR(10) = 0.0085; %fracci�n retenido discreto, tama�o 0.500 [mm]
faHPGR(11) = 0.0088; %fracci�n retenido discreto, tama�o 0.315 [mm]
faHPGR(12) = 0.0085; %fracci�n retenido discreto, tama�o 0.200 [mm]
faHPGR(13) = 0.0258; %fracci�n retenido discreto, tama�o 0.125 [mm]
aa=sum(faHPGR(1:13));
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
%Algoritmo de Prechancado:
if X(1) > Xc,
    suma = 0;
    for i=1:n;
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
    suma;
    for i=1:n;
        fspHPGR(i) = fspHPGR(i)/SfspHPGR;%Fraccion masica de particulas de clase de tama�o 'l' superior a Xc
        fbpHPGR(i) = fbpHPGR(i)/(1-SfspHPGR);
    end
        %INTRODUCCION DE LA FUNCION RUPTURA:
    %Matriz funci�n ruptura
    %Par�metros del modelo ajustados para: Fabricante M1 y Litolog�a Porf�dica
    alfa1 = 0.15;
    alfa2 = 0.21;
    alfa3 = 5.96;
    %Funci�n de la distribuci�n de fractura primaria B(i)
    %B(i): fracci�n en peso retenida acumulada
    for i=1:n;
        B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
    end
    %Matriz bij: fracci�n en peso de tama�o j que por fractura pasa a tama�o i
    for j=1:n;
        suma = 0;
        for i=1:n-1;
            if i>j,
                b(i,j)=B(i-j+1)-B(i-j+2);
                suma = suma + b(i,j);
            else i<=j,
                b(i,j)=0;
            end
        end
        suma;
        for i=n;
            b(i,j)=1-suma;
        end
    end
    for i=n;
        for j=n;
            b(i,j) = 0;
        end
    end
    %Multiplicaci�n bij con fspHPGR(i):
    for i=1:n;
        suma = 0;
        for l=1:n;
            suma = suma + (b(i,l)*fspHPGR(l));%Ecuacion 3.20
            PspHPGR(i) = suma;%Distribuci�n de tama�o de producto de pre-chancado [Ton(i)/ton] 
        end
        suma;
    end
    %Alimentaci�n a zona de compresi�n multicapa (BP): f(i)ipHPGR en
    %[ton(i)/tonT] (o bi�n: f(i)spHPGR, como descarga de zona de compresi�n de part�culas individuales (SP))
    for i=1:n;
        fipHPGR(i) = (SfspHPGR*PspHPGR(i)+(1-SfspHPGR)*fbpHPGR(i));%Segundo termino: particulas que no fue necesario prefracturarlas
    end
else
    fipHPGR = faHPGR; %Alimentaci�n directa a la zona de chancado cuando es X(i) < a Xc
end
fipHPGR
 Xt = X;
save('fipHPGR.mat','fipHPGR');
save('roe.mat','roe');
save('s0.mat','s0');
save('D.mat','D');
save('n.mat','n');
save('P.mat','P');
save('h.mat','h');
save('U.mat','U');
save('Xt.mat','Xt');
save('L.mat','L');
save('roe.mat','roe');
save('alfaIP.mat','alfaIP');
save('Z.mat','Z');
save('Gs11.mat','Gs11');
save('roa.mat','roa');
 