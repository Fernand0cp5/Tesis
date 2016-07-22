function pruebageneral
%delta = 1e-23;
%tiemporango= [0 4000];
valoresiniciales=[1.9;1.9;1.9;1.9;1.9]; %valores iniciales para densidad 
%options = odeset('RelTol',eps);
[t,d]=ode1(@rodos, 0,1000, valoresiniciales,1);
figure(1)
plot(t,d(1),t,d(2),t,d(3),t,d(4),t,d(5)), hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocm1','rocm2','rocm3','rocm4','rocm5')
%figure(2)
%plot(t,d(6),t,d(7),t,d(8),t,d(9),t,d(10),t,d(11),t,d(12),...
     %t,d(13),t,d(14),t,d(15),t,d(16),t,d(17),t,d(18)),hold on;
end

function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('vol2.mat','vol2');
load('vol3.mat','vol3');
load('vol4.mat','vol4');
load('vol5.mat','vol5');
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
load('Z.mat','Z');
load('Xt.mat','Xt');
load('roa.mat','roa');
load('Gs6.mat','Gs6');
%definicion de variables dependientes
rocm5=vectorvariablesdep(1);
rocm4=vectorvariablesdep(2);
rocm3=vectorvariablesdep(3);
rocm2=vectorvariablesdep(4);
rocm1=vectorvariablesdep(5);

%******************Parámetros Gs(i)****************************************
%Angulo del centro de masa
alfacm5=acos((roa*(D+s0)-rocm5*s0)/(roa*D));
alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
%Area perpendicular al flujo masico
A5=L*(s0+D*(1-cos(alfacm5)));
A4=L*(s0+D*(1-cos(alfacm4)));
A3=L*(s0+D*(1-cos(alfacm3)));
A2=L*(s0+D*(1-cos(alfacm2)));
A1=L*(s0+D*(1-cos(alfacm1)));
%Velocidad de la franja de material
V5=U*cos(alfacm5);
V4=U*cos(alfacm4);
V3=U*cos(alfacm3);
V2=U*cos(alfacm2);
V1=U*cos(alfacm1);
%Flujos
Gs5=3600*V5*A5*rocm5;
Gs4=3600*V4*A4*rocm4;
Gs3=3600*V3*A3*rocm3;
Gs2=3600*V2*A2*rocm2;
Gs1=3600*V1*A1*rocm1;
%Ecuaciones diferenciales
drocm5dt= (Gs6-Gs5)/vol5;
drocm4dt= (Gs5-Gs4)/vol4;
drocm3dt= (Gs4-Gs3)/vol3;
drocm2dt= (Gs3-Gs2)/vol2;
drocm1dt= (Gs2-Gs1)/vol1;
%**************************************************************************

vectorode=[drocm5dt;drocm4dt;drocm3dt;drocm2dt;drocm1dt];

