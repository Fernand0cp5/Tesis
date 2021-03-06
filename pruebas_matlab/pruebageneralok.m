function pruebageneralok
valoresiniciales=[1.9;1.9;1.9;1.9;1.9]; %valores iniciales para densidad 
[t,d]=ode1(@rodos,0,60,valoresiniciales,1);
d
figure(2)
plot(t,d),hold on;
xlabel('Tiempo [s]')
ylabel('Densidad [ton/cm^3]')
legend('rocm5','rocm4','rocm3','rocm2','rocm1')
end

function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('vol2.mat','vol2');
load('vol3.mat','vol3');
load('vol4.mat','vol4');
load('vol5.mat','vol5');
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
rocm4=vectorvariablesdep(2);
rocm3=vectorvariablesdep(3);
rocm2=vectorvariablesdep(4);
rocm1=vectorvariablesdep(5);
%******************Par�metros Gs(i)****************************************
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
%****************Bloque horizontal 1***************************************
Hkb1 = (1/NB)*Gs1*Z/(3600*U); 
%end
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
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
%Distribuci�n del tama�o de part�cula en zona BP,
%Granulometria por bloques 
for k = 1:NB;
    for i = 1:n-1;
        suma = 0;
        for j = 1:i;
            suma = suma + A(i,j)*exp(-1*S(j,k)*Z/U);% Distribuci�n granulom�trica ec 3.29
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

figure(3)
plot(t,Gs1),hold on
figure(4)
plot(t,Hkb1),hold on
figure(5)
subplot(3,1,1)
semilogx(Xt,fptHPGRu,'-s'),hold on,grid on,legend('[%] Acumulado Pasante total')
subplot(3,1,2)
semilogx(Xt,fpeHPGRu,'-s'),hold on,grid on,legend('[%] Acumulado Pasante borde')
subplot(3,1,3)
semilogx(Xt,fpcHPGRu,'-s'),hold on,grid on,legend('[%] Acumulado Pasante centro')
Granulometrias = [fptHPGRu;fpeHPGRu;fpcHPGRu];
xlswrite('datos4.xls',Granulometrias)
end