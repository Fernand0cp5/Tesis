function flujoosok
valoresiniciales=[1.6;1.6;1.6;1.6;1.6;1.6;1.6;1.6;1.6;1.6];
[t,d]=ode1(@rodos,0,100, valoresiniciales,0.1);
t
d(1:600,1:10)
figure(1)
plot(t(1:600),d(1:600,1),t(1:600),d(1:600,2),t(1:600),d(1:600,3),t(1:600),d(1:600,4),t(1:600),d(1:600,5),...
     t(1:600),d(1:600,6),t(1:600),d(1:600,7),t(1:600),d(1:600,8),t(1:600),d(1:600,9),t(1:600),d(1:600,10)), hold on;
xlabel('Tiempo [s]');
ylabel('Densidad [ton/m^3]');
legend('rocm10','rocm9','rocm8','rocm7','rocm6','rocm5','rocm4','rocm3','rocm2','rocm1');
end
function vectorode =rodos(t, vectorvariablesdep)
load('vol1.mat','vol1');
load('vol2.mat','vol2');
load('vol3.mat','vol3');
load('vol4.mat','vol4');
load('vol5.mat','vol5');
load('vol6.mat','vol6');
load('vol7.mat','vol7');
load('vol8.mat','vol8');
load('vol9.mat','vol9');
load('vol10.mat','vol10');
load('L.mat','L');
load('s0.mat','s0');
load('D.mat','D');
load('U.mat','U');
load('roa.mat','roa');
%load('Gs11.mat','Gs11');
rocm10=vectorvariablesdep(1);
rocm9=vectorvariablesdep(2);
rocm8=vectorvariablesdep(3);
rocm7=vectorvariablesdep(4);
rocm6=vectorvariablesdep(5);
rocm5=vectorvariablesdep(6);
rocm4=vectorvariablesdep(7);
rocm3=vectorvariablesdep(8);
rocm2=vectorvariablesdep(9);
rocm1=vectorvariablesdep(10);

Gs11=3600*rocm1*s0*L*U;
alfacm10=acos((roa*(D+s0)-rocm10*s0)/(roa*D));
A10=L*(s0+D*(1-cos(alfacm10)));
V10=U*cos(alfacm10);
Gs10=3600*V10*A10*rocm10;

alfacm9=acos((rocm10*(D+s0)-rocm9*s0)/(rocm10*D));
A9=L*(s0+D*(1-cos(alfacm9)));
V9=U*cos(alfacm9);
Gs9=3600*V9*A9*rocm9;

alfacm8=acos((rocm9*(D+s0)-rocm8*s0)/(rocm9*D));
A8=L*(s0+D*(1-cos(alfacm8)));
V8=U*cos(alfacm8);
Gs8=3600*V8*A8*rocm8;

alfacm7=acos((rocm8*(D+s0)-rocm7*s0)/(rocm8*D));
A7=L*(s0+D*(1-cos(alfacm7)));
V7=U*cos(alfacm7);
Gs7=3600*V7*A7*rocm7;

alfacm6=acos((rocm7*(D+s0)-rocm6*s0)/(rocm7*D));
A6=L*(s0+D*(1-cos(alfacm6)));
V6=U*cos(alfacm6);
Gs6=3600*V6*A6*rocm6;

alfacm5=acos((rocm6*(D+s0)-rocm5*s0)/(rocm6*D));
A5=L*(s0+D*(1-cos(alfacm5)));
V5=U*cos(alfacm5);
Gs5=3600*V5*A5*rocm5;

alfacm4=acos((rocm5*(D+s0)-rocm4*s0)/(rocm5*D));
A4=L*(s0+D*(1-cos(alfacm4)));
V4=U*cos(alfacm4);
Gs4=3600*V4*A4*rocm4;

alfacm3=acos((rocm4*(D+s0)-rocm3*s0)/(rocm4*D));
A3=L*(s0+D*(1-cos(alfacm3)));
V3=U*cos(alfacm3);
Gs3=3600*V3*A3*rocm3;

alfacm2=acos((rocm3*(D+s0)-rocm2*s0)/(rocm3*D));
A2=L*(s0+D*(1-cos(alfacm2)));
V2=U*cos(alfacm2);
Gs2=3600*V2*A2*rocm2;

alfacm1=acos((rocm2*(D+s0)-rocm1*s0)/(rocm2*D));
A1=L*(s0+D*(1-cos(alfacm1)));
V1=U*cos(alfacm1);
Gs1=3600*V1*A1*rocm1;


drocm10dt= (Gs11-Gs10)/vol10;
drocm9dt= (Gs10-Gs9)/vol9;
drocm8dt= (Gs9-Gs8)/vol8;
drocm7dt= (Gs8-Gs7)/vol7;
drocm6dt= (Gs7-Gs6)/vol6;
drocm5dt= (Gs6-Gs5)/vol5;
drocm4dt= (Gs5-Gs4)/vol4;
drocm3dt= (Gs4-Gs3)/vol3;
drocm2dt= (Gs3-Gs2)/vol2;
drocm1dt= (Gs2-Gs1)/vol1;
vectorode=[drocm10dt; drocm9dt; drocm8dt; drocm7dt; drocm6dt;...
           drocm5dt; drocm4dt; drocm3dt; drocm2dt; drocm1dt];
figure(2)
       plot(t,Gs10,t,Gs9,t,Gs8,t,Gs7,t,Gs6,t,Gs5,t,Gs4,t,Gs3,t,Gs2,t,Gs1),hold on;
end



