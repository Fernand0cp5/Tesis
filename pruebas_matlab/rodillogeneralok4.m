function rodillogeneralok4
valoresiniciales=[1.6];
[t,d]=ode1(@rodos,0,60, valoresiniciales,0.1);
t
d(1:600,1)
figure(1)
plot(t(1:600),d(1:600,1)), hold on;
xlabel('Tiempo [s]');
ylabel('Densidad [ton/m^3]');
legend('rocm');
end
function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
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
rocm1=vectorvariablesdep(1);
%**************************************************************************

%****************Bloque horizontal 1***************************************

alfacm1=acos((roa*(D+s0)-rocm1*s0)/(roa*D));
A1=L*(s0+D*(1-cos(alfacm1)));
V1=U*cos(alfacm1);
Gs1=3600*V1*A1*rocm1;
Hkb1 = (1/NB)*3600*(A1*V1*rocm1)*h/(3600*U)

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
p1
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
drocm1dt= (Gs11-Gs1)/vol1;

%**************************************************************************

vectorode=[drocm1dt];
figure(2)
       plot(t,Gs1),hold on;
figure(3)
semilogx(Xt,fptHPGRu1,'-s'),grid on, hold on;
Granulometriasb1 = [fptHPGRu1;fpeHPGRu1;fpcHPGRu1]
end

