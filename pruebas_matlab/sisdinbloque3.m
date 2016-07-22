function sisdinbloque3
tiemporango=[0 25];
valoresiniciales=[0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20;...
    0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20;...
    0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20;...
    0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20;...
    0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20; 0.20]; 
%valores iniciales para ma, mb, mc, md, me, mf, mg, mh, mi, mj, mk, ml, mm
[t,m]=ode45(@dinamico, tiemporango, valoresiniciales);
figure(1)
plot(t,m);
t
m
xlabel('Tiempo')
legend('ma', 'mb', 'mc', 'md', 'me', 'mf', 'mg', 'mh', 'mi', 'mj', 'mk', 'ml', 'mm')
end

function [vectorode] =dinamico(t, vectorvariablesdep)
load('p4.mat','p4');
load('b.mat','b');
load('h.mat','h');
load('U.mat','U');
load('NB.mat','NB');
load('n.mat','n');
load('Ppb.mat','Ppb');
load('SiE.mat','SiE');
load('f4.mat','f4');
load('Gs4.mat','Gs4');
load('Gs3.mat','Gs3');
%definicion de variables dependientes
ma1=vectorvariablesdep(1);
mb1=vectorvariablesdep(2);
mc1=vectorvariablesdep(3);
md1=vectorvariablesdep(4);
me1=vectorvariablesdep(5);
mf1=vectorvariablesdep(6);
mg1=vectorvariablesdep(7);
mh1=vectorvariablesdep(8);
mi1=vectorvariablesdep(9);
mj1=vectorvariablesdep(10);
mk1=vectorvariablesdep(11);
ml1=vectorvariablesdep(12);
mm1=vectorvariablesdep(13);
ma2=vectorvariablesdep(14);
mb2=vectorvariablesdep(15);
mc2=vectorvariablesdep(16);
md2=vectorvariablesdep(17);
me2=vectorvariablesdep(18);
mf2=vectorvariablesdep(19);
mg2=vectorvariablesdep(20);
mh2=vectorvariablesdep(21);
mi2=vectorvariablesdep(22);
mj2=vectorvariablesdep(23);
mk2=vectorvariablesdep(24);
ml2=vectorvariablesdep(25);
mm2=vectorvariablesdep(26);
ma3=vectorvariablesdep(27);
mb3=vectorvariablesdep(28);
mc3=vectorvariablesdep(29);
md3=vectorvariablesdep(30);
me3=vectorvariablesdep(31);
mf3=vectorvariablesdep(32);
mg3=vectorvariablesdep(33);
mh3=vectorvariablesdep(34);
mi3=vectorvariablesdep(35);
mj3=vectorvariablesdep(36);
mk3=vectorvariablesdep(37);
ml3=vectorvariablesdep(38);
mm3=vectorvariablesdep(39);
ma4=vectorvariablesdep(40);
mb4=vectorvariablesdep(41);
mc4=vectorvariablesdep(42);
md4=vectorvariablesdep(43);
me4=vectorvariablesdep(44);
mf4=vectorvariablesdep(45);
mg4=vectorvariablesdep(46);
mh4=vectorvariablesdep(47);
mi4=vectorvariablesdep(48);
mj4=vectorvariablesdep(49);
mk4=vectorvariablesdep(50);
ml4=vectorvariablesdep(51);
mm4=vectorvariablesdep(52);
ma5=vectorvariablesdep(53);
mb5=vectorvariablesdep(54);
mc5=vectorvariablesdep(55);
md5=vectorvariablesdep(56);
me5=vectorvariablesdep(57);
mf5=vectorvariablesdep(58);
mg5=vectorvariablesdep(59);
mh5=vectorvariablesdep(60);
mi5=vectorvariablesdep(61);
mj5=vectorvariablesdep(62);
mk5=vectorvariablesdep(63);
ml5=vectorvariablesdep(64);
mm5=vectorvariablesdep(65);
%Ecuaciones algebraicas
%Chancado
ma = ma1+ma2+ma3+ma4+ma5;
mb = mb1+mb2+mb3+mb4+mb5;
mc = mc1+mc2+mc3+mc4+mc5;
md = md1+md2+md3+md4+md5;
me = me1+me2+me3+me4+me5;
mf = mf1+mf2+mf3+mf4+mf5;
mg = mg1+mg2+mg3+mg4+mg5;
mh = mh1+mh2+mh3+mh4+mh5;
mi = mi1+mi2+mi3+mi4+mi5;
mj = mj1+mj2+mj3+mj4+mj5;
mk = mk1+mk2+mk3+mk4+mk5;
ml = ml1+ml2+ml3+ml4+ml5;
mm = mm1+mm2+mm3+mm4+mm5;
Hk = ma+mb+mc+md+me+mf+mg+mh+mi+mj+mk+ml+mm; %Hk en [ton]
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n;
    for k = 1:NB;
        S(i,k) = (Ppb(k)/Hk)*SiE(i)/3600; %S(i,k) en [1/s]
    end
