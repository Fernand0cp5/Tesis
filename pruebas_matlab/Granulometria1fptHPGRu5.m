function Salida=Granulometria1fptHPGRu5(Entrada)
Gs1=Entrada(1);
fptHPGR4=Entrada(2);
load('U.mat','U');
load('n.mat','n');
load('NB.mat','NB');
load('Ppb.mat','Ppb');
load('b.mat','b');
load('SiE.mat','SiE');
load('fipHPGR.mat','fipHPGR');
load('h.mat','h');
Hkb5 = (1/NB)*Gs1*h/(3600*U);
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S5(i,k) = (Ppb(k)/Hkb5)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A5(1,1) = fptHPGR4(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A5(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A5(l,j)/(SiE(i)-SiE(j));
                    A5(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A5(i,l);
                    A5(i,j) = fipHPGR(i) - suma;
                end
            end
        end
    end
end
%Distribución del tamaño de partícula en zona BP,
%Granulometria por bloques 
for k = 1:NB;
    for i = 1:n-1;
        suma = 0;
        for j = 1:i;
            suma = suma + A5(i,j)*exp(-1*S5(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p5(i,k) = suma;
        end
        suma;
    end
    for i = n;
        p5(i,k) = 1 - sum(p5(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p5(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR5(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p5(i,k);
    end
    suma;
    fpeHPGR5(i) = (suma + (E - round(E))*p5(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR5(i) = (fptHPGR5(i) - a*fpeHPGR5(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu5(i) = 1;
    fpeHPGRu5(i) = 1;
    fpcHPGRu5(i) = 1;
end
for i = 2:n;
    fptHPGRu5(i) = fptHPGRu5(i-1) - fptHPGR5(i-1);
    fpeHPGRu5(i) = fpeHPGRu5(i-1) - fpeHPGR5(i-1);
    fpcHPGRu5(i) = fpcHPGRu5(i-1) - fpcHPGR5(i-1);
end
fptHPGRu5(1:n) = fptHPGRu5(1:n)*100;
fpeHPGRu5(1:n) = fpeHPGRu5(1:n)*100;
fpcHPGRu5(1:n) = fpcHPGRu5(1:n)*100;
%Conversion de S a [1/h]
Smd5 = S5*3600; 
Salida=[fptHPGRu5];
end