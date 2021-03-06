function pruebasisdinbloque5
tiemporango=[0 1];
valoresiniciales=[6.163452e-5;2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6;...
                  2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6; 2.370558462e-6];
%valores iniciales para den; ma, mb, mc, md, me, mf, mg, mh, mi, mj, mk, ml, mm
[t,m]=ode45(@dinamico, tiemporango, valoresiniciales);
figure(1)
plot(t,m);
xlabel('Tiempo')
legend('ma', 'mb', 'mc', 'md', 'me', 'mf', 'mg', 'mh', 'mi', 'mj', 'mk', 'ml', 'mm')
figure(2)
plot(t,m(1),'*'), hold on
grid on
xlabel('Tiempo')
ylabel('Masa total')
legend('Masa total bloque 5')
t
m
end

function [vectorode] =dinamico(t, vectorvariablesdep)

%Llamado de variables
load('roe.mat','roe');
load('s0.mat','s0');
load('D.mat','D');
load('L.mat','L');
load('Ppb.mat','Ppb');
load('b.mat','b');
load('SiE.mat','SiE');
load('fipHPGR.mat','fipHPGR');
load('h.mat','h');
load('U.mat','U');
load('n.mat','n');
load('NB.mat','NB');

%definicion de variables dependientes
masa5=vectorvariablesdep(1);
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
ma2=vectorvariablesdep(15);
mb2=vectorvariablesdep(16);
mc2=vectorvariablesdep(17);
md2=vectorvariablesdep(18);
me2=vectorvariablesdep(19);
mf2=vectorvariablesdep(20);
mg2=vectorvariablesdep(21);
mh2=vectorvariablesdep(22);
mi2=vectorvariablesdep(23);
mj2=vectorvariablesdep(24);
mk2=vectorvariablesdep(25);
ml2=vectorvariablesdep(26);
mm2=vectorvariablesdep(27);
%Ecuaciones algebraicas
Hk1 = (ma1+mb1+mc1+md1+me1+mf1+mg1+mh1+mi1+mj1+mk1+ml1+mm1);
Hk2 = (ma2+mb2+mc2+md2+me2+mf2+mg2+mh2+mi2+mj2+mk2+ml2+mm2);
Hk = [Hk1 Hk2]% Vector hold up de cada bloque k
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S(i,k) = (Ppb(k)/Hk(k))*SiE(i)/3600; %S(i,k) en [1/s]
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
%Distribuci�n del tama�o de part�cula en zona BP,
%Granulometria por bloques 
for k = 1:NB;
    for i = 1:n-1;
        suma = 0;
        for j = 1:i;
            suma = suma + A(i,j)*exp(-1*S(j,k)*h/U);% Distribuci�n granulom�trica ec 3.29
            %de producto de la zona de compresi�n de capas de part�culas, para cada bloque k, [ton(i)/ton
            p(i,k) = suma;
        end
        suma;
    end
    for i = n;
        p(i,k) = 1 - sum(p(1:n-1,k));
    end
end
%Distribucion de tama�o de part�cula total HPGR: f(i)ptHPGR en [ton(i)/tonT]
for i = 1:n;
    suma = 0;
    for k = 1:NB;
        suma = suma + p(i,k); %Sumatoria de las fracciones m�sicas divididas para el NB
        fptHPGR(i) = suma/NB; %GRANULOMETRIA DE PRODUCTO TOTAL DEL HPGR
    end
end
%Distribuci�n de tama�o de part�cula bordes del HPGR: f(i)peHPGR en
%[ton(i)/tonT]
a = 0.24; %Par�metro fracci�n en peso que circula en los bordes
E = 0.5*a*NB; %N� de bloques, E, correspondiente a los bordes
for i=1:n;
    suma = 0;
    for k = 1:round(E);
        suma = suma + p(i,k);
    end
    suma;
    fpeHPGR(i) = (suma + (E - round(E))*p(i,round(E)+1))/E;
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR EFECTO DE BORDE
end
%Distribuci�n de tama�o de part�cula centro del HPGR: f(i)pcHPGR en
%[ton(i)/tonT]
for i = 1:n;
    fpcHPGR(i) = (fptHPGR(i) - a*fpeHPGR(i))/(1-a);
    %GRANULOMETRIA DE PRODUCTO CHANCADO POR COMPRESION DE CAPAS DE
    %PARTICULAS
end
%Distribuci�n de tama�o de productos en forma acumulada pasante
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
% Calculo del flujo por cada bloque
syms x
Gs6 = 32.9;%3600*roe*s0*L*U;
a = 0;
bb = h;
c = 2*h;
d = 3*h;
e = 4*h;
f = 5*h;
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
%Area por bloque
area1 = double(int(in2,'x',a,bb));
area2= double(int(in2,'x',bb,c));
area3 = double(int(in2,'x',c,d));
area4= double(int(in2,'x',d,e));
area5 = double(int(in2,'x',e,f));
%Volumen por bloque
vol1 = L*area1;
vol2 = L*area2;
vol3 = L*area3;
vol4 = L*area4;
vol5 = L*area5;
%Densidad en funcion de de la masa y el volumen del bloque
ro = masa5/vol5;
in1 = ((ro*s0)/(2*(D/2-sqrt((D/2)^2-x^2))+s0))*(D/2+s0/2-sqrt((D/2)^2-x^2));
denume1 = double(int(in1,'x',a,bb));
dendeno1 = double(int(in2,'x',a,bb));
denume2 = double(int(in1,'x',bb,c));
dendeno2 = double(int(in2,'x',bb,c));
denume3 = double(int(in1,'x',c,d));
dendeno3 = double(int(in2,'x',c,d));
denume4 = double(int(in1,'x',d,e));
dendeno4 = double(int(in2,'x',d,e));
denume5 = double(int(in1,'x',e,f));
dendeno5 = double(int(in2,'x',e,f));
den1 = (denume1/dendeno1);
den2 = (denume2/dendeno2);
den3 = (denume3/dendeno3);
den4 = (denume4/dendeno4);
den5 = (denume5/dendeno5);
%Angulo del centro de masa de cada bloque
%alfa1= (acos((den1*(s0+D)-roe*s0)/(den1*D)))*180/pi;
%alfa2= (acos((den2*(s0+D)-roe*s0)/(den2*D)))*180/pi;
%alfa3= (acos((den3*(s0+D)-roe*s0)/(den3*D)))*180/pi;
%alfa4= (acos((den4*(s0+D)-roe*s0)/(den4*D)))*180/pi;
alfa5= (acos((den5*(s0+D)-roe*s0)/(den5*D)))*180/pi;
%Posicion del centro de masa
%cen1 = (D/2)*sin(alfa1*pi/180);
%cen2 = (D/2)*sin(alfa2*pi/180);
%cen3 = (D/2)*sin(alfa3*pi/180);
%cen4 = (D/2)*sin(alfa4*pi/180);
%cen5 = (D/2)*sin(alfa5*pi/180);
%**********Parametros para calcular el flujo
%v1 = U*cos(alfa1*pi/180);
%v2 = U*cos(alfa2*pi/180);
%v3 = U*cos(alfa3*pi/180);
%v4 = U*cos(alfa4*pi/180);
v5 = U*cos(alfa5*pi/180);
%s1 = s0+D*(1-cos(alfa1*pi/180));
%s2 = s0+D*(1-cos(alfa2*pi/180));
%s3 = s0+D*(1-cos(alfa3*pi/180));
%s4 = s0+D*(1-cos(alfa4*pi/180));
s5 = s0+D*(1-cos(alfa5*pi/180));
%A1 = L*s1;
%A2 = L*s2;
%A3 = L*s3;
%A4 = L*s4;
A5 = L*s5;
%Gs1 = 3600*den1*A1*v1;
%Gs2 = 3600*den2*A2*v2;
%Gs3 = 3600*den3*A3*v3;
%Gs4 = 3600*den4*A4*v4;
Gs5 = 3600*den5*A5*v5;
Smd = S*3600; %Conversi�n de la cin�tica de molieda a [1/h]
%definicion ecuaciones diferenciales
dmasa5dt = Gs6-Gs5;

dma1dt = Gs6*fipHPGR(1)/NB-Gs5*p(1,1)/NB-ma1*sum(b(2:13,1).*Smd(1,1));
dmb1dt = Gs6*fipHPGR(2)/NB-Gs5*p(2,1)/NB+ma1*b(2,1)*Smd(1,1)-mb1*sum(b(3:13,2).*Smd(2,1));
dmc1dt = Gs6*fipHPGR(3)/NB-Gs5*p(3,1)/NB+ma1*b(3,1)*Smd(1,1)+mb1*b(3,2)*Smd(2,1)-mc1*sum(b(4:13,3).*Smd(3,1));
dmd1dt = Gs6*fipHPGR(4)/NB-Gs5*p(4,1)/NB+ma1*b(4,1)*Smd(1,1)+mb1*b(4,2)*Smd(2,1)+mc1*b(4,3)*Smd(3,1)-md1*sum(b(5:13,4).*Smd(4,1));
dme1dt = Gs6*fipHPGR(5)/NB-Gs5*p(5,1)/NB+ma1*b(5,1)*Smd(1,1)+mb1*b(5,2)*Smd(2,1)+mc1*b(5,3)*Smd(3,1)+md1*b(5,4)*Smd(4,1)-me1*sum(b(6:13,5).*Smd(5,1));
dmf1dt = Gs6*fipHPGR(6)/NB-Gs5*p(6,1)/NB+ma1*b(6,1)*Smd(1,1)+mb1*b(6,2)*Smd(2,1)+mc1*b(6,3)*Smd(3,1)+md1*b(6,4)*Smd(4,1)+me1*b(6,5)*Smd(5,1)-mf1*sum(b(7:13,6).*Smd(6,1));
dmg1dt = Gs6*fipHPGR(7)/NB-Gs5*p(7,1)/NB+ma1*b(7,1)*Smd(1,1)+mb1*b(7,2)*Smd(2,1)+mc1*b(7,3)*Smd(3,1)+md1*b(7,4)*Smd(4,1)+me1*b(7,5)*Smd(5,1)+mf1*b(7,6)*Smd(6,1)-mg1*sum(b(8:13,7).*Smd(7,1));
dmh1dt = Gs6*fipHPGR(8)/NB-Gs5*p(8,1)/NB+ma1*b(8,1)*Smd(1,1)+mb1*b(8,2)*Smd(2,1)+mc1*b(8,3)*Smd(3,1)+md1*b(8,4)*Smd(4,1)+me1*b(8,5)*Smd(5,1)+mf1*b(8,6)*Smd(6,1)+mg1*b(8,7)*Smd(7,1)-mh1*sum(b(9:13,8).*Smd(8,1));
dmi1dt = Gs6*fipHPGR(9)/NB-Gs5*p(9,1)/NB+ma1*b(9,1)*Smd(1,1)+mb1*b(9,2)*Smd(2,1)+mc1*b(9,3)*Smd(3,1)+md1*b(9,4)*Smd(4,1)+me1*b(9,5)*Smd(5,1)+mf1*b(9,6)*Smd(6,1)+mg1*b(9,7)*Smd(7,1)+mh1*b(9,8)*Smd(8,1)-mi1*sum(b(10:13,9).*Smd(9,1));
dmj1dt = Gs6*fipHPGR(10)/NB-Gs5*p(10,1)/NB+ma1*b(10,1)*Smd(1,1)+mb1*b(10,2)*Smd(2,1)+mc1*b(10,3)*Smd(3,1)+md1*b(10,4)*Smd(4,1)+me1*b(10,5)*Smd(5,1)+mf1*b(10,6)*Smd(6,1)+mg1*b(10,7)*Smd(7,1)+mh1*b(10,8)*Smd(8,1)+mi1*b(10,9)*Smd(9,1)-mj1*sum(b(11:13,10).*Smd(10,1));
dmk1dt = Gs6*fipHPGR(11)/NB-Gs5*p(11,1)/NB+ma1*b(11,1)*Smd(1,1)+mb1*b(11,2)*Smd(2,1)+mc1*b(11,3)*Smd(3,1)+md1*b(11,4)*Smd(4,1)+me1*b(11,5)*Smd(5,1)+mf1*b(11,6)*Smd(6,1)+mg1*b(11,7)*Smd(7,1)+mh1*b(11,8)*Smd(8,1)+mi1*b(11,9)*Smd(9,1)+mj1*b(11,10)*Smd(10,1)-mk1*sum(b(12:13,11).*Smd(11,1));
dml1dt = Gs6*fipHPGR(12)/NB-Gs5*p(12,1)/NB+ma1*b(12,1)*Smd(1,1)+mb1*b(12,2)*Smd(2,1)+mc1*b(12,3)*Smd(3,1)+md1*b(12,4)*Smd(4,1)+me1*b(12,5)*Smd(5,1)+mf1*b(12,6)*Smd(6,1)+mg1*b(12,7)*Smd(7,1)+mh1*b(12,8)*Smd(8,1)+mi1*b(12,9)*Smd(9,1)+mj1*b(12,10)*Smd(10,1)+mk1*b(12,11)*Smd(11,1)-ml1*sum(b(13,12)*Smd(12,1));
dmm1dt = Gs6*fipHPGR(13)/NB-Gs5*p(13,1)/NB+ma1*b(13,1)*Smd(1,1)+mb1*b(13,2)*Smd(2,1)+mc1*b(13,3)*Smd(3,1)+md1*b(13,4)*Smd(4,1)+me1*b(13,5)*Smd(5,1)+mf1*b(13,6)*Smd(6,1)+mg1*b(13,7)*Smd(7,1)+mh1*b(13,8)*Smd(8,1)+mi1*b(13,9)*Smd(9,1)+mj1*b(13,10)*Smd(10,1)+mk1*b(13,11)*Smd(11,1)+ml1*b(13,12)*Smd(12,1)+0*mm1;

dma2dt = Gs6*fipHPGR(1)/NB-Gs5*p(1,2)/NB-ma2*sum(b(2:13,1).*Smd(1,2));
dmb2dt = Gs6*fipHPGR(2)/NB-Gs5*p(2,2)/NB+ma2*b(2,1)*Smd(1,2)-mb2*sum(b(3:13,2).*Smd(2,2));
dmc2dt = Gs6*fipHPGR(3)/NB-Gs5*p(3,2)/NB+ma2*b(3,1)*Smd(1,2)+mb2*b(3,2)*Smd(2,2)-mc2*sum(b(4:13,3).*Smd(3,2));
dmd2dt = Gs6*fipHPGR(4)/NB-Gs5*p(4,2)/NB+ma2*b(4,1)*Smd(1,2)+mb2*b(4,2)*Smd(2,2)+mc2*b(4,3)*Smd(3,2)-md2*sum(b(5:13,4).*Smd(4,2));
dme2dt = Gs6*fipHPGR(5)/NB-Gs5*p(5,2)/NB+ma2*b(5,1)*Smd(1,2)+mb2*b(5,2)*Smd(2,2)+mc2*b(5,3)*Smd(3,2)+md2*b(5,4)*Smd(4,2)-me2*sum(b(6:13,5).*Smd(5,2));
dmf2dt = Gs6*fipHPGR(6)/NB-Gs5*p(6,2)/NB+ma2*b(6,1)*Smd(1,2)+mb2*b(6,2)*Smd(2,2)+mc2*b(6,3)*Smd(3,2)+md2*b(6,4)*Smd(4,2)+me2*b(6,5)*Smd(5,2)-mf2*sum(b(7:13,6).*Smd(6,2));
dmg2dt = Gs6*fipHPGR(7)/NB-Gs5*p(7,2)/NB+ma2*b(7,1)*Smd(1,2)+mb2*b(7,2)*Smd(2,2)+mc2*b(7,3)*Smd(3,2)+md2*b(7,4)*Smd(4,2)+me2*b(7,5)*Smd(5,2)+mf2*b(7,6)*Smd(6,2)-mg2*sum(b(8:13,7).*Smd(7,2));
dmh2dt = Gs6*fipHPGR(8)/NB-Gs5*p(8,2)/NB+ma2*b(8,1)*Smd(1,2)+mb2*b(8,2)*Smd(2,2)+mc2*b(8,3)*Smd(3,2)+md2*b(8,4)*Smd(4,2)+me2*b(8,5)*Smd(5,2)+mf2*b(8,6)*Smd(6,2)+mg2*b(8,7)*Smd(7,2)-mh2*sum(b(9:13,8).*Smd(8,2));
dmi2dt = Gs6*fipHPGR(9)/NB-Gs5*p(9,2)/NB+ma2*b(9,1)*Smd(1,2)+mb2*b(9,2)*Smd(2,2)+mc2*b(9,3)*Smd(3,2)+md2*b(9,4)*Smd(4,2)+me2*b(9,5)*Smd(5,2)+mf2*b(9,6)*Smd(6,2)+mg2*b(9,7)*Smd(7,2)+mh2*b(9,8)*Smd(8,2)-mi2*sum(b(10:13,9).*Smd(9,2));
dmj2dt = Gs6*fipHPGR(10)/NB-Gs5*p(10,2)/NB+ma2*b(10,1)*Smd(1,2)+mb2*b(10,2)*Smd(2,2)+mc2*b(10,3)*Smd(3,2)+md2*b(10,4)*Smd(4,2)+me2*b(10,5)*Smd(5,2)+mf2*b(10,6)*Smd(6,2)+mg2*b(10,7)*Smd(7,2)+mh2*b(10,8)*Smd(8,2)+mi2*b(10,9)*Smd(9,2)-mj2*sum(b(11:13,10).*Smd(10,2));
dmk2dt = Gs6*fipHPGR(11)/NB-Gs5*p(11,2)/NB+ma2*b(11,1)*Smd(1,2)+mb2*b(11,2)*Smd(2,2)+mc2*b(11,3)*Smd(3,2)+md2*b(11,4)*Smd(4,2)+me2*b(11,5)*Smd(5,2)+mf2*b(11,6)*Smd(6,2)+mg2*b(11,7)*Smd(7,2)+mh2*b(11,8)*Smd(8,2)+mi2*b(11,9)*Smd(9,2)+mj2*b(11,10)*Smd(10,2)-mk2*sum(b(12:13,11).*Smd(11,2));
dml2dt = Gs6*fipHPGR(12)/NB-Gs5*p(12,2)/NB+ma2*b(12,1)*Smd(1,2)+mb2*b(12,2)*Smd(2,2)+mc2*b(12,3)*Smd(3,2)+md2*b(12,4)*Smd(4,2)+me2*b(12,5)*Smd(5,2)+mf2*b(12,6)*Smd(6,2)+mg2*b(12,7)*Smd(7,2)+mh2*b(12,8)*Smd(8,2)+mi2*b(12,9)*Smd(9,2)+mj2*b(12,10)*Smd(10,2)+mk2*b(12,11)*Smd(11,2)-ml2*sum(b(13,12)*Smd(12,2));
dmm2dt = Gs6*fipHPGR(13)/NB-Gs5*p(13,2)/NB+ma2*b(13,1)*Smd(1,2)+mb2*b(13,2)*Smd(2,2)+mc2*b(13,3)*Smd(3,2)+md2*b(13,4)*Smd(4,2)+me2*b(13,5)*Smd(5,2)+mf2*b(13,6)*Smd(6,2)+mg2*b(13,7)*Smd(7,2)+mh2*b(13,8)*Smd(8,2)+mi2*b(13,9)*Smd(9,2)+mj2*b(13,10)*Smd(10,2)+mk2*b(13,11)*Smd(11,2)+ml2*b(13,12)*Smd(12,2)+0*mm2;


vectorode=[dmasa5dt; dma1dt; dmb1dt; dmc1dt; dmd1dt; dme1dt; dmf1dt; dmg1dt; dmh1dt; dmi1dt; dmj1dt; dmk1dt; dml1dt; dmm1dt;...
           dma2dt; dmb2dt; dmc2dt; dmd2dt; dme2dt; dmf2dt; dmg2dt; dmh2dt; dmi2dt; dmj2dt; dmk2dt; dml2dt; dmm2dt];
Xtc = [45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
    drawnow
    figure(3)
    plot(t,Hk1,t,Hk2,t,Hk,'o'),hold on
    legend('Hk1','Hk1','Hk2') 
    grid on
    xlabel('Tiempo [s]')
    ylabel('Hold up [ton]')
    figure(4)
    plot(t,Gs5,'s'),hold on
    grid on
    xlabel('Tiempo [s]')
    ylabel('Gs5]')
    figure(5)
    semilogx(Xtc,fptHPGRu,'-s')
    grid on
    title('Granulometr�a bloque 5')
    xlabel('Tama�o de clases [mm]')
    ylabel('[%] Acumulado Pasante')
    %p5=p;
    %f5 = fptHPGR; 
    %save('p5.mat','p5');
    %save('f5.mat','f5');
    %save('den4.mat','den4');
    %save('den3.mat','den3');
    %save('den2.mat','den2');
    %save('den1.mat','den1');
    %save('vol4.mat','vol4');
    %save('vol3.mat','vol3');
    %save('vol2.mat','vol2'); 
    %save('vol1.mat','vol1');
end