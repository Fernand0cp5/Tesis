function rodillogeneralok1bloque
valoresiniciales=[1.8;...
                  4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6; 4.7411e-6];
[t,d]=ode1(@rodos,0,60, valoresiniciales,0.1);
t
d(1:600,1)
figure(1)
plot(t(1:600),d(1:600,1)), hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocmt')
%figure(2)
%plot(t,d(6),t,d(7),t,d(8),t,d(9),t,d(10),t,d(11),t,d(12),...
     %t,d(13),t,d(14),t,d(15),t,d(16),t,d(17),t,d(18)),hold on;
end
function vectorode =rodos(t, vectorvariablesdep)
load('volt.mat','volt');
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
ma1=vectorvariablesdep(2);
mb1=vectorvariablesdep(3);
mc1=vectorvariablesdep(4);
md1=vectorvariablesdep(5);
me1=vectorvariablesdep(6);
mf1=vectorvariablesdep(7);
mg1=vectorvariablesdep(8);
mh1=vectorvariablesdep(9);
mi1=vectorvariablesdep(10);
mj1=vectorvariablesdep(11);
mk1=vectorvariablesdep(12);
ml1=vectorvariablesdep(13);
mm1=vectorvariablesdep(14);
%****************Bloque horizontal 1***************************************
alfacm5=acos((roa*(D+s0)-rocm5*s0)/(roa*D));
A5=L*(s0+D*(1-cos(alfacm5)));
V5=U*cos(alfacm5);
Gs5=3600*V5*A5*rocm5;
Hkb1 = (1/NB)*3600*(A5*V5*rocm5)*Z/(3600*U);
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
            else i=j;
                suma = 0;
                for l=1:i-1,
                    suma = suma + A(i,l);
                    A(i,j) = fipHPGR(i) - suma;
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
            suma = suma + A(i,j)*exp(-1*S(j,k)*Z/U);% Distribución granulométrica ec 3.29
            %de producto de la zona de compresión de capas de partículas, para cada bloque k, [ton(i)/ton
            p(i,k) = suma;
        end
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
%******************Parámetros Gs(i)****************************************

%******************Parámetros Gs(i)****************************************
%definicion ecuaciones diferenciales
drocm5dt= (Gs6-Gs5)/volt;
%**************************************************************************
%Balance poblacional
%Bloque 1
dma1dt = Gs6*fipHPGR(1)/NB-Gs5*p(1,1)/NB-ma1*Smd(1,1);
dmb1dt = Gs6*fipHPGR(2)/NB-Gs5*p(2,1)/NB+ma1*b(2,1)*Smd(1,1)-mb1*Smd(2,1);
dmc1dt = Gs6*fipHPGR(3)/NB-Gs5*p(3,1)/NB+ma1*b(3,1)*Smd(1,1)+mb1*b(3,2)*Smd(2,1)-mc1*Smd(3,1);
dmd1dt = Gs6*fipHPGR(4)/NB-Gs5*p(4,1)/NB+ma1*b(4,1)*Smd(1,1)+mb1*b(4,2)*Smd(2,1)+mc1*b(4,3)*Smd(3,1)-md1*Smd(4,1);
dme1dt = Gs6*fipHPGR(5)/NB-Gs5*p(5,1)/NB+ma1*b(5,1)*Smd(1,1)+mb1*b(5,2)*Smd(2,1)+mc1*b(5,3)*Smd(3,1)+md1*b(5,4)*Smd(4,1)-me1*Smd(5,1);
dmf1dt = Gs6*fipHPGR(6)/NB-Gs5*p(6,1)/NB+ma1*b(6,1)*Smd(1,1)+mb1*b(6,2)*Smd(2,1)+mc1*b(6,3)*Smd(3,1)+md1*b(6,4)*Smd(4,1)+me1*b(6,5)*Smd(5,1)-mf1*Smd(6,1);
dmg1dt = Gs6*fipHPGR(7)/NB-Gs5*p(7,1)/NB+ma1*b(7,1)*Smd(1,1)+mb1*b(7,2)*Smd(2,1)+mc1*b(7,3)*Smd(3,1)+md1*b(7,4)*Smd(4,1)+me1*b(7,5)*Smd(5,1)+mf1*b(7,6)*Smd(6,1)-mg1*Smd(7,1);
dmh1dt = Gs6*fipHPGR(8)/NB-Gs5*p(8,1)/NB+ma1*b(8,1)*Smd(1,1)+mb1*b(8,2)*Smd(2,1)+mc1*b(8,3)*Smd(3,1)+md1*b(8,4)*Smd(4,1)+me1*b(8,5)*Smd(5,1)+mf1*b(8,6)*Smd(6,1)+mg1*b(8,7)*Smd(7,1)-mh1*Smd(8,1);
dmi1dt = Gs6*fipHPGR(9)/NB-Gs5*p(9,1)/NB+ma1*b(9,1)*Smd(1,1)+mb1*b(9,2)*Smd(2,1)+mc1*b(9,3)*Smd(3,1)+md1*b(9,4)*Smd(4,1)+me1*b(9,5)*Smd(5,1)+mf1*b(9,6)*Smd(6,1)+mg1*b(9,7)*Smd(7,1)+mh1*b(9,8)*Smd(8,1)-mi1*Smd(9,1);
dmj1dt = Gs6*fipHPGR(10)/NB-Gs5*p(10,1)/NB+ma1*b(10,1)*Smd(1,1)+mb1*b(10,2)*Smd(2,1)+mc1*b(10,3)*Smd(3,1)+md1*b(10,4)*Smd(4,1)+me1*b(10,5)*Smd(5,1)+mf1*b(10,6)*Smd(6,1)+mg1*b(10,7)*Smd(7,1)+mh1*b(10,8)*Smd(8,1)+mi1*b(10,9)*Smd(9,1)-mj1*Smd(10,1);
dmk1dt = Gs6*fipHPGR(11)/NB-Gs5*p(11,1)/NB+ma1*b(11,1)*Smd(1,1)+mb1*b(11,2)*Smd(2,1)+mc1*b(11,3)*Smd(3,1)+md1*b(11,4)*Smd(4,1)+me1*b(11,5)*Smd(5,1)+mf1*b(11,6)*Smd(6,1)+mg1*b(11,7)*Smd(7,1)+mh1*b(11,8)*Smd(8,1)+mi1*b(11,9)*Smd(9,1)+mj1*b(11,10)*Smd(10,1)-mk1*Smd(11,1);
dml1dt = Gs6*fipHPGR(12)/NB-Gs5*p(12,1)/NB+ma1*b(12,1)*Smd(1,1)+mb1*b(12,2)*Smd(2,1)+mc1*b(12,3)*Smd(3,1)+md1*b(12,4)*Smd(4,1)+me1*b(12,5)*Smd(5,1)+mf1*b(12,6)*Smd(6,1)+mg1*b(12,7)*Smd(7,1)+mh1*b(12,8)*Smd(8,1)+mi1*b(12,9)*Smd(9,1)+mj1*b(12,10)*Smd(10,1)+mk1*b(12,11)*Smd(11,1)-ml1*Smd(12,1);
dmm1dt = Gs6*fipHPGR(13)/NB-Gs5*p(13,1)/NB+ma1*b(13,1)*Smd(1,1)+mb1*b(13,2)*Smd(2,1)+mc1*b(13,3)*Smd(3,1)+md1*b(13,4)*Smd(4,1)+me1*b(13,5)*Smd(5,1)+mf1*b(13,6)*Smd(6,1)+mg1*b(13,7)*Smd(7,1)+mh1*b(13,8)*Smd(8,1)+mi1*b(13,9)*Smd(9,1)+mj1*b(13,10)*Smd(10,1)+mk1*b(13,11)*Smd(11,1)+ml1*b(13,12)*Smd(12,1)+0*mm1;

vectorode=[drocm5dt;...
           dma1dt; dmb1dt; dmc1dt; dmd1dt; dme1dt; dmf1dt; dmg1dt; dmh1dt; dmi1dt; dmj1dt; dmk1dt; dml1dt; dmm1dt];
figure(2)
plot(t,Gs5),hold on;
Granulometriasb1 = [fptHPGRu;fpeHPGRu;fpcHPGRu]
%xlswrite('datos.xls',Granulometrias)
end