end
%Variables de entrada para modelar la Matriz de REID:
%Valores de partida
A(1,1) = f4(1);
%MATRIZ DE REID CONDICIONES
for i=1:n;
    for j=1:n;
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
                    A(i,j) = f4(i) - suma;
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

Smd = S*3600;
%definicion ecuaciones diferenciales
dma1dt = Gs4*p4(1,1)-Gs3*p(1,1)-ma1*sum(b(2:13,1).*Smd(2:13,1));
dmb1dt = Gs4*p4(2,1)-Gs3*p(2,1)+ma1*b(2,1)*Smd(1,1)-mb1*sum(b(3:13,2).*Smd(3:13,1));
dmc1dt = Gs4*p4(3,1)-Gs3*p(3,1)+ma1*b(3,1)*Smd(1,1)+mb1*b(3,2)*Smd(2,1)-mc1*sum(b(4:13,3).*Smd(4:13,1));
dmd1dt = Gs4*p4(4,1)-Gs3*p(4,1)+ma1*b(4,1)*Smd(1,1)+mb1*b(4,2)*Smd(2,1)+mc1*b(4,3)*Smd(3,1)-md1*sum(b(5:13,4).*Smd(5:13,1));
dme1dt = Gs4*p4(5,1)-Gs3*p(5,1)+ma1*b(5,1)*Smd(1,1)+mb1*b(5,2)*Smd(2,1)+mc1*b(5,3)*Smd(3,1)+md1*b(5,4)*Smd(4,1)-me1*sum(b(6:13,5).*Smd(6:13,1));
dmf1dt = Gs4*p4(6,1)-Gs3*p(6,1)+ma1*b(6,1)*Smd(1,1)+mb1*b(6,2)*Smd(2,1)+mc1*b(6,3)*Smd(3,1)+md1*b(6,4)*Smd(4,1)+me1*b(6,5)*Smd(5,1)-mf1*sum(b(7:13,6).*Smd(7:13,1));
dmg1dt = Gs4*p4(7,1)-Gs3*p(7,1)+ma1*b(7,1)*Smd(1,1)+mb1*b(7,2)*Smd(2,1)+mc1*b(7,3)*Smd(3,1)+md1*b(7,4)*Smd(4,1)+me1*b(7,5)*Smd(5,1)+mf1*b(7,6)*Smd(6,1)-mg1*sum(b(8:13,7).*Smd(8:13,1));
dmh1dt = Gs4*p4(8,1)-Gs3*p(8,1)+ma1*b(8,1)*Smd(1,1)+mb1*b(8,2)*Smd(2,1)+mc1*b(8,3)*Smd(3,1)+md1*b(8,4)*Smd(4,1)+me1*b(8,5)*Smd(5,1)+mf1*b(8,6)*Smd(6,1)+mg1*b(8,7)*Smd(7,1)-mh1*sum(b(9:13,8).*Smd(9:13,1));
dmi1dt = Gs4*p4(9,1)-Gs3*p(9,1)+ma1*b(9,1)*Smd(1,1)+mb1*b(9,2)*Smd(2,1)+mc1*b(9,3)*Smd(3,1)+md1*b(9,4)*Smd(4,1)+me1*b(9,5)*Smd(5,1)+mf1*b(9,6)*Smd(6,1)+mg1*b(9,7)*Smd(7,1)+mh1*b(9,8)*Smd(8,1)-mi1*sum(b(10:13,9).*Smd(10:13,1));
dmj1dt = Gs4*p4(10,1)-Gs3*p(10,1)+ma1*b(10,1)*Smd(1,1)+mb1*b(10,2)*Smd(2,1)+mc1*b(10,3)*Smd(3,1)+md1*b(10,4)*Smd(4,1)+me1*b(10,5)*Smd(5,1)+mf1*b(10,6)*Smd(6,1)+mg1*b(10,7)*Smd(7,1)+mh1*b(10,8)*Smd(8,1)+mi1*b(10,9)*Smd(9,1)-mj1*sum(b(11:13,10).*Smd(11:13,1));
dmk1dt = Gs4*p4(11,1)-Gs3*p(11,1)+ma1*b(11,1)*Smd(1,1)+mb1*b(11,2)*Smd(2,1)+mc1*b(11,3)*Smd(3,1)+md1*b(11,4)*Smd(4,1)+me1*b(11,5)*Smd(5,1)+mf1*b(11,6)*Smd(6,1)+mg1*b(11,7)*Smd(7,1)+mh1*b(11,8)*Smd(8,1)+mi1*b(11,9)*Smd(9,1)+mj1*b(11,10)*Smd(10,1)-mk1*sum(b(12:13,11).*Smd(12:13,1));
dml1dt = Gs4*p4(12,1)-Gs3*p(12,1)+ma1*b(12,1)*Smd(1,1)+mb1*b(12,2)*Smd(2,1)+mc1*b(12,3)*Smd(3,1)+md1*b(12,4)*Smd(4,1)+me1*b(12,5)*Smd(5,1)+mf1*b(12,6)*Smd(6,1)+mg1*b(12,7)*Smd(7,1)+mh1*b(12,8)*Smd(8,1)+mi1*b(12,9)*Smd(9,1)+mj1*b(12,10)*Smd(10,1)+mk1*b(12,11)*Smd(11,1)-ml1*sum(b(13,12)*Smd(13,1));
dmm1dt = Gs4*p4(13,1)-Gs3*p(13,1)+ma1*b(13,1)*Smd(1,1)+mb1*b(13,2)*Smd(2,1)+mc1*b(13,3)*Smd(3,1)+md1*b(13,4)*Smd(4,1)+me1*b(13,5)*Smd(5,1)+mf1*b(13,6)*Smd(6,1)+mg1*b(13,7)*Smd(7,1)+mh1*b(13,8)*Smd(8,1)+mi1*b(13,9)*Smd(9,1)+mj1*b(13,10)*Smd(10,1)+mk1*b(13,11)*Smd(11,1)+ml1*b(13,12)*Smd(12,1)+0*mm1;

