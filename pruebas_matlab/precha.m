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
else
    fipHPGR = faHPGR; %Alimentaci�n directa a la zona de chancado cuando es X(i) < a Xc
end
