function rodillogeneralok3
valoresiniciales=[1.6;1.6;1.6;1.6;1.6;1.6;1.6;1.6;1.6;1.6];
[t,d]=ode1(@rodos,0,30, valoresiniciales,0.1);
t
d(1:600,1:10)
figure(1)
plot(t(1:600),d(1:600,1),t(1:600),d(1:600,2),t(1:600),d(1:600,3),t(1:600),d(1:600,4),t(1:600),d(1:600,5),...
     t(1:600),d(1:600,6),t(1:600),d(1:600,7),t(1:600),d(1:600,8),t(1:600),d(1:600,9),t(1:600),d(1:600,10)), hold on;
xlabel('Tiempo [s]');
ylabel('Densidad [ton/m^3]');
legend('rocm10','rocm9','rocm8','rocm7','rocm6','rocm5','rocm4','rocm3','rocm2','rocm1');
end
function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('vol2.mat','vol2');
load('vol3.mat','vol3');
load('vol4.mat','vol4');
load('vol5.mat','vol5');
load('vol6.mat','vol6');
load('vol7.mat','vol7');
load('vol8.mat','vol8');
load('vol9.mat','vol9');
load('vol10.mat','vol10');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
load('n.mat','n');
load('NB.mat','NB');
load('Ppb.mat','Ppb');
load('b.mat','b');
load('SiE.mat','SiE');
load('fipHPGR.mat','fipHPGR');
load('h.mat','h');
load('Xt.mat','Xt');
load('roa.mat','roa');
load('Gs11.mat','Gs11');
%definicion de variables dependientes
rocm10=vectorvariablesdep(1);
rocm9=vectorvariablesdep(2);
rocm8=vectorvariablesdep(3);
rocm7=vectorvariablesdep(4);
rocm6=vectorvariablesdep(5);
rocm5=vectorvariablesdep(6);
rocm4=vectorvariablesdep(7);
rocm3=vectorvariablesdep(8);
rocm2=vectorvariablesdep(9);
rocm1=vectorvariablesdep(10);
%**************************************************************************
%****************Bloque horizontal 10**************************************

alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;
Hkb10 = (1/NB)*3600*(A10*V10*rocm10)*h/(3600*U);
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S10(i,k) = (Ppb(k)/Hkb10)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A10(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A10(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A10(l,j)/(SiE(i)-SiE(j));
                    A10(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A10(i,l);
                    A10(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A10(i,j)*exp(-1*S10(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p10(i,k) = suma;
        end
    end
    for i = n;
        p10(i,k) = 1 - sum(p10(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p10(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR10(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p10(i,k);
    end
    fpeHPGR10(i) = (suma + (E - round(E))*p10(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR10(i) = (fptHPGR10(i) - a*fpeHPGR10(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu10(i) = 1;
    fpeHPGRu10(i) = 1;
    fpcHPGRu10(i) = 1;
end
for i = 2:n;
    fptHPGRu10(i) = fptHPGRu10(i-1) - fptHPGR10(i-1);
    fpeHPGRu10(i) = fpeHPGRu10(i-1) - fpeHPGR10(i-1);
    fpcHPGRu10(i) = fpcHPGRu10(i-1) - fpcHPGR10(i-1);
end
fptHPGRu10(1:n) = fptHPGRu10(1:n)*100;
fpeHPGRu10(1:n) = fpeHPGRu10(1:n)*100;
fpcHPGRu10(1:n) = fpcHPGRu10(1:n)*100;
%**************************************************************************

%****************Bloque horizontal 9**************************************

alfacm9=acos((rocm10*(D+s0)-rocm9*s0)/(rocm10*D));
A9=L*(s0+D*(1-cos(alfacm9)));
V9=U*cos(alfacm9);
Gs9=3600*V9*A9*rocm9;
Hkb9 = (1/NB)*3600*(A9*V9*rocm9)*h/(3600*U);
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S9(i,k) = (Ppb(k)/Hkb9)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A9(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A9(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A9(l,j)/(SiE(i)-SiE(j));
                    A9(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A9(i,l);
                    A9(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A9(i,j)*exp(-1*S9(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p9(i,k) = suma;
        end
    end
    for i = n;
        p9(i,k) = 1 - sum(p9(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p9(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR9(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p9(i,k);
    end
    fpeHPGR9(i) = (suma + (E - round(E))*p9(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR9(i) = (fptHPGR9(i) - a*fpeHPGR9(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu9(i) = 1;
    fpeHPGRu9(i) = 1;
    fpcHPGRu9(i) = 1;
end
for i = 2:n;
    fptHPGRu9(i) = fptHPGRu9(i-1) - fptHPGR9(i-1);
    fpeHPGRu9(i) = fpeHPGRu9(i-1) - fpeHPGR9(i-1);
    fpcHPGRu9(i) = fpcHPGRu9(i-1) - fpcHPGR9(i-1);
end
fptHPGRu9(1:n) = fptHPGRu9(1:n)*100;
fpeHPGRu9(1:n) = fpeHPGRu9(1:n)*100;
fpcHPGRu9(1:n) = fpcHPGRu9(1:n)*100;
%**************************************************************************

%****************Bloque horizontal 8**************************************

alfacm8=acos((rocm9*(D+s0)-rocm8*s0)/(rocm9*D));
A8=L*(s0+D*(1-cos(alfacm8)));
V8=U*cos(alfacm8);
Gs8=3600*V8*A8*rocm8;
Hkb8 = (1/NB)*3600*(A8*V8*rocm8)*h/(3600*U);
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S8(i,k) = (Ppb(k)/Hkb8)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A8(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A8(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A8(l,j)/(SiE(i)-SiE(j));
                    A8(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A8(i,l);
                    A8(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A8(i,j)*exp(-1*S8(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p8(i,k) = suma;
        end
    end
    for i = n;
        p8(i,k) = 1 - sum(p8(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p8(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR8(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p8(i,k);
    end
    fpeHPGR8(i) = (suma + (E - round(E))*p8(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR8(i) = (fptHPGR8(i) - a*fpeHPGR8(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu8(i) = 1;
    fpeHPGRu8(i) = 1;
    fpcHPGRu8(i) = 1;
end
for i = 2:n;
    fptHPGRu8(i) = fptHPGRu8(i-1) - fptHPGR8(i-1);
    fpeHPGRu8(i) = fpeHPGRu8(i-1) - fpeHPGR8(i-1);
    fpcHPGRu8(i) = fpcHPGRu8(i-1) - fpcHPGR8(i-1);
end
fptHPGRu8(1:n) = fptHPGRu8(1:n)*100;
fpeHPGRu8(1:n) = fpeHPGRu8(1:n)*100;
fpcHPGRu8(1:n) = fpcHPGRu8(1:n)*100;
%**************************************************************************

%****************Bloque horizontal 7***************************************

alfacm7=acos((rocm8*(D+s0)-rocm7*s0)/(rocm8*D));
A7=L*(s0+D*(1-cos(alfacm7)));
V7=U*cos(alfacm7);
Gs7=3600*V7*A7*rocm7;
Hkb7 = (1/NB)*3600*(A7*V7*rocm7)*h/(3600*U);
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S7(i,k) = (Ppb(k)/Hkb7)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A7(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A7(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A7(l,j)/(SiE(i)-SiE(j));
                    A7(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A7(i,l);
                    A7(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A7(i,j)*exp(-1*S7(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p7(i,k) = suma;
        end
    end
    for i = n;
        p7(i,k) = 1 - sum(p7(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p7(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR7(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p7(i,k);
    end
    fpeHPGR7(i) = (suma + (E - round(E))*p7(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR7(i) = (fptHPGR7(i) - a*fpeHPGR7(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu7(i) = 1;
    fpeHPGRu7(i) = 1;
    fpcHPGRu7(i) = 1;
end
for i = 2:n;
    fptHPGRu7(i) = fptHPGRu7(i-1) - fptHPGR7(i-1);
    fpeHPGRu7(i) = fpeHPGRu7(i-1) - fpeHPGR7(i-1);
    fpcHPGRu7(i) = fpcHPGRu7(i-1) - fpcHPGR7(i-1);
end
fptHPGRu7(1:n) = fptHPGRu7(1:n)*100;
fpeHPGRu7(1:n) = fpeHPGRu7(1:n)*100;
fpcHPGRu7(1:n) = fpcHPGRu7(1:n)*100;
%**************************************************************************

%****************Bloque horizontal 6***************************************

alfacm6=acos((rocm7*(D+s0)-rocm6*s0)/(rocm7*D));
A6=L*(s0+D*(1-cos(alfacm6)));
V6=U*cos(alfacm6);
Gs6=3600*V6*A6*rocm6;
Hkb6 = (1/NB)*3600*(A6*V6*rocm6)*h/(3600*U);

%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S6(i,k) = (Ppb(k)/Hkb6)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A6(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A6(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A6(l,j)/(SiE(i)-SiE(j));
                    A6(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A6(i,l);
                    A6(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A6(i,j)*exp(-1*S6(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p6(i,k) = suma;
        end
    end
    for i = n;
        p6(i,k) = 1 - sum(p6(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p6(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR6(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p6(i,k);
    end
    fpeHPGR6(i) = (suma + (E - round(E))*p6(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR6(i) = (fptHPGR6(i) - a*fpeHPGR6(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu6(i) = 1;
    fpeHPGRu6(i) = 1;
    fpcHPGRu6(i) = 1;
end
for i = 2:n;
    fptHPGRu6(i) = fptHPGRu6(i-1) - fptHPGR6(i-1);
    fpeHPGRu6(i) = fpeHPGRu6(i-1) - fpeHPGR6(i-1);
    fpcHPGRu6(i) = fpcHPGRu6(i-1) - fpcHPGR6(i-1);
end
fptHPGRu6(1:n) = fptHPGRu6(1:n)*100;
fpeHPGRu6(1:n) = fpeHPGRu6(1:n)*100;
fpcHPGRu6(1:n) = fpcHPGRu6(1:n)*100;
%**************************************************************************

%****************Bloque horizontal 5***************************************

alfacm5=acos((rocm6*(D+s0)-rocm5*s0)/(rocm6*D));
A5=L*(s0+D*(1-cos(alfacm5)));
V5=U*cos(alfacm5);
Gs5=3600*V5*A5*rocm5;
Hkb5 = (1/NB)*3600*(A5*V5*rocm5)*h/(3600*U);

%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S5(i,k) = (Ppb(k)/Hkb5)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A5(1,1) = fipHPGR(1);
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
%**************************************************************************

%****************Bloque horizontal 4***************************************

alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
A4=L*(s0+D*(1-cos(alfacm4)));
V4=U*cos(alfacm4);
Gs4=3600*V4*A4*rocm4;
Hkb4 = (1/NB)*3600*(A4*V4*rocm4)*h/(3600*U);

%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S4(i,k) = (Ppb(k)/Hkb4)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A4(1,1) = fipHPGR(1);
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
%Distribución del tamaño de partícula en zona BP,
%Granulometria por bloques 
for k = 1:NB;
    for i = 1:n-1;
        suma = 0;
        for j = 1:i;
            suma = suma + A4(i,j)*exp(-1*S4(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p4(i,k) = suma;
        end
    end
    for i = n;
        p4(i,k) = 1 - sum(p4(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p4(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR4(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p4(i,k);
    end
    fpeHPGR4(i) = (suma + (E - round(E))*p4(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR4(i) = (fptHPGR4(i) - a*fpeHPGR4(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
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
%**************************************************************************

%****************Bloque horizontal 3***************************************

alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
A3=L*(s0+D*(1-cos(alfacm3)));
V3=U*cos(alfacm3);
Gs3=3600*V3*A3*rocm3;
Hkb3 = (1/NB)*3600*(A3*V3*rocm3)*h/(3600*U);

%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S3(i,k) = (Ppb(k)/Hkb3)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A3(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A3(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A3(l,j)/(SiE(i)-SiE(j));
                    A3(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A3(i,l);
                    A3(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A3(i,j)*exp(-1*S3(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p3(i,k) = suma;
        end
    end
    for i = n;
        p3(i,k) = 1 - sum(p3(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p3(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR3(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p3(i,k);
    end
    fpeHPGR3(i) = (suma + (E - round(E))*p3(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR3(i) = (fptHPGR3(i) - a*fpeHPGR3(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu3(i) = 1;
    fpeHPGRu3(i) = 1;
    fpcHPGRu3(i) = 1;
end
for i = 2:n;
    fptHPGRu3(i) = fptHPGRu3(i-1) - fptHPGR3(i-1);
    fpeHPGRu3(i) = fpeHPGRu3(i-1) - fpeHPGR3(i-1);
    fpcHPGRu3(i) = fpcHPGRu3(i-1) - fpcHPGR3(i-1);
end
fptHPGRu3(1:n) = fptHPGRu3(1:n)*100;
fpeHPGRu3(1:n) = fpeHPGRu3(1:n)*100;
fpcHPGRu3(1:n) = fpcHPGRu3(1:n)*100;
%**************************************************************************

%****************Bloque horizontal 2***************************************

alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
A2=L*(s0+D*(1-cos(alfacm2)));
V2=U*cos(alfacm2);
Gs2=3600*V2*A2*rocm2;
Hkb2 = (1/NB)*3600*(A2*V2*rocm2)*h/(3600*U);

%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S2(i,k) = (Ppb(k)/Hkb2)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A2(1,1) = fipHPGR(1);
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
%Distribución del tamaño de partícula en zona BP,
%Granulometria por bloques 
for k = 1:NB;
    for i = 1:n-1;
        suma = 0;
        for j = 1:i;
            suma = suma + A2(i,j)*exp(-1*S2(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p2(i,k) = suma;
        end
    end
    for i = n;
        p2(i,k) = 1 - sum(p2(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p2(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR2(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p2(i,k);
    end
    fpeHPGR2(i) = (suma + (E - round(E))*p2(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR2(i) = (fptHPGR2(i) - a*fpeHPGR2(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
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
%**************************************************************************

%****************Bloque horizontal 1***************************************

alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
A1=L*(s0+D*(1-cos(alfacm1)));
V1=U*cos(alfacm1);
Gs1=3600*V1*A1*rocm1;
Hkb1 = (1/NB)*3600*(A1*V1*rocm1)*h/(3600*U);

%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S1(i,k) = (Ppb(k)/Hkb1)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end

%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A1(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A1(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A1(l,j)/(SiE(i)-SiE(j));
                    A1(i,j) = suma;
                end
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A1(i,l);
                    A1(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A1(i,j)*exp(-1*S1(j,k)*h/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p1(i,k) = suma;
        end
    end
    for i = n;
        p1(i,k) = 1 - sum(p1(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p1(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR1(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p1(i,k);
    end
    fpeHPGR1(i) = (suma + (E - round(E))*p1(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR1(i) = (fptHPGR1(i) - a*fpeHPGR1(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu1(i) = 1;
    fpeHPGRu1(i) = 1;
    fpcHPGRu1(i) = 1;
end
for i = 2:n;
    fptHPGRu1(i) = fptHPGRu1(i-1) - fptHPGR1(i-1);
    fpeHPGRu1(i) = fpeHPGRu1(i-1) - fpeHPGR1(i-1);
    fpcHPGRu1(i) = fpcHPGRu1(i-1) - fpcHPGR1(i-1);
end
fptHPGRu1(1:n) = fptHPGRu1(1:n)*100;
fpeHPGRu1(1:n) = fpeHPGRu1(1:n)*100;
fpcHPGRu1(1:n) = fpcHPGRu1(1:n)*100;
%**************************************************************************

%******************Parámetros Gs(i)****************************************
%definicion ecuaciones diferenciales
drocm10dt= (Gs11-Gs10)/vol10;
drocm9dt= (Gs10-Gs9)/vol9;
drocm8dt= (Gs9-Gs8)/vol8;
drocm7dt= (Gs8-Gs7)/vol7;
drocm6dt= (Gs7-Gs6)/vol6;
drocm5dt= (Gs6-Gs5)/vol5;
drocm4dt= (Gs5-Gs4)/vol4;
drocm3dt= (Gs4-Gs3)/vol3;
drocm2dt= (Gs3-Gs2)/vol2;
drocm1dt= (Gs2-Gs1)/vol1;

%**************************************************************************

vectorode=[drocm10dt; drocm9dt; drocm8dt; drocm7dt; drocm6dt;...
           drocm5dt; drocm4dt; drocm3dt; drocm2dt; drocm1dt];
figure(2)
       plot(t,Gs10,t,Gs9,t,Gs8,t,Gs7,t,Gs6,t,Gs5,t,Gs4,t,Gs3,t,Gs2,t,Gs1),hold on;
figure(3)
semilogx(Xt,fptHPGRu1,'-s'),grid on, hold on;
Granulometriasb10 = [fptHPGRu10;fpeHPGRu10;fpcHPGRu10]
Granulometriasb9 = [fptHPGRu9;fpeHPGRu9;fpcHPGRu9]
Granulometriasb8 = [fptHPGRu8;fpeHPGRu8;fpcHPGRu8]
Granulometriasb7 = [fptHPGRu7;fpeHPGRu7;fpcHPGRu7]
Granulometriasb6 = [fptHPGRu6;fpeHPGRu6;fpcHPGRu6]
Granulometriasb5 = [fptHPGRu5;fpeHPGRu5;fpcHPGRu5]
Granulometriasb4 = [fptHPGRu4;fpeHPGRu4;fpcHPGRu4]
Granulometriasb3 = [fptHPGRu3;fpeHPGRu3;fpcHPGRu3]
Granulometriasb2 = [fptHPGRu2;fpeHPGRu2;fpcHPGRu2]
Granulometriasb1 = [fptHPGRu1;fpeHPGRu1;fpcHPGRu1]
end

    