dma2dt = Gs4*p4(1,2)-Gs3*p(1,2)-ma2*sum(b(2:13,1).*Smd(2:13,2));
dmb2dt = Gs4*p4(2,2)-Gs3*p(2,2)+ma2*b(2,1)*Smd(1,2)-mb2*sum(b(3:13,2).*Smd(3:13,2));
dmc2dt = Gs4*p4(3,2)-Gs3*p(3,2)+ma2*b(3,1)*Smd(1,2)+mb2*b(3,2)*Smd(2,2)-mc2*sum(b(4:13,3).*Smd(4:13,2));
dmd2dt = Gs4*p4(4,2)-Gs3*p(4,2)+ma2*b(4,1)*Smd(1,2)+mb2*b(4,2)*Smd(2,2)+mc2*b(4,3)*Smd(3,2)-md2*sum(b(5:13,4).*Smd(5:13,2));
dme2dt = Gs4*p4(5,2)-Gs3*p(5,2)+ma2*b(5,1)*Smd(1,2)+mb2*b(5,2)*Smd(2,2)+mc2*b(5,3)*Smd(3,2)+md2*b(5,4)*Smd(4,2)-me2*sum(b(6:13,5).*Smd(6:13,2));
dmf2dt = Gs4*p4(6,2)-Gs3*p(6,2)+ma2*b(6,1)*Smd(1,2)+mb2*b(6,2)*Smd(2,2)+mc2*b(6,3)*Smd(3,2)+md2*b(6,4)*Smd(4,2)+me2*b(6,5)*Smd(5,2)-mf2*sum(b(7:13,6).*Smd(7:13,2));
dmg2dt = Gs4*p4(7,2)-Gs3*p(7,2)+ma2*b(7,1)*Smd(1,2)+mb2*b(7,2)*Smd(2,2)+mc2*b(7,3)*Smd(3,2)+md2*b(7,4)*Smd(4,2)+me2*b(7,5)*Smd(5,2)+mf2*b(7,6)*Smd(6,2)-mg2*sum(b(8:13,7).*Smd(8:13,2));
dmh2dt = Gs4*p4(8,2)-Gs3*p(8,2)+ma2*b(8,1)*Smd(1,2)+mb2*b(8,2)*Smd(2,2)+mc2*b(8,3)*Smd(3,2)+md2*b(8,4)*Smd(4,2)+me2*b(8,5)*Smd(5,2)+mf2*b(8,6)*Smd(6,2)+mg2*b(8,7)*Smd(7,2)-mh2*sum(b(9:13,8).*Smd(9:13,2));
dmi2dt = Gs4*p4(9,2)-Gs3*p(9,2)+ma2*b(9,1)*Smd(1,2)+mb2*b(9,2)*Smd(2,2)+mc2*b(9,3)*Smd(3,2)+md2*b(9,4)*Smd(4,2)+me2*b(9,5)*Smd(5,2)+mf2*b(9,6)*Smd(6,2)+mg2*b(9,7)*Smd(7,2)+mh2*b(9,8)*Smd(8,2)-mi2*sum(b(10:13,9).*Smd(10:13,2));
dmj2dt = Gs4*p4(10,2)-Gs3*p(10,2)+ma2*b(10,1)*Smd(1,2)+mb2*b(10,2)*Smd(2,2)+mc2*b(10,3)*Smd(3,2)+md2*b(10,4)*Smd(4,2)+me2*b(10,5)*Smd(5,2)+mf2*b(10,6)*Smd(6,2)+mg2*b(10,7)*Smd(7,2)+mh2*b(10,8)*Smd(8,2)+mi2*b(10,9)*Smd(9,2)-mj2*sum(b(11:13,10).*Smd(11:13,2));
dmk2dt = Gs4*p4(11,2)-Gs3*p(11,2)+ma2*b(11,1)*Smd(1,2)+mb2*b(11,2)*Smd(2,2)+mc2*b(11,3)*Smd(3,2)+md2*b(11,4)*Smd(4,2)+me2*b(11,5)*Smd(5,2)+mf2*b(11,6)*Smd(6,2)+mg2*b(11,7)*Smd(7,2)+mh2*b(11,8)*Smd(8,2)+mi2*b(11,9)*Smd(9,2)+mj2*b(11,10)*Smd(10,2)-mk2*sum(b(12:13,11).*Smd(12:13,2));
dml2dt = Gs4*p4(12,2)-Gs3*p(12,2)+ma2*b(12,1)*Smd(1,2)+mb2*b(12,2)*Smd(2,2)+mc2*b(12,3)*Smd(3,2)+md2*b(12,4)*Smd(4,2)+me2*b(12,5)*Smd(5,2)+mf2*b(12,6)*Smd(6,2)+mg2*b(12,7)*Smd(7,2)+mh2*b(12,8)*Smd(8,2)+mi2*b(12,9)*Smd(9,2)+mj2*b(12,10)*Smd(10,2)+mk2*b(12,11)*Smd(11,2)-ml2*sum(b(13,12)*Smd(13,2));
dmm2dt = Gs4*p4(13,2)-Gs3*p(13,2)+ma2*b(13,1)*Smd(1,2)+mb2*b(13,2)*Smd(2,2)+mc2*b(13,3)*Smd(3,2)+md2*b(13,4)*Smd(4,2)+me2*b(13,5)*Smd(5,2)+mf2*b(13,6)*Smd(6,2)+mg2*b(13,7)*Smd(7,2)+mh2*b(13,8)*Smd(8,2)+mi2*b(13,9)*Smd(9,2)+mj2*b(13,10)*Smd(10,2)+mk2*b(13,11)*Smd(11,2)+ml2*b(13,12)*Smd(12,2)+0*mm2;

