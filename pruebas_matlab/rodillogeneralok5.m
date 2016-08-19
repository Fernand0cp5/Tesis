function rodillogeneralok5
valoresiniciales=[0.001;0.001;0.001;0.001;0.001;0.001;0.001;0.001;0.001;0.001;0.001;0.001];
trango=[0 3];
[t,d]=ode45(@rodos,trango, valoresiniciales);
t
d
figure(1)
plot(t,d), hold on;
xlabel('Tiempo [s]');
ylabel('Densidad [ton/m^3]');
legend('rocm');
end
function vectorode =rodos(t, vectorvariablesdep)
%definicion de variables dependientes
p(1)=vectorvariablesdep(1);
p(2)=vectorvariablesdep(2);
p(3)=vectorvariablesdep(3);
p(4)=vectorvariablesdep(4);
p(5)=vectorvariablesdep(5);
p(6)=vectorvariablesdep(6);
p(7)=vectorvariablesdep(7);
p(8)=vectorvariablesdep(8);
p(9)=vectorvariablesdep(9);
p(10)=vectorvariablesdep(10);
p(11)=vectorvariablesdep(11);
p(12)=vectorvariablesdep(12);
%**************************************************************************
fipHPGR=[0.0179 0.5111 0.1519 0.0642 0.0482 0.0579 0.0435 0.0232 0.0126 0.0112 0.0107 0.0477];
Gs=7.412055556; %kg/s
rocm=1947;%kg/m^3
vol=0.00001959;%m^3
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
%******************Parámetros Gs(i)****************************************
dmbdt=(Gs*fipHPGR(1)-Gs*p(1)-Hk*p(1)*x(1))/Hk;
dmcdt=(Gs*fipHPGR(2)-Gs*p(2)+Hk*p(1)*x(1)*0.7474-Hk*p(2)*x(2))/Hk;
dmddt=(Gs*fipHPGR(3)-Gs*p(3)+Hk*p(1)*x(1)*0.1084+Hk*p(2)*x(2)*0.7474-Hk*p(3)*x(3))/Hk;
dmedt=(Gs*fipHPGR(4)-Gs*p(4)+Hk*p(1)*x(1)*0.0216+Hk*p(2)*x(2)*0.1084+Hk*p(3)*x(3)*0.7474-Hk*p(4)*x(4))/Hk;
dmfdt=(Gs*fipHPGR(5)-Gs*p(5)+Hk*p(1)*x(1)*0.0101+Hk*p(2)*x(2)*0.0216+Hk*p(3)*x(3)*0.1084+Hk*p(4)*x(4)*0.7474-Hk*p(5)*x(5))/Hk;
dmgdt=(Gs*fipHPGR(6)-Gs*p(6)+Hk*p(1)*x(1)*0.0119+Hk*p(2)*x(2)*0.0101+Hk*p(3)*x(3)*0.0216+Hk*p(4)*x(4)*0.1084+Hk*p(5)*x(5)*0.7474-Hk*p(6)*x(6))/Hk;
dmhdt=(Gs*fipHPGR(7)-Gs*p(7)+Hk*p(1)*x(1)*0.0167+Hk*p(2)*x(2)*0.0119+Hk*p(3)*x(3)*0.0101+Hk*p(4)*x(4)*0.0216+Hk*p(5)*x(5)*0.1084+Hk*p(6)*x(6)*0.7474-Hk*p(7)*x(7))/Hk;
dmidt=(Gs*fipHPGR(8)-Gs*p(8)+Hk*p(1)*x(1)*0.0139+Hk*p(2)*x(2)*0.0167+Hk*p(3)*x(3)*0.0119+Hk*p(4)*x(4)*0.0101+Hk*p(5)*x(5)*0.0216+Hk*p(6)*x(6)*0.1084+Hk*p(7)*x(7)*0.7474-Hk*p(8)*x(8))/Hk;
dmjdt=(Gs*fipHPGR(9)-Gs*p(9)+Hk*p(1)*x(1)*0.0080+Hk*p(2)*x(2)*0.0139+Hk*p(3)*x(3)*0.0167+Hk*p(4)*x(4)*0.0119+Hk*p(5)*x(5)*0.0101+Hk*p(6)*x(6)*0.0216+Hk*p(7)*x(7)*0.01084+Hk*p(8)*x(8)*0.7474-Hk*p(9)*x(9))/Hk;
dmkdt=(Gs*fipHPGR(10)-Gs*p(10)+Hk*p(1)*x(1)*0.0057+Hk*p(2)*x(2)*0.0080+Hk*p(3)*x(3)*0.0139+Hk*p(4)*x(4)*0.0167+Hk*p(5)*x(5)*0.0119+Hk*p(6)*x(6)*0.0101+Hk*p(7)*x(7)*0.0216+Hk*p(8)*x(8)*0.1084+Hk*p(9)*x(9)*0.7474-Hk*p(10)*x(10))/Hk;
dmldt=(Gs*fipHPGR(11)-Gs*p(11)+Hk*p(1)*x(1)*0.0052+Hk*p(2)*x(2)*0.0057+Hk*p(3)*x(3)*0.0080+Hk*p(4)*x(4)*0.0139+Hk*p(5)*x(5)*0.0167+Hk*p(6)*x(6)*0.0119+Hk*p(7)*x(7)*0.0101+Hk*p(8)*x(8)*0.0216+Hk*p(9)*x(9)*0.1084+Hk*p(10)*x(10)*0.7474-Hk*p(11)*x(11))/Hk;
dmmdt=(Gs*fipHPGR(12)-Gs*p(12)+Hk*p(1)*x(1)*0.0511+Hk*p(2)*x(2)*0.0564+Hk*p(3)*x(3)*0.0620+Hk*p(4)*x(4)*0.0700+Hk*p(5)*x(5)*0.0839+Hk*p(6)*x(6)*0.1006+Hk*p(7)*x(7)*0.1125+Hk*p(8)*x(8)*0.1226+Hk*p(9)*x(9)*0.1442+Hk*p(10)*x(10)*0.2526+Hk*p(11)*x(11))/Hk;
    
vectorode=[dmbdt;dmcdt;dmddt; dmedt; dmfdt; dmgdt; dmhdt; dmidt; dmjdt; dmkdt; dmldt; dmmdt];% ];%; dmm1dt];
end