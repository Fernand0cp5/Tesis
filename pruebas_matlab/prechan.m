n = 13;
faHPGR(1) = 0.0239; %fracción retenido discreto, tamaño 45.000 [mm]
faHPGR(2) = 0.4001; %fracción retenido discreto, tamaño 31.500 [mm]
faHPGR(3) = 0.2089; %fracción retenido discreto, tamaño 22.400 [mm]
faHPGR(4) = 0.1090; %fracción retenido discreto, tamaño 16.000 [mm]
faHPGR(5) = 0.0549; %fracción retenido discreto, tamaño 11.200 [mm]
faHPGR(6) = 0.0441; %fracción retenido discreto, tamaño 8.000 [mm]
faHPGR(7) = 0.0542; %fracción retenido discreto, tamaño 5.600 [mm]
faHPGR(8) = 0.0374; %fracción retenido discreto, tamaño 2.800 [mm]
faHPGR(9) = 0.0159; %fracción retenido discreto, tamaño 1.000 [mm]
faHPGR(10) = 0.0085; %fracción retenido discreto, tamaño 0.500 [mm]
faHPGR(11) = 0.0088; %fracción retenido discreto, tamaño 0.315 [mm]
faHPGR(12) = 0.0085; %fracción retenido discreto, tamaño 0.200 [mm]
faHPGR(13) = 0.0258;
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
Xc = 27.6127;
if X(1) > Xc,
 suma = 0;
    for i=1:n,
        if X(i) >= Xc,
            fspHPGR(i) = faHPGR(i)%fraccion masica de particulas alimentadas de clase de tamaño 'l', superior a Xc [ton(l)/ton]
            fbpHPGR(i) = 0
            suma = suma + faHPGR(i)% sumatoria de las fracciones masicas superiores a Xc
            SfspHPGR = suma 
        else
            fspHPGR(i) = 0 
            fbpHPGR(i) = faHPGR(i)%fraccion masica de particulas alimentadas inferior a Xc [ton(i)/ton]
        end
    end
    suma
    for i=1:n,
        fspHPGR(i) = fspHPGR(i)/SfspHPGR
        fbpHPGR(i) = fbpHPGR(i)/(1-SfspHPGR)
    end
end
