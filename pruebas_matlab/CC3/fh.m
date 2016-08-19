function Salida=fh(Entrada)
xin=Entrada(8);
Gsin=Entrada(14);
Gsout=Entrada(15);
rocm=Entrada(16);
vol=Entrada(17);
p(1)=Entrada(18);
p(2)=Entrada(19);
p(3)=Entrada(20);
p(4)=Entrada(21);
p(5)=Entrada(22);
p(6)=Entrada(23);
p(7)=Entrada(24);
Hk=rocm*vol;
x(1)=87.74270966450217;
x(2)=141.02326716924657;
x(3)=71.42713711433252;
x(4)=41.30545393133288;
x(5)=25.211578789632288;
x(6)=12.56261298696965;
x(7)=2.0494511033461853;
x(8)=0.6346520631643215;
x(9)=0.4914977601068599;
x(10)=0.4112346656234704;
x(11)=0.30931698697666116;
xg=(Gsin*xin-Gsout*p(7)+Hk*p(1)*x(1)*0.0167+Hk*p(2)*x(2)*0.0119+Hk*p(3)*x(3)*0.0101+Hk*p(4)*x(4)*0.0216+Hk*p(5)*x(5)*0.1084+Hk*p(6)*x(6)*0.7474-Hk*p(7)*x(7))/Hk;
Salida=xg;
end