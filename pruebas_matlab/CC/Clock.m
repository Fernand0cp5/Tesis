function Salida= Clock(Entrada)
t=Entrada(1);
faHPGR(1)=Entrada(2);
faHPGR(2)=Entrada(3);
faHPGR(3)=Entrada(4);
faHPGR(4)=Entrada(5);
faHPGR(5)=Entrada(6);
faHPGR(6)=Entrada(7);
faHPGR(7)=Entrada(8);
faHPGR(8)=Entrada(9);
faHPGR(9)=Entrada(10);
faHPGR(10)=Entrada(11);
faHPGR(11)=Entrada(12);
faHPGR(12)=Entrada(13);
faHPGR(13)=Entrada(14);
faHPGRi(1)=Entrada(15);
faHPGRi(2)=Entrada(16);
faHPGRi(3)=Entrada(17);
faHPGRi(4)=Entrada(18);
faHPGRi(5)=Entrada(19);
faHPGRi(6)=Entrada(20);
faHPGRi(7)=Entrada(21);
faHPGRi(8)=Entrada(22);
faHPGRi(9)=Entrada(23);
faHPGRi(10)=Entrada(24);
faHPGRi(11)=Entrada(25);
faHPGRi(12)=Entrada(26);
faHPGRi(13)=Entrada(27);
if t>0;
    Salida=[faHPGR(1) faHPGR(2) faHPGR(3) faHPGR(4) faHPGR(5) faHPGR(6)...
            faHPGR(7) faHPGR(8) faHPGR(9) faHPGR(10) faHPGR(11) faHPGR(12) faHPGR(13)];
else
    t=0;
    Salida=[faHPGRi(1) faHPGRi(2) faHPGRi(3) faHPGRi(4) faHPGRi(5) faHPGRi(6)...
            faHPGRi(7) faHPGRi(8) faHPGRi(9) faHPGRi(10) faHPGRi(11) faHPGRi(12) faHPGRi(13)];
end
end