dma3dt = Gs4*p4(1,3)-Gs3*p(1,3)-ma3*sum(b(2:13,1).*Smd(2:13,3));
dmb3dt = Gs4*p4(2,3)-Gs3*p(2,3)+ma3*b(2,1)*Smd(1,3)-mb3*sum(b(3:13,2).*Smd(3:13,3));
dmc3dt = Gs4*p4(3,3)-Gs3*p(3,3)+ma3*b(3,1)*Smd(1,3)+mb3*b(3,3)*Smd(2,3)-mc3*sum(b(4:13,3).*Smd(4:13,3));
dmd3dt = Gs4*p4(4,3)-Gs3*p(4,3)+ma3*b(4,1)*Smd(1,3)+mb3*b(4,3)*Smd(2,3)+mc3*b(4,3)*Smd(3,3)-md3*sum(b(5:13,4).*Smd(5:13,3));
dme3dt = Gs4*p4(5,3)-Gs3*p(5,3)+ma3*b(5,1)*Smd(1,3)+mb3*b(5,3)*Smd(2,3)+mc3*b(5,3)*Smd(3,3)+md3*b(5,4)*Smd(4,3)-me3*sum(b(6:13,5).*Smd(6:13,3));
dmf3dt = Gs4*p4(6,3)-Gs3*p(6,3)+ma3*b(6,1)*Smd(1,3)+mb3*b(6,3)*Smd(2,3)+mc3*b(6,3)*Smd(3,3)+md3*b(6,4)*Smd(4,3)+me3*b(6,5)*Smd(5,3)-mf3*sum(b(7:13,6).*Smd(7:13,3));
dmg3dt = Gs4*p4(7,3)-Gs3*p(7,3)+ma3*b(7,1)*Smd(1,3)+mb3*b(7,3)*Smd(2,3)+mc3*b(7,3)*Smd(3,3)+md3*b(7,4)*Smd(4,3)+me3*b(7,5)*Smd(5,3)+mf3*b(7,6)*Smd(6,3)-mg3*sum(b(8:13,7).*Smd(8:13,3));
dmh3dt = Gs4*p4(8,3)-Gs3*p(8,3)+ma3*b(8,1)*Smd(1,3)+mb3*b(8,3)*Smd(2,3)+mc3*b(8,3)*Smd(3,3)+md3*b(8,4)*Smd(4,3)+me3*b(8,5)*Smd(5,3)+mf3*b(8,6)*Smd(6,3)+mg3*b(8,7)*Smd(7,3)-mh3*sum(b(9:13,8).*Smd(9:13,3));
dmi3dt = Gs4*p4(9,3)-Gs3*p(9,3)+ma3*b(9,1)*Smd(1,3)+mb3*b(9,3)*Smd(2,3)+mc3*b(9,3)*Smd(3,3)+md3*b(9,4)*Smd(4,3)+me3*b(9,5)*Smd(5,3)+mf3*b(9,6)*Smd(6,3)+mg3*b(9,7)*Smd(7,3)+mh3*b(9,8)*Smd(8,3)-mi3*sum(b(10:13,9).*Smd(10:13,3));
dmj3dt = Gs4*p4(10,3)-Gs3*p(10,3)+ma3*b(10,1)*Smd(1,3)+mb3*b(10,3)*Smd(2,3)+mc3*b(10,3)*Smd(3,3)+md3*b(10,4)*Smd(4,3)+me3*b(10,5)*Smd(5,3)+mf3*b(10,6)*Smd(6,3)+mg3*b(10,7)*Smd(7,3)+mh3*b(10,8)*Smd(8,3)+mi3*b(10,9)*Smd(9,3)-mj3*sum(b(11:13,10).*Smd(11:13,3));
dmk3dt = Gs4*p4(11,3)-Gs3*p(11,3)+ma3*b(11,1)*Smd(1,3)+mb3*b(11,3)*Smd(2,2)+mc3*b(11,3)*Smd(3,3)+md3*b(11,4)*Smd(4,3)+me3*b(11,5)*Smd(5,3)+mf3*b(11,6)*Smd(6,3)+mg3*b(11,7)*Smd(7,3)+mh3*b(11,8)*Smd(8,3)+mi3*b(11,9)*Smd(9,3)+mj3*b(11,10)*Smd(10,3)-mk3*sum(b(12:13,11).*Smd(12:13,3));
dml3dt = Gs4*p4(12,3)-Gs3*p(12,3)+ma3*b(12,1)*Smd(1,3)+mb3*b(12,3)*Smd(2,3)+mc3*b(12,3)*Smd(3,3)+md3*b(12,4)*Smd(4,3)+me3*b(12,5)*Smd(5,3)+mf3*b(12,6)*Smd(6,3)+mg3*b(12,7)*Smd(7,3)+mh3*b(12,8)*Smd(8,3)+mi3*b(12,9)*Smd(9,3)+mj3*b(12,10)*Smd(10,3)+mk3*b(12,11)*Smd(11,3)-ml3*sum(b(13,12)*Smd(13,3));
dmm3dt = Gs4*p4(13,3)-Gs3*p(13,3)+ma3*b(13,1)*Smd(1,3)+mb3*b(13,3)*Smd(2,3)+mc3*b(13,3)*Smd(3,3)+md3*b(13,4)*Smd(4,3)+me3*b(13,5)*Smd(5,3)+mf3*b(13,6)*Smd(6,3)+mg3*b(13,7)*Smd(7,3)+mh3*b(13,8)*Smd(8,3)+mi3*b(13,9)*Smd(9,3)+mj3*b(13,10)*Smd(10,3)+mk3*b(13,11)*Smd(11,3)+ml3*b(13,12)*Smd(12,3)+0*mm3;

