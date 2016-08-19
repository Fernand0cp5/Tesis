function Salida=Prechancado1(Entrada)
faHPGR(1) = Entrada(1); %fracción retenido discreto, tamaño 45.000 [mm]
faHPGR(2) = Entrada(2);%fracción retenido discreto, tamaño 31.500 [mm]
faHPGR(3) = Entrada(3); %fracción retenido discreto, tamaño 22.400 [mm]
faHPGR(4) = Entrada(4);%fracción retenido discreto, tamaño 16.000 [mm]
faHPGR(5) = Entrada(5);%fracción retenido discreto, tamaño 11.200 [mm]
faHPGR(6) = Entrada(6);%fracción retenido discreto, tamaño 8.000 [mm]
faHPGR(7) = Entrada(7);%fracción retenido discreto, tamaño 5.600 [mm]
faHPGR(8) = Entrada(8);%fracción retenido discreto, tamaño 2.800 [mm]
faHPGR(9) = Entrada(9);%fracción retenido discreto, tamaño 1.000 [mm]
faHPGR(10) = Entrada(10);%fracción retenido discreto, tamaño 0.500 [mm]
faHPGR(11) = Entrada(11);%fracción retenido discreto, tamaño 0.315 [mm]
faHPGR(12) = Entrada(12);%fracción retenido discreto, tamaño 0.200 [mm]
faHPGR(13) = Entrada(13);%fracción retenido discreto, tamaño 0.125 [mm]
Xc=Entrada(14);
n = 13;
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
Salida=[fipHPGR];
end