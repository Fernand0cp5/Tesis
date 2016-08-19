%**********************PARAMETROS INVARIANTES*****************************
%***************************CHANCADO**************************************
load('n.mat','n');
load('L.mat','L');
load('P.mat','P');
load('Xt.mat','Xt');
% n=evalin('base','n');
% L=evalin('base','L');
% P=evalin('base','P');
% Xt=evalin('base','Xt');
NB = 31; %N� de bloques del perfil de presi�n entre rodillos
%Introducci�n de factor geom�trico, yk:
for k = 1:NB,
    y(k) = (L/(2*NB))*((2*k)-NB-1); %Punto medio de cada bloque k
    NUM(k) = ((L^2)-(4*(y(k)^2))); %Numerador expresi�n de potencia por bloque k
end
SNUM = sum(NUM);
%Potencia por bloque: Ppb(k)
for k = 1:NB,
    Ppb(k) = P*((NUM(k))/SNUM); %Ppb en [kW]
end
Ppb
%INTRODUCCION DE LA FUNCION SELECCION:
%Funci�n selecci�n (HERBST AND FUERSTENAU) para determinar la velocidad
%espec�fica de fractura por tama�o de mineral
%Par�metros del modelo: fabricante M1 y litolog�a Porf�dica.
S1E = 0.75;
Z1 = -1.23;
Z2 = -0.62;
%Variables de entrada:
%Tama�os de clases: X(i) en [mm]
X(1) = Xt(1); %tama�o 45.000 [mm]
X(2) = Xt(2); %tama�o 31.500 [mm]
X(3) = Xt(3); %tama�o 22.400 [mm]
X(4) = Xt(4); %tama�o 16.000 [mm]
X(5) = Xt(5); %tama�o 11.200 [mm]
X(6) = Xt(6); %tama�o 8.000 [mm]
X(7) = Xt(7); %tama�o 5.600 [mm]
X(8) = Xt(8); %tama�o 2.800 [mm]
X(9) = Xt(9); %tama�o 1.000 [mm]
X(10) = Xt(10); %tama�o 0.500 [mm]
X(11) = Xt(11); %tama�o 0.315 [mm]
X(12) = Xt(12); %tama�o 0.200 [mm]
X(13) = Xt(13); %tama�o 0.125 [mm]
%Determinaci�n de los tama�os medios geom�tricos, X
for i=1:n-1,
    X(i)=sqrt(X(i)*X(i+1));
end
for i=n,
    X(i)=X(i)/2;
end
X
for i=1:n,
    %Sea A = log (SiE/S1E)
    A(i) = (Z1*log(X(i)/X(1)))+(Z2*log(X(i)/X(1))^2)
    %Velocidad espec�fica de fractura por tama�o, SiE
    SiE(i) = exp(A(i))*S1E %SiE en [ton/kWh]
end
%INTRODUCCION DE LA FUNCION RUPTURA:
alfa1 = 0.15;
alfa2 = 0.21;
alfa3 = 5.96;
%Variables de entrada:
%Funci�n de la distribucion de fractura primaria B(i)
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
    suma
    for i=n,
        b(i,j)=1-suma;
    end
end
for i=n,
    for j=n,
        b(i,j) = 0;
    end
end
save('Ppb.mat','Ppb');
save('b.mat','b');
save('SiE.mat','SiE');
save('NB.mat','NB');