dma4dt = Gs4*p4(1,4)-Gs3*p(1,4)-ma4*sum(b(2:13,1).*Smd(2:13,4));
dmb4dt = Gs4*p4(2,4)-Gs3*p(2,4)+ma4*b(2,1)*Smd(1,4)-mb4*sum(b(3:13,2).*Smd(3:13,4));
dmc4dt = Gs4*p4(3,4)-Gs3*p(3,4)+ma4*b(3,1)*Smd(1,4)+mb4*b(3,3)*Smd(2,4)-mc4*sum(b(4:13,3).*Smd(4:13,4));
dmd4dt = Gs4*p4(4,4)-Gs3*p(4,4)+ma4*b(4,1)*Smd(1,4)+mb4*b(4,3)*Smd(2,4)+mc4*b(4,3)*Smd(3,4)-md4*sum(b(5:13,4).*Smd(5:13,4));
dme4dt = Gs4*p4(5,4)-Gs3*p(5,4)+ma4*b(5,1)*Smd(1,4)+mb4*b(5,3)*Smd(2,4)+mc4*b(5,3)*Smd(3,4)+md4*b(5,4)*Smd(4,4)-me4*sum(b(6:13,5).*Smd(6:13,4));
dmf4dt = Gs4*p4(6,4)-Gs3*p(6,4)+ma4*b(6,1)*Smd(1,4)+mb4*b(6,3)*Smd(2,4)+mc4*b(6,3)*Smd(3,4)+md4*b(6,4)*Smd(4,4)+me4*b(6,5)*Smd(5,4)-mf4*sum(b(7:13,6).*Smd(7:13,4));
dmg4dt = Gs4*p4(7,4)-Gs3*p(7,4)+ma4*b(7,1)*Smd(1,4)+mb4*b(7,3)*Smd(2,4)+mc4*b(7,3)*Smd(3,4)+md4*b(7,4)*Smd(4,4)+me4*b(7,5)*Smd(5,4)+mf4*b(7,6)*Smd(6,4)-mg4*sum(b(8:13,7).*Smd(8:13,4));
dmh4dt = Gs4*p4(8,4)-Gs3*p(8,4)+ma4*b(8,1)*Smd(1,4)+mb4*b(8,3)*Smd(2,4)+mc4*b(8,3)*Smd(3,4)+md4*b(8,4)*Smd(4,4)+me4*b(8,5)*Smd(5,4)+mf4*b(8,6)*Smd(6,4)+mg4*b(8,7)*Smd(7,4)-mh4*sum(b(9:13,8).*Smd(9:13,4));
dmi4dt = Gs4*p4(9,4)-Gs3*p(9,4)+ma4*b(9,1)*Smd(1,4)+mb4*b(9,3)*Smd(2,4)+mc4*b(9,3)*Smd(3,4)+md4*b(9,4)*Smd(4,4)+me4*b(9,5)*Smd(5,4)+mf4*b(9,6)*Smd(6,4)+mg4*b(9,7)*Smd(7,4)+mh4*b(9,8)*Smd(8,4)-mi4*sum(b(10:13,9).*Smd(10:13,4));
dmj4dt = Gs4*p4(10,4)-Gs3*p(10,4)+ma4*b(10,1)*Smd(1,4)+mb4*b(10,3)*Smd(2,4)+mc4*b(10,3)*Smd(3,4)+md4*b(10,4)*Smd(4,4)+me4*b(10,5)*Smd(5,4)+mf4*b(10,6)*Smd(6,4)+mg4*b(10,7)*Smd(7,4)+mh4*b(10,8)*Smd(8,4)+mi4*b(10,9)*Smd(9,4)-mj4*sum(b(11:13,10).*Smd(11:13,4));
dmk4dt = Gs4*p4(11,4)-Gs3*p(11,4)+ma4*b(11,1)*Smd(1,4)+mb4*b(11,3)*Smd(2,4)+mc4*b(11,3)*Smd(3,4)+md4*b(11,4)*Smd(4,4)+me4*b(11,5)*Smd(5,4)+mf4*b(11,6)*Smd(6,4)+mg4*b(11,7)*Smd(7,4)+mh4*b(11,8)*Smd(8,4)+mi4*b(11,9)*Smd(9,4)+mj4*b(11,10)*Smd(10,4)-mk4*sum(b(12:13,11).*Smd(12:13,4));
dml4dt = Gs4*p4(12,4)-Gs3*p(12,4)+ma4*b(12,1)*Smd(1,4)+mb4*b(12,3)*Smd(2,4)+mc4*b(12,3)*Smd(3,4)+md4*b(12,4)*Smd(4,4)+me4*b(12,5)*Smd(5,4)+mf4*b(12,6)*Smd(6,4)+mg4*b(12,7)*Smd(7,4)+mh4*b(12,8)*Smd(8,4)+mi4*b(12,9)*Smd(9,4)+mj4*b(12,10)*Smd(10,4)+mk4*b(12,11)*Smd(11,4)-ml4*sum(b(13,12)*Smd(13,4));
dmm4dt = Gs4*p4(13,4)-Gs3*p(13,4)+ma4*b(13,1)*Smd(1,4)+mb4*b(13,3)*Smd(2,4)+mc4*b(13,3)*Smd(3,4)+md4*b(13,4)*Smd(4,4)+me4*b(13,5)*Smd(5,4)+mf4*b(13,6)*Smd(6,4)+mg4*b(13,7)*Smd(7,4)+mh4*b(13,8)*Smd(8,4)+mi4*b(13,9)*Smd(9,4)+mj4*b(13,10)*Smd(10,4)+mk4*b(13,11)*Smd(11,4)+ml4*b(13,12)*Smd(12,4)+0*mm4;

