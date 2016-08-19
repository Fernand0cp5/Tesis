Gs=26.6834; % (t/hora);
fipHPGR=[0.0179 0.5111 0.1519 0.0642 0.0482 0.0579 0.0435 0.0232 0.0126 0.0112 0.0107 0.0477];%0.0179 0.5111 0.1519 0.0642 0.0482 0.0579 0.0435 0.0232 0.0126 0.0112 0.0107 0.0477];
rocm=1.947; % t/m3
vol=159.9857; % cm3
Hk=rocm*vol/1e6; %kg
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
syms p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12
pp1 = strcat(num2str(0),'=',char(Gs*fipHPGR(1)-Gs*p1-Hk*p1*x(1)));
pp2 = strcat(num2str(0),'=',char(Gs*fipHPGR(2)-Gs*p2+Hk*p1*x(1)*0.7474-Hk*p2*x(2)));
pp3 = strcat(num2str(0),'=',char(Gs*fipHPGR(3)-Gs*p3+Hk*p1*x(1)*0.1084+Hk*p2*x(2)*0.7474-Hk*p3*x(3)));
pp4 = strcat(num2str(0),'=',char(Gs*fipHPGR(4)-Gs*p4+Hk*p1*x(1)*0.0216+Hk*p2*x(2)*0.1084+Hk*p3*x(3)*0.7474-Hk*p4*x(4)));
pp5 = strcat(num2str(0),'=',char(Gs*fipHPGR(5)-Gs*p5+Hk*p1*x(1)*0.0101+Hk*p2*x(2)*0.0216+Hk*p3*x(3)*0.1084+Hk*p4*x(4)*0.7474-Hk*p5*x(5)));
pp6 = strcat(num2str(0),'=',char(Gs*fipHPGR(6)-Gs*p6+Hk*p1*x(1)*0.0119+Hk*p2*x(2)*0.0101+Hk*p3*x(3)*0.0216+Hk*p4*x(4)*0.1084+Hk*p5*x(5)*0.7474-Hk*p6*x(6)));
pp7 = strcat(num2str(0),'=',char(Gs*fipHPGR(7)-Gs*p7+Hk*p1*x(1)*0.0167+Hk*p2*x(2)*0.0119+Hk*p3*x(3)*0.0101+Hk*p4*x(4)*0.0216+Hk*p5*x(5)*0.1084+Hk*p6*x(6)*0.7474-Hk*p7*x(7)));
pp8 = strcat(num2str(0),'=',char(Gs*fipHPGR(8)-Gs*p8+Hk*p1*x(1)*0.0139+Hk*p2*x(2)*0.0167+Hk*p3*x(3)*0.0119+Hk*p4*x(4)*0.0101+Hk*p5*x(5)*0.0216+Hk*p6*x(6)*0.1084+Hk*p7*x(7)*0.7474-Hk*p8*x(8)));
pp9 = strcat(num2str(0),'=',char(Gs*fipHPGR(9)-Gs*p9+Hk*p1*x(1)*0.0080+Hk*p2*x(2)*0.0139+Hk*p3*x(3)*0.0167+Hk*p4*x(4)*0.0119+Hk*p5*x(5)*0.0101+Hk*p6*x(6)*0.0216+Hk*p7*x(7)*0.01084+Hk*p8*x(8)*0.7474-Hk*p9*x(9)));
pp10 = strcat(num2str(0),'=',char(Gs*fipHPGR(10)-Gs*p10+Hk*p1*x(1)*0.0057+Hk*p2*x(2)*0.0080+Hk*p3*x(3)*0.0139+Hk*p4*x(4)*0.0167+Hk*p5*x(5)*0.0119+Hk*p6*x(6)*0.0101+Hk*p7*x(7)*0.0216+Hk*p8*x(8)*0.1084+Hk*p9*x(9)*0.7474-Hk*p10*x(10)));
pp11 = strcat(num2str(0),'=',char(Gs*fipHPGR(11)-Gs*p11+Hk*p1*x(1)*0.0052+Hk*p2*x(2)*0.0057+Hk*p3*x(3)*0.0080+Hk*p4*x(4)*0.0139+Hk*p5*x(5)*0.0167+Hk*p6*x(6)*0.0119+Hk*p7*x(7)*0.0101+Hk*p8*x(8)*0.0216+Hk*p9*x(9)*0.1084+Hk*p10*x(10)*0.7474-Hk*p11*x(11)));
pp12 = strcat(num2str(0),'=',char(Gs*fipHPGR(12)-Gs*p12+Hk*p1*x(1)*0.0511+Hk*p2*x(2)*0.0564+Hk*p3*x(3)*0.0620+Hk*p4*x(4)*0.0700+Hk*p5*x(5)*0.0839+Hk*p6*x(6)*0.1006+Hk*p7*x(7)*0.1125+Hk*p8*x(8)*0.1226+Hk*p9*x(9)*0.1442+Hk*p10*x(10)*0.2526+Hk*p11*x(11)));
solve(pp1,pp2,pp3,pp4,pp5,pp6,pp7,pp8,pp9,pp10,pp11,pp12,'p1','p2','p3','p4','p5','p6','p7','p8','p9','p10','p11','p12');
p1 = double(ans.p1);
p2 = double(ans.p2);
p3 = double(ans.p3);
p4 = double(ans.p4);
p5 = double(ans.p5);
p6 = double(ans.p6);
p7 = double(ans.p7);
p8 = double(ans.p8);
p9 = double(ans.p9);
p10 = double(ans.p10);
p11 = double(ans.p11);
p12 = double(ans.p12);
p = [p1 p2 p3 p4 p5 p6 p7 p8 p9 p10 p11 p12]