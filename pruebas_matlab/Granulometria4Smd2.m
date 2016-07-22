function Salida=Granulometria4Smd2(Entrada)
Gs4=Entrada(1);
fptHPGR=Entrada(2);
load('U.mat','U');
load('n.mat','n');
load('NB.mat','NB');
load('Ppb.mat','Ppb');
load('b.mat','b');
load('SiE.mat','SiE');
load('fipHPGR.mat','fipHPGR');
load('h.mat','h');
Hkb2 = (1/NB)*Gs4*h/(3600*U);
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S2(i,k) = (Ppb(k)/Hkb2)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A2(1,1) = fptHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A2(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A2(l,j)/(SiE(i)-SiE(j));
                    A2(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A2(i,l);
                    A2(i,j) = fipHPGR(i) - suma;
                end
            end
        end
    end
end
%Distribuci�n del tama�o de part�cula en zona BP,
%Granulometria por bloques 
for k = 1:NB;
    for i = 1:n-1;
        suma = 0;
        for j = 1:i;
            suma = suma + A2(i,j)*exp(-1*S2(j,k)*h/U);% Distribuci�n granulom�trica ec 3.29
            %de producto de la zona de compresi�n de capas de part�culas, para cada bloque k, [ton(i)/ton
            p2(i,k) = suma;
        end
    end
    for i = n;
        p2(i,k) = 1 - sum(p2(1:n-1,k));
    end
end
%Distribucion de tama�o de part�cula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p2(i,k); %Sumatoria de las fracciones m�sicas divididas para el NB
        fptHPGR2(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribuci�n de tama�o de part�cula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Par�metro fracci�n en peso que circula en los bordes
E = 0.5*a*NB; %N� de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p2(i,k);
    end
    fpeHPGR2(i) = (suma + (E - round(E))*p2(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribuci�n de tama�o de part�cula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR2(i) = (fptHPGR2(i) - a*fpeHPGR2(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribuci�n de tama�o de productos en forma acumulada pasante
for i = 1;
    fptHPGRu2(i) = 1;
    fpeHPGRu2(i) = 1;
    fpcHPGRu2(i) = 1;
end
for i = 2:n;
    fptHPGRu2(i) = fptHPGRu2(i-1) - fptHPGR2(i-1);
    fpeHPGRu2(i) = fpeHPGRu2(i-1) - fpeHPGR2(i-1);
    fpcHPGRu2(i) = fpcHPGRu2(i-1) - fpcHPGR2(i-1);
end
fptHPGRu2(1:n) = fptHPGRu2(1:n)*100;
fpeHPGRu2(1:n) = fpeHPGRu2(1:n)*100;
fpcHPGRu2(1:n) = fpcHPGRu2(1:n)*100;
%Conversion de S a [1/h]
Smd2 = S2*3600;
Salida=[Smd2];
end