dma5dt = Gs4*p4(1,5)-Gs3*p(1,5)-ma5*sum(b(2:13,1).*Smd(2:13,5));
dmb5dt = Gs4*p4(2,5)-Gs3*p(2,5)+ma5*b(2,1)*Smd(1,5)-mb5*sum(b(3:13,2).*Smd(3:13,5));
dmc5dt = Gs4*p4(3,5)-Gs3*p(3,5)+ma5*b(3,1)*Smd(1,5)+mb5*b(3,3)*Smd(2,5)-mc5*sum(b(4:13,3).*Smd(4:13,5));
dmd5dt = Gs4*p4(4,5)-Gs3*p(4,5)+ma5*b(4,1)*Smd(1,5)+mb5*b(4,3)*Smd(2,5)+mc5*b(4,3)*Smd(3,5)-md5*sum(b(5:13,4).*Smd(5:13,5));
dme5dt = Gs4*p4(5,5)-Gs3*p(5,5)+ma5*b(5,1)*Smd(1,5)+mb5*b(5,3)*Smd(2,5)+mc5*b(5,3)*Smd(3,5)+md5*b(5,4)*Smd(4,5)-me5*sum(b(6:13,5).*Smd(6:13,5));
dmf5dt = Gs4*p4(6,5)-Gs3*p(6,5)+ma5*b(6,1)*Smd(1,5)+mb5*b(6,3)*Smd(2,5)+mc5*b(6,3)*Smd(3,5)+md5*b(6,4)*Smd(4,5)+me5*b(6,5)*Smd(5,5)-mf5*sum(b(7:13,6).*Smd(7:13,5));
dmg5dt = Gs4*p4(7,5)-Gs3*p(7,5)+ma5*b(7,1)*Smd(1,5)+mb5*b(7,3)*Smd(2,5)+mc5*b(7,3)*Smd(3,5)+md5*b(7,4)*Smd(4,5)+me5*b(7,5)*Smd(5,5)+mf5*b(7,6)*Smd(6,5)-mg5*sum(b(8:13,7).*Smd(8:13,5));
dmh5dt = Gs4*p4(8,5)-Gs3*p(8,5)+ma5*b(8,1)*Smd(1,5)+mb5*b(8,3)*Smd(2,5)+mc5*b(8,3)*Smd(3,5)+md5*b(8,4)*Smd(4,5)+me5*b(8,5)*Smd(5,5)+mf5*b(8,6)*Smd(6,5)+mg5*b(8,7)*Smd(7,5)-mh5*sum(b(9:13,8).*Smd(9:13,5));
dmi5dt = Gs4*p4(9,5)-Gs3*p(9,5)+ma5*b(9,1)*Smd(1,5)+mb5*b(9,3)*Smd(2,5)+mc5*b(9,3)*Smd(3,5)+md5*b(9,4)*Smd(4,5)+me5*b(9,5)*Smd(5,5)+mf5*b(9,6)*Smd(6,5)+mg5*b(9,7)*Smd(7,5)+mh5*b(9,8)*Smd(8,5)-mi5*sum(b(10:13,9).*Smd(10:13,5));
dmj5dt = Gs4*p4(10,5)-Gs3*p(10,5)+ma5*b(10,1)*Smd(1,5)+mb5*b(10,3)*Smd(2,5)+mc5*b(10,3)*Smd(3,5)+md5*b(10,4)*Smd(4,5)+me5*b(10,5)*Smd(5,5)+mf5*b(10,6)*Smd(6,5)+mg5*b(10,7)*Smd(7,5)+mh5*b(10,8)*Smd(8,5)+mi5*b(10,9)*Smd(9,5)-mj5*sum(b(11:13,10).*Smd(11:13,5));
dmk5dt = Gs4*p4(11,5)-Gs3*p(11,5)+ma5*b(11,1)*Smd(1,5)+mb5*b(11,3)*Smd(2,5)+mc5*b(11,3)*Smd(3,5)+md5*b(11,4)*Smd(4,5)+me5*b(11,5)*Smd(5,5)+mf5*b(11,6)*Smd(6,5)+mg5*b(11,7)*Smd(7,5)+mh5*b(11,8)*Smd(8,5)+mi5*b(11,9)*Smd(9,5)+mj5*b(11,10)*Smd(10,5)-mk5*sum(b(12:13,11).*Smd(12:13,5));
dml5dt = Gs4*p4(12,5)-Gs3*p(12,5)+ma5*b(12,1)*Smd(1,5)+mb5*b(12,3)*Smd(2,5)+mc5*b(12,3)*Smd(3,5)+md5*b(12,4)*Smd(4,5)+me5*b(12,5)*Smd(5,5)+mf5*b(12,6)*Smd(6,5)+mg5*b(12,7)*Smd(7,5)+mh5*b(12,8)*Smd(8,5)+mi5*b(12,9)*Smd(9,5)+mj5*b(12,10)*Smd(10,5)+mk5*b(12,11)*Smd(11,5)-ml5*sum(b(13,12)*Smd(13,5));
dmm5dt = Gs4*p4(13,5)-Gs3*p(13,5)+ma5*b(13,1)*Smd(1,5)+mb5*b(13,3)*Smd(2,5)+mc5*b(13,3)*Smd(3,5)+md5*b(13,4)*Smd(4,5)+me5*b(13,5)*Smd(5,5)+mf5*b(13,6)*Smd(6,5)+mg5*b(13,7)*Smd(7,5)+mh5*b(13,8)*Smd(8,5)+mi5*b(13,9)*Smd(9,5)+mj5*b(13,10)*Smd(10,5)+mk5*b(13,11)*Smd(11,5)+ml5*b(13,12)*Smd(12,5)+0*mm5;

