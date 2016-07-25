function Salida=Prechancado2(Entrada)
D = Entrada(1); %Diámetro de los rodillos: D en [m]
L = Entrada(2); %Largo de los rodillos: L en [m]
s0 = Entrada(3); %Gap operacional: s0 en [m]
U = Entrada(4); %Velocidad periférica de los rodillos: U en [m/s]
Rp = Entrada(5); %Presion de operación: Rp en [bar]
ros = Entrada(6); %Densidad del sólido seco: ros en [t/m3]
roa = Entrada(7); %Densidad aparente de la alimentación: roa en [t/m3]
n = Entrada(8);
faHPGR(1) = Entrada(9); %fracción retenido discreto, tamaño 45.000 [mm]
faHPGR(2) = Entrada(10);%fracción retenido discreto, tamaño 31.500 [mm]
faHPGR(3) = Entrada(11); %fracción retenido discreto, tamaño 22.400 [mm]
faHPGR(4) = Entrada(12);%fracción retenido discreto, tamaño 16.000 [mm]
faHPGR(5) = Entrada(13);%fracción retenido discreto, tamaño 11.200 [mm]
faHPGR(6) = Entrada(14);%fracción retenido discreto, tamaño 8.000 [mm]
faHPGR(7) = Entrada(15);%fracción retenido discreto, tamaño 5.600 [mm]
faHPGR(8) = Entrada(16);%fracción retenido discreto, tamaño 2.800 [mm]
faHPGR(9) = Entrada(17);%fracción retenido discreto, tamaño 1.000 [mm]
faHPGR(10) = Entrada(18);%fracción retenido discreto, tamaño 0.500 [mm]
faHPGR(11) = Entrada(19);%fracción retenido discreto, tamaño 0.315 [mm]
faHPGR(12) = Entrada(20);%fracción retenido discreto, tamaño 0.200 [mm]
faHPGR(13) = Entrada(21);%fracción retenido discreto, tamaño 0.125 [mm]
roe = 0.85*ros; %Densidad aparente enc zona de extrusión: roe en [t/m3]
Gs11 = 3600*roe*s0*L*U; % Tonalaje tratado: Gs en [ton/hora]
F = 100*Rp*L*D/2; %Fuerza de molienda: F en [kN]
%Angulo de compresión zona de capas de partículas: alfaIP en [°]
alfaIP = acos((1/(2*D))*((s0+D)+sqrt(((s0+D)^2)-(4*s0*roe*D/roa))))*180/pi;
%Altura de cada bloque (horizontal)
h = (D/2*sin(alfaIP*pi/180))/10;
%Altura de la zona de chancado
Z = (D/2)*sin(alfaIP*pi/180);
P = 2*F*U*sin((alfaIP/2)*(pi/180));
Xc = (s0 + D*(1-cos(alfaIP*pi/180)))*1000; %Tamaño crítico: Xc en [mm]
%Tamaños de clases de partícula: X(i) en [mm] (13 mallas)
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
        fspHPGR(i) = fspHPGR(i)/SfspHPGR;%Fraccion masica de particulas de clase de tamaño 'l' superior a Xc
        fbpHPGR(i) = fbpHPGR(i)/(1-SfspHPGR);
    end
        %INTRODUCCION DE LA FUNCION RUPTURA:
    %Matriz función ruptura
    %Parámetros del modelo ajustados para: Fabricante M1 y Litología Porfídica
    alfa1 = 0.15;
    alfa2 = 0.21;
    alfa3 = 5.96;
    %Función de la distribución de fractura primaria B(i)
    %B(i): fracción en peso retenida acumulada
    for i=1:n;
        B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
    end
    %Matriz bij: fracción en peso de tamaño j que por fractura pasa a tamaño i
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
    %Multiplicación bij con fspHPGR(i):
    for i=1:n;
        suma = 0;
        for l=1:n;
            suma = suma + (b(i,l)*fspHPGR(l));%Ecuacion 3.20
            PspHPGR(i) = suma;%Distribución de tamaño de producto de pre-chancado [Ton(i)/ton] 
        end
        suma;
    end
    %Alimentación a zona de compresión multicapa (BP): f(i)ipHPGR en
    %[ton(i)/tonT] (o bién: f(i)spHPGR, como descarga de zona de compresión de partículas individuales (SP))
    for i=1:n;
        fipHPGR(i) = (SfspHPGR*PspHPGR(i)+(1-SfspHPGR)*fbpHPGR(i));%Segundo termino: particulas que no fue necesario prefracturarlas
    end
else
    fipHPGR = faHPGR; %Alimentación directa a la zona de chancado cuando es X(i) < a Xc
end
 Xt = X;
Salida=[Xt];
end