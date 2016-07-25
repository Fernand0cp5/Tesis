function Salida=Granulometria8a(Entrada)
n=13;
NB=5;
U=Entrada(5);
h=Entrada(8);
fipHPGR(1)=Entrada(11);
fipHPGR(2)=Entrada(12);
fipHPGR(3)=Entrada(13);
fipHPGR(4)=Entrada(14);
fipHPGR(5)=Entrada(15);
fipHPGR(6)=Entrada(16);
fipHPGR(7)=Entrada(17);
fipHPGR(8)=Entrada(18);
fipHPGR(9)=Entrada(19);
fipHPGR(10)=Entrada(20);
fipHPGR(11)=Entrada(21);
fipHPGR(12)=Entrada(22);
fipHPGR(13)=Entrada(23);
Ppb(1)=Entrada(24);
Ppb(2)=Entrada(25);
Ppb(3)=Entrada(26);
Ppb(4)=Entrada(27);
Ppb(5)=Entrada(28);
SiE(1)=Entrada(29);
SiE(2)=Entrada(30);
SiE(3)=Entrada(31);
SiE(4)=Entrada(32);
SiE(5)=Entrada(33);
SiE(6)=Entrada(34);
SiE(7)=Entrada(35);
SiE(8)=Entrada(36);
SiE(9)=Entrada(37);
SiE(10)=Entrada(38);
SiE(11)=Entrada(39);
SiE(12)=Entrada(40);
SiE(13)=Entrada(41);
b(1,1)=Entrada(42);
b(2,1)=Entrada(43);
b(3,1)=Entrada(44);
b(4,1)=Entrada(45);
b(5,1)=Entrada(46);
b(6,1)=Entrada(47);
b(7,1)=Entrada(48);
b(8,1)=Entrada(49);
b(9,1)=Entrada(50);
b(10,1)=Entrada(51);
b(11,1)=Entrada(52);
b(12,1)=Entrada(53);
b(13,1)=Entrada(54);
b(1,2)=Entrada(55);
b(2,2)=Entrada(56);
b(3,2)=Entrada(57);
b(4,2)=Entrada(58);
b(5,2)=Entrada(59);
b(6,2)=Entrada(60);
b(7,2)=Entrada(61);
b(8,2)=Entrada(62);
b(9,2)=Entrada(63);
b(10,2)=Entrada(64);
b(11,2)=Entrada(65);
b(12,2)=Entrada(66);
b(13,2)=Entrada(67);
b(1,3)=Entrada(68);
b(2,3)=Entrada(69);
b(3,3)=Entrada(70);
b(4,3)=Entrada(71);
b(5,3)=Entrada(72);
b(6,3)=Entrada(73);
b(7,3)=Entrada(74);
b(8,3)=Entrada(75);
b(9,3)=Entrada(76);
b(10,3)=Entrada(77);
b(11,3)=Entrada(78);
b(12,3)=Entrada(79);
b(13,3)=Entrada(80);
b(1,4)=Entrada(81);
b(2,4)=Entrada(82);
b(3,4)=Entrada(82);
b(4,4)=Entrada(83);
b(5,4)=Entrada(84);
b(6,4)=Entrada(85);
b(7,4)=Entrada(86);
b(8,4)=Entrada(87);
b(9,4)=Entrada(88);
b(10,4)=Entrada(89);
b(11,4)=Entrada(90);
b(12,4)=Entrada(91);
b(13,4)=Entrada(92);
b(1,5)=Entrada(93);
b(2,5)=Entrada(94);
b(3,5)=Entrada(95);
b(4,5)=Entrada(96);
b(5,5)=Entrada(97);
b(6,5)=Entrada(98);
b(7,5)=Entrada(99);
b(8,5)=Entrada(100);
b(9,5)=Entrada(101);
b(10,5)=Entrada(102);
b(11,5)=Entrada(103);
b(12,5)=Entrada(104);
b(13,5)=Entrada(105);
b(1,6)=Entrada(106);
b(2,6)=Entrada(107);
b(3,6)=Entrada(108);
b(4,6)=Entrada(109);
b(5,6)=Entrada(110);
b(6,6)=Entrada(111);
b(7,6)=Entrada(112);
b(8,6)=Entrada(113);
b(9,6)=Entrada(114);
b(10,6)=Entrada(115);
b(11,6)=Entrada(116);
b(12,6)=Entrada(117);
b(13,6)=Entrada(118);
b(1,7)=Entrada(119);
b(2,7)=Entrada(120);
b(3,7)=Entrada(121);
b(4,7)=Entrada(122);
b(5,7)=Entrada(123);
b(6,7)=Entrada(124);
b(7,7)=Entrada(125);
b(8,7)=Entrada(126);
b(9,7)=Entrada(127);
b(10,7)=Entrada(128);
b(11,7)=Entrada(129);
b(12,7)=Entrada(130);
b(13,7)=Entrada(131);
b(1,8)=Entrada(132);
b(2,8)=Entrada(133);
b(3,8)=Entrada(134);
b(4,8)=Entrada(135);
b(5,8)=Entrada(136);
b(6,8)=Entrada(137);
b(7,8)=Entrada(138);
b(8,8)=Entrada(139);
b(9,8)=Entrada(140);
b(10,8)=Entrada(141);
b(11,8)=Entrada(142);
b(12,8)=Entrada(143);
b(13,8)=Entrada(144);
b(1,9)=Entrada(145);
b(2,9)=Entrada(146);
b(3,9)=Entrada(147);
b(4,9)=Entrada(148);
b(5,9)=Entrada(149);
b(6,9)=Entrada(150);
b(7,9)=Entrada(151);
b(8,9)=Entrada(152);
b(9,9)=Entrada(153);
b(10,9)=Entrada(154);
b(11,9)=Entrada(155);
b(12,9)=Entrada(156);
b(13,9)=Entrada(157);
b(1,10)=Entrada(158);
b(2,10)=Entrada(160);
b(3,10)=Entrada(161);
b(4,10)=Entrada(162);
b(5,10)=Entrada(163);
b(6,10)=Entrada(164);
b(7,10)=Entrada(165);
b(8,10)=Entrada(166);
b(9,10)=Entrada(167);
b(10,10)=Entrada(168);
b(11,10)=Entrada(169);
b(12,10)=Entrada(170);
b(13,10)=Entrada(171);
b(1,11)=Entrada(172);
b(2,11)=Entrada(173);
b(3,11)=Entrada(174);
b(4,11)=Entrada(175);
b(5,11)=Entrada(176);
b(6,11)=Entrada(177);
b(7,11)=Entrada(178);
b(8,11)=Entrada(179);
b(9,11)=Entrada(180);
b(10,11)=Entrada(181);
b(11,11)=Entrada(182);
b(12,11)=Entrada(183);
b(13,11)=Entrada(184);
b(1,12)=Entrada(185);
b(2,12)=Entrada(186);
b(3,12)=Entrada(187);
b(4,12)=Entrada(188);
b(5,12)=Entrada(189);
b(6,12)=Entrada(190);
b(7,12)=Entrada(191);
b(8,12)=Entrada(192);
b(9,12)=Entrada(193);
b(10,12)=Entrada(194);
b(11,12)=Entrada(195);
b(12,12)=Entrada(196);
b(13,12)=Entrada(197);
b(1,13)=Entrada(198);
b(2,13)=Entrada(199);
b(3,13)=Entrada(200);
b(4,13)=Entrada(201);
b(5,13)=Entrada(202);
b(6,13)=Entrada(203);
b(7,13)=Entrada(204);
b(8,13)=Entrada(205);
b(9,13)=Entrada(206);
b(10,13)=Entrada(207);
b(11,13)=Entrada(208);
b(12,13)=Entrada(209);
b(13,13)=Entrada(210);
Gs8=Entrada(211);
Hkb8 = (1/NB)*Gs8*h/(3600*U);
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
Salida=[fptHPGRu8];
end

