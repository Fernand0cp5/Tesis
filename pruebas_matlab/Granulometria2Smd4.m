function Salida=Granulometria2Smd4(Entrada)
Gs2=Entrada(1);
fptHPGR3=Entrada(2);
load('U.mat','U');
load('n.mat','n');
load('NB.mat','NB');
load('Ppb.mat','Ppb');
load('b.mat','b');
load('SiE.mat','SiE');
load('fipHPGR.mat','fipHPGR');
load('h.mat','h');
Hkb4 = (1/NB)*Gs2*h/(3600*U);
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S4(i,k) = (Ppb(k)/Hkb4)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A4(1,1) = fptHPGR3(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A4(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A4(l,j)/(SiE(i)-SiE(j));
                    A4(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A4(i,l);
                    A4(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A4(i,j)*exp(-1*S4(j,k)*h/U);% Distribuci�n granulom�trica ec 3.29
            %de producto de la zona de compresi�n de capas de part�culas, para cada bloque k, [ton(i)/ton
            p4(i,k) = suma;
        end
    end
    for i = n;
        p4(i,k) = 1 - sum(p4(1:n-1,k));
    end
end
%Distribucion de tama�o de part�cula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p4(i,k); %Sumatoria de las fracciones m�sicas divididas para el NB
        fptHPGR4(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribuci�n de tama�o de part�cula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Par�metro fracci�n en peso que circula en los bordes
E = 0.5*a*NB; %N� de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p4(i,k);
    end
    suma;
    fpeHPGR4(i) = (suma + (E - round(E))*p4(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribuci�n de tama�o de part�cula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR4(i) = (fptHPGR4(i) - a*fpeHPGR4(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribuci�n de tama�o de productos en forma acumulada pasante
for i = 1;
    fptHPGRu4(i) = 1;
    fpeHPGRu4(i) = 1;
    fpcHPGRu4(i) = 1;
end
for i = 2:n;
    fptHPGRu4(i) = fptHPGRu4(i-1) - fptHPGR4(i-1);
    fpeHPGRu4(i) = fpeHPGRu4(i-1) - fpeHPGR4(i-1);
    fpcHPGRu4(i) = fpcHPGRu4(i-1) - fpcHPGR4(i-1);
end
fptHPGRu4(1:n) = fptHPGRu4(1:n)*100;
fpeHPGRu4(1:n) = fpeHPGRu4(1:n)*100;
fpcHPGRu4(1:n) = fpcHPGRu4(1:n)*100;
%Conversion de S a [1/h]
Smd4 = S4*3600;
Salida=[Smd4];
end