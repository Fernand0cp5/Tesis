function Salida=ChancadoSiE(Entrada)
Xt(1)=Entrada(14);
Xt(2)=Entrada(15);
Xt(3)=Entrada(16);
Xt(4)=Entrada(17);
Xt(5)=Entrada(18);
Xt(6)=Entrada(19);
Xt(7)=Entrada(20);
Xt(8)=Entrada(21);
Xt(9)=Entrada(22);
Xt(10)=Entrada(23);
Xt(11)=Entrada(24);
Xt(12)=Entrada(25);
Xt(13)=Entrada(26);
n=13;
%INTRODUCCION DE LA FUNCION SELECCION:
%Función selección (HERBST AND FUERSTENAU) para determinar la velocidad
%específica de fractura por tamaño de mineral
%Parámetros del modelo: fabricante M1 y litología Porfídica.
S1E = 0.30;
Z1 = -1.23;
Z2 = -0.62;
%Variables de entrada:
%Tamaños de clases: X(i) en [mm]
X(1) = Xt(1); %tamaño 45.000 [mm]
X(2) = Xt(2); %tamaño 31.500 [mm]
X(3) = Xt(3); %tamaño 22.400 [mm]
X(4) = Xt(4); %tamaño 16.000 [mm]
X(5) = Xt(5); %tamaño 11.200 [mm]
X(6) = Xt(6); %tamaño 8.000 [mm]
X(7) = Xt(7); %tamaño 5.600 [mm]
X(8) = Xt(8); %tamaño 2.800 [mm]
X(9) = Xt(9); %tamaño 1.000 [mm]
X(10) = Xt(10); %tamaño 0.500 [mm]
X(11) = Xt(11); %tamaño 0.315 [mm]
X(12) = Xt(12); %tamaño 0.200 [mm]
X(13) = Xt(13); %tamaño 0.125 [mm]
%Determinación de los tamaños medios geométricos, X
for i=1:n-1;
    X(i)=sqrt(X(i)*X(i+1));
end
for i=n;
    X(i)=X(i)/2;
end
for i=1:n;
    %Sea A = log (SiE/S1E)
    A(i) = (Z1*log(X(i)/X(1)))+(Z2*log(X(i)/X(1))^2);
    %Velocidad específica de fractura por tamaño, SiE
    SiE(i) = exp(A(i))*S1E; %SiE en [ton/kWh]
end
Salida=[SiE];
end