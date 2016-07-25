function Salida=Chancadobij2(Entrada)
Xt(1)=Entrada(1);
Xt(2)=Entrada(2);
Xt(3)=Entrada(3);
Xt(4)=Entrada(4);
Xt(5)=Entrada(5);
Xt(6)=Entrada(6);
Xt(7)=Entrada(7);
Xt(8)=Entrada(8);
Xt(9)=Entrada(9);
Xt(10)=Entrada(10);
Xt(11)=Entrada(11);
Xt(12)=Entrada(12);
Xt(13)=Entrada(13);
n=13;
%INTRODUCCION DE LA FUNCION SELECCION:
%Funci�n selecci�n (HERBST AND FUERSTENAU) para determinar la velocidad
%espec�fica de fractura por tama�o de mineral
%Par�metros del modelo: fabricante M1 y litolog�a Porf�dica.
S1E = 0.30;
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
for i=1:n-1;
    X(i)=sqrt(X(i)*X(i+1));
end
for i=n;
    X(i)=X(i)/2;
end
%INTRODUCCION DE LA FUNCION RUPTURA:
alfa1 = 0.27;
alfa2 = 0.21;
alfa3 = 1.25;
%Variables de entrada:
%Funci�n de la distribucion de fractura primaria B(i)
%B(i): fracci�n en peso retenida acumulada
for i=1:n,
    B(i) = alfa1*((X(i)/X(2))^alfa2)+(1-alfa1)*((X(i)/X(2))^alfa3);
end
%Matriz bij: fracci�n en peso de tama�o j que por fractura pasa a tama�o i
for j=1:n;
    suma = 0;
    for i=1:n-1;
        if i>j;
            b(i,j)=B(i-j+1)-B(i-j+2);
            suma = suma + b(i,j);
        else i<=j;
            b(i,j)=0;
        end
    end
    for i=n;
        b(i,j)=1-suma;
    end
end
for i=n;
    for j=n;
        b(i,j) = 0;
    end
end
Salida=[b];
end