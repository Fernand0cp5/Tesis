%prueba
clear x t x0
x0(1) = 0;
x0(2) = 0;
x0(3) = 0;
x0(4) = 0;
x0(5) = 0;
x0(6) = 0;
x0(7) = 0;
x0(8) = 0;
x0(9) = 0;
x0(10) = 0;
x0(11) = 0;
x0(12) = 0;
x0(13) = 0;
tf = 5;
tspan = [0 tf];

fg1 = @(t1,xx) [Gs6*fipHPGR(1)-Gs5*(A(1,1)*exp((-Ppb(1)*SiE(1)*h)/(sum(xx(1:13))*U*3600)))-xx(1)*(b(2,1)*(Ppb(1)/sum(xx(1:13)))*SiE(2)+b(3,1)*(Ppb(1)/sum(xx(1:13)))*SiE(3)+b(4,1)*(Ppb(1)/sum(xx(1:13)))*SiE(4)+b(5,1)*(Ppb(1)/sum(xx(1:13)))*SiE(5)+b(6,1)*(Ppb(1)/sum(xx(1:13)))*SiE(6)+b(7,1)*(Ppb(1)/sum(xx(1:13)))*SiE(7)+b(8,1)*(Ppb(1)/sum(xx(1:13)))*SiE(8)+b(9,1)*(Ppb(1)/sum(xx(1:13)))*SiE(9)+b(10,1)*(Ppb(1)/sum(xx(1:13)))*SiE(10)+b(11,1)*(Ppb(1)/sum(xx(1:13)))*SiE(11)+b(12,1)*(Ppb(1)/sum(xx(1:13)))*SiE(12)+b(13,1)*(Ppb(1)/sum(xx(1:13)))*SiE(13));...
                
Gs6*fipHPGR(2)-Gs5*(A(2,1)*exp((-Ppb(1)*SiE(1)*h)/(sum(xx(1:13))*U*3600))+A(2,2)*exp((-Ppb(1)*SiE(2)*h)/(sum(xx(1:13))*U*3600)))+xx(1)*b(2,1)*(Ppb(1)*SiE(1)/sum(xx(1:13)))-xx(2)*(b(3,2)*(Ppb(1)*SiE(3)/sum(xx(1:13)))+b(4,2)*(Ppb(1)*SiE(4)/sum(xx(1:13)))+b(5,2)*(Ppb(1)*SiE(5)/sum(xx(1:13)))+b(6,2)*(Ppb(1)*SiE(6)/sum(xx(1:13)))+b(7,2)*(Ppb(1)*SiE(7)/sum(xx(1:13)))+b(8,2)*(Ppb(1)*SiE(8)/sum(xx(1:13)))+b(9,2)*(Ppb(1)*SiE(9)/sum(xx(1:13)))+b(10,2)*(Ppb(1)*SiE(10)/sum(xx(1:13)))+b(11,2)*(Ppb(1)*SiE(11)/sum(xx(1:13)))+b(12,2)*(Ppb(1)*SiE(13)/sum(xx(1:13))));...  

Gs6*fipHPGR(3)-Gs5*(A(3,1)*exp((-Ppb(1)*SiE(1)*h)/(sum(xx(1:13))*U*3600))+A(3,2)*exp((-Ppb(1)*SiE(2)*h)/(sum(xx(1:13))*U*3600))+A(3,3)*exp((-Ppb(1)*SiE(3)*h)/(sum(xx(1:13))*U*3600)))+xx(1)*b(3,1)*(Ppb(1)*SiE(1)/sum(xx(1:13)))+xx(2)*b(3,2)*(Ppb(1)*SiE(2)/sum(xx(1:13)))-xx(3)*(b(4,3)*(Ppb(1)*SiE(4)/sum(xx(1:13)))+b(5,13)*(Ppb(1)*SiE(5)/sum(xx(1:13)))+b(6,13)*(Ppb(1)*SiE(6)/sum(xx(1:13)))+b(7,13)*(Ppb(1)*SiE(7)/sum(xx(1:13)))+b(8,13)*(Ppb(1)*SiE(8)/sum(xx(1:13)))+b(9,13)*(Ppb(1)*SiE(9)/sum(xx(1:13)))+b(10,13)*(Ppb(1)*SiE(10)/sum(xx(1:13)))+b(11,13)*(Ppb(1)*SiE(11)/sum(xx(1:13)))+b(12,13)*(Ppb(1)*SiE(12)/sum(xx(1:13)))+b(13,13)*(Ppb(1)*SiE(13)/sum(xx(1:13))));...

Gs6*fipHPGR(4)-Gs5*(A(4,1)*exp((-Ppb(1)*SiE(1)*h)/(sum(xx(1:13))*U*3600))+A(4,2)*exp((-Ppb(1)*SiE(2)*h)/(sum(xx(1:13))*U*3600))+A(4,3)*exp((-Ppb(1)*SiE(3)*h)/(sum(xx(1:13))*U*3600))+A(4,4)*exp((-Ppb(1)*SiE(4)*h)/(sum(xx(1:13))*U*3600)))+xx(1)*b(4,1)*(Ppb(1)*SiE(1)/sum(xx(1:13)))+xx(2)*b(4,2)*(Ppb(1)*SiE(2)/sum(xx(1:13)))+xx(3)*b(4,3)*(Ppb(1)*SiE(3)/sum(xx(1:13)))-xx(4)*(b(5,4)*(Ppb(1)*SiE(5)/sum(xx(1:13)))+b(6,4)*(Ppb(1)*SiE(6)/sum(xx(1:13)))+b(7,4)*(Ppb(1)*SiE(7)/sum(xx(1:13)))+b(8,4)*(Ppb(1)*SiE(8)/sum(xx(1:13)))+b(9,4)*(Ppb(1)*SiE(9)/sum(xx(1:13)))+b(10,4)*(Ppb(1)*SiE(10)/sum(xx(1:13)))+b(11,4)*(Ppb(1)*SiE(11)/sum(xx(1:13)))+b(12,4)*(Ppb(1)*SiE(12)/sum(xx(1:13)))+b(13,4)*(Ppb(1)*SiE(13)/sum(xx(1:13))));...



            