figure(3)
plot(t,Gs5,t,Gs4,t,Gs3,t,Gs2,t,Gs1),hold on
%end
%****************Bloque horizontal 1***************************************
%if t==0
Hkb1 = (1/NB)*Gs5*Z/(3600*U); 
%end
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S(i,k) = (Ppb(k)/Hkb1)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A(1,1) = fipHPGR(1);
%MATRIZ DE REID CONDICIONES
for i=1:n,
    for j=1:n,
        if i<j,
            A(i,j) = 0;
        else if i>j,
                suma = 0;
                for l=j:i-1,
                    suma = suma + b(i,l)*SiE(l)*A(l,j)/(SiE(i)-SiE(j));
                    A(i,j) = suma;
                end
                suma;
            else i=j,
                suma = 0;
                for l=1:i-1,
                    suma = suma + A(i,l);
                    A(i,j) = fipHPGR(i) - suma;
                end
                suma;
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
            suma = suma + A(i,j)*exp(-1*S(j,k)*Z/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p(i,k) = suma;
        end
        suma;
    end
    for i = n;
        p(i,k) = 1 - sum(p(1:n-1,k));
    end
end
%Distribucion de tamaño de partícula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p(i,k); %Sumatoria de las fracciones másicas divididas para el NB
        fptHPGR(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribución de tamaño de partícula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Parámetro fracción en peso que circula en los bordes
E = 0.5*a*NB; %N° de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p(i,k);
    end
    suma;
    fpeHPGR(i) = (suma + (E - round(E))*p(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribución de tamaño de partícula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR(i) = (fptHPGR(i) - a*fpeHPGR(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribución de tamaño de productos en forma acumulada pasante
for i = 1;
    fptHPGRu(i) = 1;
    fpeHPGRu(i) = 1;
    fpcHPGRu(i) = 1;
end
for i = 2:n;
    fptHPGRu(i) = fptHPGRu(i-1) - fptHPGR(i-1);
    fpeHPGRu(i) = fpeHPGRu(i-1) - fpeHPGR(i-1);
    fpcHPGRu(i) = fpcHPGRu(i-1) - fpcHPGR(i-1);
end
fptHPGRu(1:n) = fptHPGRu(1:n)*100;
fpeHPGRu(1:n) = fpeHPGRu(1:n)*100;
fpcHPGRu(1:n) = fpcHPGRu(1:n)*100;
%Conversion de S a [1/h]
Smd = S*3600; 
%**************************************************************************

%****************Bloque horizontal 2***************************************
Hkb2 = (1/NB)*Gs4*Z/(3600*U); 
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
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
                suma;
            else i=j,
                suma = 0;
                for l=1:i-1,
                    suma = suma + A2(i,l);
                    A2(i,j) = fptHPGR(i) - suma;
                end
                suma;
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
            suma = suma + A2(i,j)*exp(-1*S2(j,k)*Z/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p2(i,k) = suma;
        end
        suma;
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
    suma;
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
%Conversion de S a [1/h]
Smd2 = S2*3600; 

%**************************************************************************

%****************Bloque horizontal 3***************************************
Hkb3 = (1/NB)*Gs3*Z/(3600*U) ;
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S3(i,k) = (Ppb(k)/Hkb3)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A3(1,1) = fptHPGR2(1);
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
                suma;
            else i=j,
                suma = 0;
                for l=1:i-1,
                    suma = suma + A3(i,l);
                    A3(i,j) = fptHPGR2(i) - suma;
                end
                suma;
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
            suma = suma + A3(i,j)*exp(-1*S3(j,k)*Z/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p3(i,k) = suma;
        end
        suma;
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
    suma;
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
%Conversion de S a [1/h]
Smd3 = S3*3600; 
%**************************************************************************

%****************Bloque horizontal 4***************************************
Hkb4 = (1/NB)*Gs2*Z/(3600*U);
%velocidad específica de fractura para cada tamaño en cada bloque: S(i,k)
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
                suma;
            else i=j,
                suma = 0;
                for l=1:i-1,
                    suma = suma + A4(i,l);
                    A4(i,j) = fptHPGR3(i) - suma;
                end
                suma;
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
            suma = suma + A4(i,j)*exp(-1*S4(j,k)*Z/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p4(i,k) = suma;
        end
        suma;
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
    suma;
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
%Conversion de S a [1/h]
Smd4 = S4*3600; 
%**************************************************************************

%****************Bloque horizontal 5***************************************
Hkb5 = (1/NB)*Gs1*Z/(3600*U);
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
                suma;
            else i=j,
                suma = 0;
                for l=1:i-1,
                    suma = suma + A5(i,l);
                    A5(i,j) = fptHPGR4(i) - suma;
                end
                suma;
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
            suma = suma + A5(i,j)*exp(-1*S5(j,k)*Z/U);% Distribución granulométrica ec 3.29
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
%**************************************************************************


figure(3)
plot(t,Gs5,t,Gs4,t,Gs3,t,Gs2,t,Gs1),hold on
figure(4)
subplot(2,3,1)
plot(t,Hkb1),hold on
subplot(2,3,2)
plot(t,Hkb2),hold on
subplot(2,3,3)
plot(t,Hkb3),hold on
subplot(2,3,4)
plot(t,Hkb4),hold on
subplot(2,3,[5,6])
plot(t,Hkb5),hold on
figure(5)
subplot(2,3,1)
semilogx(Xt,fptHPGRu,'-s'),hold on
subplot(2,3,2)
semilogx(Xt,fptHPGRu2,'-s'),hold on
subplot(2,3,3)
semilogx(Xt,fptHPGRu3,'-s'),hold on
subplot(2,3,4)
semilogx(Xt,fptHPGRu4,'-s'),hold on
subplot(2,3,[5,6])
semilogx(Xt,fptHPGRu2,'-s'),hold on

xlswrite('datos3.xls',fptHPGRu5)
end