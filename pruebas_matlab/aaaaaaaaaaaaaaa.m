n = 13;
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
    A(i) = (Z1*log(X(i)/X(1)))+(Z2*log(X(i)/X(1))^2)
    %Velocidad específica de fractura por tamaño, SiE
    SiE(i) = exp(A(i))*S1E; %SiE en [ton/kWh]
end