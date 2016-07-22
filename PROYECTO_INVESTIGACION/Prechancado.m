function [ SAL ] = PRECHANCADO_HPGR( x )
%ZONA DEFINIDA POR EL ANGULO (ALFASP)EL FLUJO DE MATERIAL GRUESO DE TAMA�O
%SUPERIOR A UNO CRITICO, DEFINIDO COMO Xc, ES FRACTURADO POR LAS CARAS DE
%LOS CILINDROS QUE ATRAPAN LAS PARTICUAS, Y ACELERANDO DE ACUERDO A LA
%VELOCIDAD DE GIRO
%MECANISMO DE RUPTURA 1: PRECHANCADO (ZONA DE COMPRESION DE PARTICULAS
%INDIVIDUALES: SP)
%N� de tama�os de clases:
n = 13;
%Variables de entrada:
%Fracci�n en peso de alimentaci�n discreta al HPGR: f(i)aHPGR en
%[ton(i)/tonT] (13 mallas)
%0.0239	0.4001	0.2089	0.1090	0.0549	0.0441	0.0542	0.0374	0.0159
%0.0085	0.0088	0.0085	0.0258
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
%Tama�o cr�tico de part�cula, previo a zona de compresi�n de capas de
%part�culas: Xc en [mm]
Xc = 27.6127;
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
    suma;
    for i=1:n,
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
        suma;
        for i=n,
            b(i,j)=1-suma;
        end
    end
    for i=n,
        for j=n,
            b(i,j) = 0
        end
    end
    b
    %Multiplicaci�n bij con fspHPGR(i):
    for i=1:n,
        suma = 0;
        for l=1:n,
            suma = suma + (b(i,l)*fspHPGR(l));%Ecuacion 3.20
            PspHPGR(i) = suma;%Distribuci�n de tama�o de producto de pre-chancado [Ton(i)/ton] 
        end
        suma;
    end
    %Alimentaci�n a zona de compresi�n multicapa (BP): f(i)ipHPGR en
    %[ton(i)/tonT] (o bi�n: f(i)spHPGR, como descarga de zona de compresi�n de part�culas individuales (SP))
    for i=1:n,
        fipHPGR(i) = (SfspHPGR*PspHPGR(i)+(1-SfspHPGR)*fbpHPGR(i));%Segundo termino: particulas que no fue necesario prefracturarlas
    end
else
    fipHPGR = faHPGR; %Alimentaci�n directa a la zona de chancado cuando es X(i) < a Xc
end
[ SAL ] = [fipHPGR]
end
