function Salida=Granulometriaa3(Entrada)
U=0.67;
n=13;
NB=5;
h=0.0059;
fipHPGR(1)=Entrada(2);
fipHPGR(2)=Entrada(3);
fipHPGR(3)=Entrada(4);
fipHPGR(4)=Entrada(5);
fipHPGR(5)=Entrada(6);
fipHPGR(6)=Entrada(7);
fipHPGR(7)=Entrada(8);
fipHPGR(8)=Entrada(9);
fipHPGR(9)=Entrada(10);
fipHPGR(10)=Entrada(11);
fipHPGR(11)=Entrada(12);
fipHPGR(12)=Entrada(13);
fipHPGR(13)=Entrada(14);
Ppb(1)=Entrada(32);
Ppb(2)=Entrada(33);
Ppb(3)=Entrada(34);
Ppb(4)=Entrada(35);
Ppb(5)=Entrada(36);
SiE(1)=Entrada(37);
SiE(2)=Entrada(38);
SiE(3)=Entrada(39);
SiE(4)=Entrada(40);
SiE(5)=Entrada(41);
SiE(6)=Entrada(42);
SiE(7)=Entrada(43);
SiE(8)=Entrada(44);
SiE(9)=Entrada(45);
SiE(10)=Entrada(46);
SiE(11)=Entrada(47);
SiE(12)=Entrada(48);
SiE(13)=Entrada(49);
b(1,1)=Entrada(50);
b(2,1)=Entrada(51);
b(3,1)=Entrada(52);
b(4,1)=Entrada(53);
b(5,1)=Entrada(54);
b(6,1)=Entrada(55);
b(7,1)=Entrada(56);
b(8,1)=Entrada(57);
b(9,1)=Entrada(58);
b(10,1)=Entrada(59);
b(11,1)=Entrada(60);
b(12,1)=Entrada(61);
b(13,1)=Entrada(62);
b(1,2)=Entrada(63);
b(2,2)=Entrada(64);
b(3,2)=Entrada(65);
b(4,2)=Entrada(66);
b(5,2)=Entrada(67);
b(6,2)=Entrada(68);
b(7,2)=Entrada(69);
b(8,2)=Entrada(70);
b(9,2)=Entrada(71);
b(10,2)=Entrada(72);
b(11,2)=Entrada(73);
b(12,2)=Entrada(74);
b(13,2)=Entrada(75);
b(1,3)=Entrada(76);
b(2,3)=Entrada(77);
b(3,3)=Entrada(78);
b(4,3)=Entrada(79);
b(5,3)=Entrada(80);
b(6,3)=Entrada(81);
b(7,3)=Entrada(82);
b(8,3)=Entrada(83);
b(9,3)=Entrada(84);
b(10,3)=Entrada(85);
b(11,3)=Entrada(86);
b(12,3)=Entrada(87);
b(13,3)=Entrada(88);
b(1,4)=Entrada(89);
b(2,4)=Entrada(90);
b(3,4)=Entrada(91);
b(4,4)=Entrada(92);
b(5,4)=Entrada(93);
b(6,4)=Entrada(94);
b(7,4)=Entrada(95);
b(8,4)=Entrada(96);
b(9,4)=Entrada(97);
b(10,4)=Entrada(98);
b(11,4)=Entrada(99);
b(12,4)=Entrada(100);
b(13,4)=Entrada(101);
b(1,5)=Entrada(102);
b(2,5)=Entrada(103);
b(3,5)=Entrada(104);
b(4,5)=Entrada(105);
b(5,5)=Entrada(106);
b(6,5)=Entrada(107);
b(7,5)=Entrada(108);
b(8,5)=Entrada(109);
b(9,5)=Entrada(110);
b(10,5)=Entrada(111);
b(11,5)=Entrada(112);
b(12,5)=Entrada(113);
b(13,5)=Entrada(114);
b(1,6)=Entrada(115);
b(2,6)=Entrada(116);
b(3,6)=Entrada(117);
b(4,6)=Entrada(118);
b(5,6)=Entrada(119);
b(6,6)=Entrada(120);
b(7,6)=Entrada(121);
b(8,6)=Entrada(122);
b(9,6)=Entrada(123);
b(10,6)=Entrada(124);
b(11,6)=Entrada(125);
b(12,6)=Entrada(126);
b(13,6)=Entrada(127);
b(1,7)=Entrada(128);
b(2,7)=Entrada(129);
b(3,7)=Entrada(130);
b(4,7)=Entrada(131);
b(5,7)=Entrada(132);
b(6,7)=Entrada(133);
b(7,7)=Entrada(134);
b(8,7)=Entrada(135);
b(9,7)=Entrada(136);
b(10,7)=Entrada(137);
b(11,7)=Entrada(138);
b(12,7)=Entrada(139);
b(13,7)=Entrada(140);
b(1,8)=Entrada(141);
b(2,8)=Entrada(142);
b(3,8)=Entrada(143);
b(4,8)=Entrada(144);
b(5,8)=Entrada(145);
b(6,8)=Entrada(146);
b(7,8)=Entrada(147);
b(8,8)=Entrada(148);
b(9,8)=Entrada(149);
b(10,8)=Entrada(150);
b(11,8)=Entrada(151);
b(12,8)=Entrada(152);
b(13,8)=Entrada(153);
b(1,9)=Entrada(154);
b(2,9)=Entrada(155);
b(3,9)=Entrada(156);
b(4,9)=Entrada(157);
b(5,9)=Entrada(158);
b(6,9)=Entrada(159);
b(7,9)=Entrada(160);
b(8,9)=Entrada(161);
b(9,9)=Entrada(162);
b(10,9)=Entrada(163);
b(11,9)=Entrada(164);
b(12,9)=Entrada(165);
b(13,9)=Entrada(166);
b(1,10)=Entrada(167);
b(2,10)=Entrada(168);
b(3,10)=Entrada(169);
b(4,10)=Entrada(170);
b(5,10)=Entrada(171);
b(6,10)=Entrada(172);
b(7,10)=Entrada(173);
b(8,10)=Entrada(174);
b(9,10)=Entrada(175);
b(10,10)=Entrada(176);
b(11,10)=Entrada(177);
b(12,10)=Entrada(178);
b(13,10)=Entrada(179);
b(1,11)=Entrada(180);
b(2,11)=Entrada(181);
b(3,11)=Entrada(182);
b(4,11)=Entrada(183);
b(5,11)=Entrada(184);
b(6,11)=Entrada(185);
b(7,11)=Entrada(186);
b(8,11)=Entrada(187);
b(9,11)=Entrada(188);
b(10,11)=Entrada(189);
b(11,11)=Entrada(190);
b(12,11)=Entrada(191);
b(13,11)=Entrada(192);
b(1,12)=Entrada(193);
b(2,12)=Entrada(194);
b(3,12)=Entrada(195);
b(4,12)=Entrada(196);
b(5,12)=Entrada(197);
b(6,12)=Entrada(198);
b(7,12)=Entrada(199);
b(8,12)=Entrada(200);
b(9,12)=Entrada(201);
b(10,12)=Entrada(202);
b(11,12)=Entrada(203);
b(12,12)=Entrada(204);
b(13,12)=Entrada(205);
b(1,13)=Entrada(206);
b(2,13)=Entrada(207);
b(3,13)=Entrada(208);
b(4,13)=Entrada(209);
b(5,13)=Entrada(210);
b(6,13)=Entrada(211);
b(7,13)=Entrada(212);
b(8,13)=Entrada(213);
b(9,13)=Entrada(214);
b(10,13)=Entrada(215);
b(11,13)=Entrada(216);
b(12,13)=Entrada(217);
b(13,13)=Entrada(218);
Gs3=Entrada(219);
Hkb3 = (1/NB)*Gs3*h/(3600*U);
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
Salida=[fptHPGRu3];
end