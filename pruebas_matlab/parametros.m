function F=parametros(Entrada)
Gs=Entrada; % (kg/hora);
fipHPGR=[0.0179 0.5111 0.1519 0.0642 0.0482 0.0579 0.0435 0.0232 0.0126 0.0112 0.0107 0.0477];%0.0179 0.5111 0.1519 0.0642 0.0482 0.0579 0.0435 0.0232 0.0126 0.0112 0.0107 0.0477];
%p=[0.0036 0.0750 0.1211 0.1404 0.1359 0.1344 0.1177 0.0557 0.0323 0.0268 0.0231 0.1341];
rocm=1.947; % kg/m3
vol=159.9857; % cm3
Hk=rocm*vol/1e6; %kg

%321545.1437978883	505181.5328563425	255485.67203077496
%148489.09477203107	91318.07363792782	46456.55902621595	
%8163.538621324889	3491.624219433459	903.7490589987162	971.740011717597	657.9940849080238

x(1)=321545.1437978883;
x(2)=505181.5328563425;
x(3)=255485.67203077496;
x(4)=148489.09477203107;
x(5)=91318.07363792782;
x(6)=46456.55902621595;
x(7)=8163.538621324889;
x(8)=3491.624219433459;
x(9)=903.7490589987162;
x(10)=971.740011717597;
x(11)=657.9940849080238;

F(2)=Gs*fipHPGR(2)-Gs*p(2)+Hk*p(1)*x(1)*0.7474-Hk*p(2)*x(2);
F(3)=Gs*fipHPGR(3)-Gs*p(3)+Hk*p(1)*x(1)*0.1084+Hk*p(2)*x(2)*0.7474-Hk*p(3)*x(3);
F(4)=Gs*fipHPGR(4)-Gs*p(4)+Hk*p(1)*x(1)*0.0216+Hk*p(2)*x(2)*0.1084+Hk*p(3)*x(3)*0.7474-Hk*p(4)*x(4);
F(5)=Gs*fipHPGR(5)-Gs*p(5)+Hk*p(1)*x(1)*0.0101+Hk*p(2)*x(2)*0.0216+Hk*p(3)*x(3)*0.1084+Hk*p(4)*x(4)*0.7474-Hk*p(5)*x(5);
F(6)=Gs*fipHPGR(6)-Gs*p(6)+Hk*p(1)*x(1)*0.0119+Hk*p(2)*x(2)*0.0101+Hk*p(3)*x(3)*0.0216+Hk*p(4)*x(4)*0.1084+Hk*p(5)*x(5)*0.7474-Hk*p(6)*x(6);
F(7)=Gs*fipHPGR(7)-Gs*p(7)+Hk*p(1)*x(1)*0.0167+Hk*p(2)*x(2)*0.0119+Hk*p(3)*x(3)*0.0101+Hk*p(4)*x(4)*0.0216+Hk*p(5)*x(5)*0.1084+Hk*p(6)*x(6)*0.7474-Hk*p(7)*x(7);
F(8)=Gs*fipHPGR(8)-Gs*p(8)+Hk*p(1)*x(1)*0.0139+Hk*p(2)*x(2)*0.0167+Hk*p(3)*x(3)*0.0119+Hk*p(4)*x(4)*0.0101+Hk*p(5)*x(5)*0.0216+Hk*p(6)*x(6)*0.1084+Hk*p(7)*x(7)*0.7474-Hk*p(8)*x(8);
F(9)=1000*(Gs*fipHPGR(9)-Gs*p(9)+Hk*p(1)*x(1)*0.0080+Hk*p(2)*x(2)*0.0139+Hk*p(3)*x(3)*0.0167+Hk*p(4)*x(4)*0.0119+Hk*p(5)*x(5)*0.0101+Hk*p(6)*x(6)*0.0216+Hk*p(7)*x(7)*0.01084+Hk*p(8)*x(8)*0.7474-Hk*p(9)*x(9));
F(10)=1000*(Gs*fipHPGR(10)-Gs*p(10)+Hk*p(1)*x(1)*0.0057+Hk*p(2)*x(2)*0.0080+Hk*p(3)*x(3)*0.0139+Hk*p(4)*x(4)*0.0167+Hk*p(5)*x(5)*0.0119+Hk*p(6)*x(6)*0.0101+Hk*p(7)*x(7)*0.0216+Hk*p(8)*x(8)*0.1084+Hk*p(9)*x(9)*0.7474-Hk*p(10)*x(10));
F(11)=1000*(Gs*fipHPGR(11)-Gs*p(11)+Hk*p(1)*x(1)*0.0052+Hk*p(2)*x(2)*0.0057+Hk*p(3)*x(3)*0.0080+Hk*p(4)*x(4)*0.0139+Hk*p(5)*x(5)*0.0167+Hk*p(6)*x(6)*0.0119+Hk*p(7)*x(7)*0.0101+Hk*p(8)*x(8)*0.0216+Hk*p(9)*x(9)*0.1084+Hk*p(10)*x(10)*0.7474-Hk*p(11)*x(11));
F(12)=1000*(Gs*fipHPGR(12)-Gs*p(12)+Hk*p(1)*x(1)*0.0511+Hk*p(2)*x(2)*0.0564+Hk*p(3)*x(3)*0.0620+Hk*p(4)*x(4)*0.0700+Hk*p(5)*x(5)*0.0839+Hk*p(6)*x(6)*0.1006+Hk*p(7)*x(7)*0.1125+Hk*p(8)*x(8)*0.1226+Hk*p(9)*x(9)*0.1442+Hk*p(10)*x(10)*0.2526+Hk*p(11)*x(11));
%J=(F(1))^2+(F(2))^2+(F(3))^2+(F(4))^2+(F(5))^2+(F(6))^2+(F(7))^2+(F(8))^2+(F(9))^2+(F(10))^2+(F(11))^2+(F(12))^2;
fun=@parametros;
p0=p0=[1,1,1,1,1,1,1,1,1,1,1,1];
pe=fsolve(fun,p0);
end