vectorode=[dma1dt; dmb1dt; dmc1dt; dmd1dt; dme1dt; dmf1dt; dmg1dt; dmh1dt; dmi1dt; dmj1dt; dmk1dt; dml1dt; dmm1dt;...
           dma2dt; dmb2dt; dmc2dt; dmd2dt; dme2dt; dmf2dt; dmg2dt; dmh2dt; dmi2dt; dmj2dt; dmk2dt; dml2dt; dmm2dt;...
           dma3dt; dmb3dt; dmc3dt; dmd3dt; dme3dt; dmf3dt; dmg3dt; dmh3dt; dmi3dt; dmj3dt; dmk3dt; dml3dt; dmm3dt;...
           dma4dt; dmb4dt; dmc4dt; dmd4dt; dme4dt; dmf4dt; dmg4dt; dmh4dt; dmi4dt; dmj4dt; dmk4dt; dml4dt; dmm4dt;...
           dma5dt; dmb5dt; dmc5dt; dmd5dt; dme5dt; dmf5dt; dmg5dt; dmh5dt; dmi5dt; dmj5dt; dmk5dt; dml5dt; dmm5dt];
Xtc = [45 31.5 22.4 16 11.2 8 5.6 2.8 1 0.5 0.315 0.2 0.125];
if t==25
    Hk
    fptHPGRu
    fpeHPGRu
    fpcHPGRu
    figure(2)
    semilogx(Xtc,fptHPGRu,'-s')
    grid on
    title('Granulometr�a bloque 3')
    xlabel('Tama�o de clases [mm]')
    ylabel('[%] Acumulado Pasante')
    p3=p;
    f3=fptHPGR;
    save('p3.mat','p3');
    save('f3.mat','f3');
end
end


