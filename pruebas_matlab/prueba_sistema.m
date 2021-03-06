function prueba_sistema (Gs6, Gs5, b, S, fipHPGR,p)
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
fg1 = @(t1,xx) [Gs6*fipHPGR(1)-Gs5*p(1,1)-xx(1)*sum(b(2:13,1).*S(2:13,1));...
            Gs6*fipHPGR(2)-Gs5*p(2,1)+xx(1)*b(2,1)*S(1,1)-xx(2)*sum(b(3:13,2).*S(3:13,1));...
            Gs6*fipHPGR(3)-Gs5*p(3,1)+xx(1)*b(3,1)*S(1,1)+xx(2)*b(3,2)*S(2,1)-xx(3)*sum(b(4:13,3).*S(4:13,1));...
            Gs6*fipHPGR(4)-Gs5*p(4,1)+xx(1)*b(4,1)*S(1,1)+xx(2)*b(4,2)*S(2,1)+xx(3)*b(4,3)*S(3,1)-xx(4)*sum(b(5:13,4).*S(5:13,1));...
            Gs6*fipHPGR(5)-Gs5*p(5,1)+xx(1)*b(5,1)*S(1,1)+xx(2)*b(5,2)*S(2,1)+xx(3)*b(5,3)*S(3,1)+xx(4)*b(5,4)*S(4,1)-xx(5)*sum(b(6:13,5).*S(6:13,1));...
            Gs6*fipHPGR(6)-Gs5*p(6,1)+xx(1)*b(6,1)*S(1,1)+xx(2)*b(6,2)*S(2,1)+xx(3)*b(6,3)*S(3,1)+xx(4)*b(6,4)*S(4,1)+xx(5)*b(6,5)*S(5,1)-xx(6)*sum(b(7:13,6).*S(7:13,1));...
            Gs6*fipHPGR(7)-Gs5*p(7,1)+xx(1)*b(7,1)*S(1,1)+xx(2)*b(7,2)*S(2,1)+xx(3)*b(7,3)*S(3,1)+xx(4)*b(7,4)*S(4,1)+xx(5)*b(7,5)*S(5,1)+xx(6)*b(7,6)*S(6,1)-xx(7)*sum(b(8:13,7).*S(8:13,1));...
            Gs6*fipHPGR(8)-Gs5*p(8,1)+xx(1)*b(8,1)*S(1,1)+xx(2)*b(8,2)*S(2,1)+xx(3)*b(8,3)*S(3,1)+xx(4)*b(8,4)*S(4,1)+xx(5)*b(8,5)*S(5,1)+xx(6)*b(8,6)*S(6,1)+xx(7)*b(8,7)*S(7,1)-xx(8)*sum(b(9:13,8).*S(9:13,1));...
            Gs6*fipHPGR(9)-Gs5*p(9,1)+xx(1)*b(9,1)*S(1,1)+xx(2)*b(9,2)*S(2,1)+xx(3)*b(9,3)*S(3,1)+xx(4)*b(9,4)*S(4,1)+xx(5)*b(9,5)*S(5,1)+xx(6)*b(9,6)*S(6,1)+xx(7)*b(9,7)*S(7,1)+xx(8)*b(9,8)*S(8,1)-xx(9)*sum(b(10:13,9).*S(10:13,1));...
            Gs6*fipHPGR(10)-Gs5*p(10,1)+xx(1)*b(10,1)*S(1,1)+xx(2)*b(10,2)*S(2,1)+xx(3)*b(10,3)*S(3,1)+xx(4)*b(10,4)*S(4,1)+xx(5)*b(10,5)*S(5,1)+xx(6)*b(10,6)*S(6,1)+xx(7)*b(10,7)*S(7,1)+xx(8)*b(10,8)*S(8,1)+xx(9)*b(10,9)*S(9,1)-xx(10)*sum(b(11:13,10).*S(11:13,1));...
            Gs6*fipHPGR(11)-Gs5*p(11,1)+xx(1)*b(11,1)*S(1,1)+xx(2)*b(11,2)*S(2,1)+xx(3)*b(11,3)*S(3,1)+xx(4)*b(11,4)*S(4,1)+xx(5)*b(11,5)*S(5,1)+xx(6)*b(11,6)*S(6,1)+xx(7)*b(11,7)*S(7,1)+xx(8)*b(11,8)*S(8,1)+xx(9)*b(11,9)*S(9,1)+xx(10)*b(11,10)*S(10,1)-xx(11)*sum(b(12:13,11).*S(12:13,1));...
            Gs6*fipHPGR(12)-Gs5*p(12,1)+xx(1)*b(12,1)*S(1,1)+xx(2)*b(12,2)*S(2,1)+xx(3)*b(12,3)*S(3,1)+xx(4)*b(12,4)*S(4,1)+xx(5)*b(12,5)*S(5,1)+xx(6)*b(12,6)*S(6,1)+xx(7)*b(12,7)*S(7,1)+xx(8)*b(12,8)*S(8,1)+xx(9)*b(12,9)*S(9,1)+xx(10)*b(12,10)*S(10,1)+xx(11)*b(12,11)*S(11,1)-xx(12)*sum(b(13,12)*S(13,1));...
            Gs6*fipHPGR(13)-Gs5*p(13,1)+xx(1)*b(13,1)*S(1,1)+xx(2)*b(13,2)*S(2,1)+xx(3)*b(13,3)*S(3,1)+xx(4)*b(13,4)*S(4,1)+xx(5)*b(13,5)*S(5,1)+xx(6)*b(13,6)*S(6,1)+xx(7)*b(13,7)*S(7,1)+xx(8)*b(13,8)*S(8,1)+xx(9)*b(13,9)*S(9,1)+xx(10)*b(13,10)*S(10,1)+xx(11)*b(13,11)*S(11,1)+xx(12)*b(13,12)*S(12,1)+0*xx(13)];
          
fg2 = @(t2,yy) [Gs6*fipHPGR(1)-Gs5*p(1,2)-yy(1)*sum(b(2:13,1).*S(2:13,2));...
            Gs6*fipHPGR(2)-Gs5*p(2,2)+yy(1)*b(2,1)*S(1,2)-yy(2)*sum(b(3:13,2).*S(3:13,2));...
            Gs6*fipHPGR(3)-Gs5*p(3,2)+yy(1)*b(3,1)*S(1,2)+yy(2)*b(3,2)*S(2,2)-yy(3)*sum(b(4:13,3).*S(4:13,2));...
            Gs6*fipHPGR(4)-Gs5*p(4,2)+yy(1)*b(4,1)*S(1,2)+yy(2)*b(4,2)*S(2,2)+yy(3)*b(4,3)*S(3,2)-yy(4)*sum(b(5:13,4).*S(5:13,2));...
            Gs6*fipHPGR(5)-Gs5*p(5,2)+yy(1)*b(5,1)*S(1,2)+yy(2)*b(5,2)*S(2,2)+yy(3)*b(5,3)*S(3,2)+yy(4)*b(5,4)*S(4,2)-yy(5)*sum(b(6:13,5).*S(6:13,2));...
            Gs6*fipHPGR(6)-Gs5*p(6,2)+yy(1)*b(6,1)*S(1,2)+yy(2)*b(6,2)*S(2,2)+yy(3)*b(6,3)*S(3,2)+yy(4)*b(6,4)*S(4,2)+yy(5)*b(6,5)*S(5,2)-yy(6)*sum(b(7:13,6).*S(7:13,2));...
            Gs6*fipHPGR(7)-Gs5*p(7,2)+yy(1)*b(7,1)*S(1,2)+yy(2)*b(7,2)*S(2,2)+yy(3)*b(7,3)*S(3,2)+yy(4)*b(7,4)*S(4,2)+yy(5)*b(7,5)*S(5,2)+yy(6)*b(7,6)*S(6,2)-yy(7)*sum(b(8:13,7).*S(8:13,2));...
            Gs6*fipHPGR(8)-Gs5*p(8,2)+yy(1)*b(8,1)*S(1,2)+yy(2)*b(8,2)*S(2,2)+yy(3)*b(8,3)*S(3,2)+yy(4)*b(8,4)*S(4,2)+yy(5)*b(8,5)*S(5,2)+yy(6)*b(8,6)*S(6,2)+yy(7)*b(8,7)*S(7,2)-yy(8)*sum(b(9:13,8).*S(9:13,2));...
            Gs6*fipHPGR(9)-Gs5*p(9,2)+yy(1)*b(9,1)*S(1,2)+yy(2)*b(9,2)*S(2,2)+yy(3)*b(9,3)*S(3,2)+yy(4)*b(9,4)*S(4,2)+yy(5)*b(9,5)*S(5,2)+yy(6)*b(9,6)*S(6,2)+yy(7)*b(9,7)*S(7,2)+yy(8)*b(9,8)*S(8,2)-yy(9)*sum(b(10:13,9).*S(10:13,2));...
            Gs6*fipHPGR(10)-Gs5*p(10,2)+yy(1)*b(10,1)*S(1,2)+yy(2)*b(10,2)*S(2,2)+yy(3)*b(10,3)*S(3,2)+yy(4)*b(10,4)*S(4,2)+yy(5)*b(10,5)*S(5,2)+yy(6)*b(10,6)*S(6,2)+yy(7)*b(10,7)*S(7,2)+yy(8)*b(10,8)*S(8,2)+yy(9)*b(10,9)*S(9,2)-yy(10)*sum(b(11:13,10).*S(11:13,2));...
            Gs6*fipHPGR(11)-Gs5*p(11,2)+yy(1)*b(11,1)*S(1,2)+yy(2)*b(11,2)*S(2,2)+yy(3)*b(11,3)*S(3,2)+yy(4)*b(11,4)*S(4,2)+yy(5)*b(11,5)*S(5,2)+yy(6)*b(11,6)*S(6,2)+yy(7)*b(11,7)*S(7,2)+yy(8)*b(11,8)*S(8,2)+yy(9)*b(11,9)*S(9,2)+yy(10)*b(11,10)*S(10,2)-yy(11)*sum(b(12:13,11).*S(12:13,2));...
            Gs6*fipHPGR(12)-Gs5*p(12,2)+yy(1)*b(12,1)*S(1,2)+yy(2)*b(12,2)*S(2,2)+yy(3)*b(12,3)*S(3,2)+yy(4)*b(12,4)*S(4,2)+yy(5)*b(12,5)*S(5,2)+yy(6)*b(12,6)*S(6,2)+yy(7)*b(12,7)*S(7,2)+yy(8)*b(12,8)*S(8,2)+yy(9)*b(12,9)*S(9,2)+yy(10)*b(12,10)*S(10,2)+yy(11)*b(12,11)*S(11,2)-yy(12)*sum(b(13,12)*S(13,2));...
            Gs6*fipHPGR(13)-Gs5*p(13,2)+yy(1)*b(13,1)*S(1,2)+yy(2)*b(13,2)*S(2,2)+yy(3)*b(13,3)*S(3,2)+yy(4)*b(13,4)*S(4,2)+yy(5)*b(13,5)*S(5,2)+yy(6)*b(13,6)*S(6,2)+yy(7)*b(13,7)*S(7,2)+yy(8)*b(13,8)*S(8,2)+yy(9)*b(13,9)*S(9,2)+yy(10)*b(13,10)*S(10,2)+yy(11)*b(13,11)*S(11,2)+yy(12)*b(13,12)*S(12,2)+0*yy(13)];   
        
fg3 = @(t3,zz) [Gs6*fipHPGR(1)-Gs5*p(1,3)-zz(1)*sum(b(2:13,1).*S(2:13,3));...
            Gs6*fipHPGR(2)-Gs5*p(2,3)+zz(1)*b(2,1)*S(1,3)-zz(2)*sum(b(3:13,2).*S(3:13,3));...
            Gs6*fipHPGR(3)-Gs5*p(3,3)+zz(1)*b(3,1)*S(1,3)+zz(2)*b(3,3)*S(2,3)-zz(3)*sum(b(4:13,3).*S(4:13,3));...
            Gs6*fipHPGR(4)-Gs5*p(4,3)+zz(1)*b(4,1)*S(1,3)+zz(2)*b(4,3)*S(2,3)+zz(3)*b(4,3)*S(3,3)-zz(4)*sum(b(5:13,4).*S(5:13,3));...
            Gs6*fipHPGR(5)-Gs5*p(5,3)+zz(1)*b(5,1)*S(1,3)+zz(2)*b(5,3)*S(2,3)+zz(3)*b(5,3)*S(3,3)+zz(4)*b(5,4)*S(4,3)-zz(5)*sum(b(6:13,5).*S(6:13,3));...
            Gs6*fipHPGR(6)-Gs5*p(6,3)+zz(1)*b(6,1)*S(1,3)+zz(2)*b(6,3)*S(2,3)+zz(3)*b(6,3)*S(3,3)+zz(4)*b(6,4)*S(4,3)+zz(5)*b(6,5)*S(5,3)-zz(6)*sum(b(7:13,6).*S(7:13,3));...
            Gs6*fipHPGR(7)-Gs5*p(7,3)+zz(1)*b(7,1)*S(1,3)+zz(2)*b(7,3)*S(2,3)+zz(3)*b(7,3)*S(3,3)+zz(4)*b(7,4)*S(4,3)+zz(5)*b(7,5)*S(5,3)+zz(6)*b(7,6)*S(6,3)-zz(7)*sum(b(8:13,7).*S(8:13,3));...
            Gs6*fipHPGR(8)-Gs5*p(8,3)+zz(1)*b(8,1)*S(1,3)+zz(2)*b(8,3)*S(2,3)+zz(3)*b(8,3)*S(3,3)+zz(4)*b(8,4)*S(4,3)+zz(5)*b(8,5)*S(5,3)+zz(6)*b(8,6)*S(6,3)+zz(7)*b(8,7)*S(7,3)-zz(8)*sum(b(9:13,8).*S(9:13,3));...
            Gs6*fipHPGR(9)-Gs5*p(9,3)+zz(1)*b(9,1)*S(1,3)+zz(2)*b(9,3)*S(2,3)+zz(3)*b(9,3)*S(3,3)+zz(4)*b(9,4)*S(4,3)+zz(5)*b(9,5)*S(5,3)+zz(6)*b(9,6)*S(6,3)+zz(7)*b(9,7)*S(7,3)+zz(8)*b(9,8)*S(8,3)-zz(9)*sum(b(10:13,9).*S(10:13,3));...
            Gs6*fipHPGR(10)-Gs5*p(10,3)+zz(1)*b(10,1)*S(1,3)+zz(2)*b(10,3)*S(2,3)+zz(3)*b(10,3)*S(3,3)+zz(4)*b(10,4)*S(4,3)+zz(5)*b(10,5)*S(5,3)+zz(6)*b(10,6)*S(6,3)+zz(7)*b(10,7)*S(7,3)+zz(8)*b(10,8)*S(8,3)+zz(9)*b(10,9)*S(9,3)-zz(10)*sum(b(11:13,10).*S(11:13,3));...
            Gs6*fipHPGR(11)-Gs5*p(11,3)+zz(1)*b(11,1)*S(1,3)+zz(2)*b(11,3)*S(2,2)+zz(3)*b(11,3)*S(3,3)+zz(4)*b(11,4)*S(4,3)+zz(5)*b(11,5)*S(5,3)+zz(6)*b(11,6)*S(6,3)+zz(7)*b(11,7)*S(7,3)+zz(8)*b(11,8)*S(8,3)+zz(9)*b(11,9)*S(9,3)+zz(10)*b(11,10)*S(10,3)-zz(11)*sum(b(12:13,11).*S(12:13,3));...
            Gs6*fipHPGR(12)-Gs5*p(12,3)+zz(1)*b(12,1)*S(1,3)+zz(2)*b(12,3)*S(2,3)+zz(3)*b(12,3)*S(3,3)+zz(4)*b(12,4)*S(4,3)+zz(5)*b(12,5)*S(5,3)+zz(6)*b(12,6)*S(6,3)+zz(7)*b(12,7)*S(7,3)+zz(8)*b(12,8)*S(8,3)+zz(9)*b(12,9)*S(9,3)+zz(10)*b(12,10)*S(10,3)+zz(11)*b(12,11)*S(11,3)-zz(12)*sum(b(13,12)*S(13,3));...
            Gs6*fipHPGR(13)-Gs5*p(13,3)+zz(1)*b(13,1)*S(1,3)+zz(2)*b(13,3)*S(2,3)+zz(3)*b(13,3)*S(3,3)+zz(4)*b(13,4)*S(4,3)+zz(5)*b(13,5)*S(5,3)+zz(6)*b(13,6)*S(6,3)+zz(7)*b(13,7)*S(7,3)+zz(8)*b(13,8)*S(8,3)+zz(9)*b(13,9)*S(9,3)+zz(10)*b(13,10)*S(10,3)+zz(11)*b(13,11)*S(11,3)+zz(12)*b(13,12)*S(12,3)+0*zz(13)];
        
fg4 = @(t4,ww) [Gs6*fipHPGR(1)-Gs5*p(1,4)-ww(1)*sum(b(2:13,1).*S(2:13,4));...
            Gs6*fipHPGR(2)-Gs5*p(2,4)+ww(1)*b(2,1)*S(1,4)-ww(2)*sum(b(3:13,2).*S(3:13,4));...
            Gs6*fipHPGR(3)-Gs5*p(3,4)+ww(1)*b(3,1)*S(1,4)+ww(2)*b(3,3)*S(2,4)-ww(3)*sum(b(4:13,3).*S(4:13,4));...
            Gs6*fipHPGR(4)-Gs5*p(4,4)+ww(1)*b(4,1)*S(1,4)+ww(2)*b(4,3)*S(2,4)+ww(3)*b(4,3)*S(3,4)-ww(4)*sum(b(5:13,4).*S(5:13,4));...
            Gs6*fipHPGR(5)-Gs5*p(5,4)+ww(1)*b(5,1)*S(1,4)+ww(2)*b(5,3)*S(2,4)+ww(3)*b(5,3)*S(3,4)+ww(4)*b(5,4)*S(4,4)-ww(5)*sum(b(6:13,5).*S(6:13,4));...
            Gs6*fipHPGR(6)-Gs5*p(6,4)+ww(1)*b(6,1)*S(1,4)+ww(2)*b(6,3)*S(2,4)+ww(3)*b(6,3)*S(3,4)+ww(4)*b(6,4)*S(4,4)+ww(5)*b(6,5)*S(5,4)-ww(6)*sum(b(7:13,6).*S(7:13,4));...
            Gs6*fipHPGR(7)-Gs5*p(7,4)+ww(1)*b(7,1)*S(1,4)+ww(2)*b(7,3)*S(2,4)+ww(3)*b(7,3)*S(3,4)+ww(4)*b(7,4)*S(4,4)+ww(5)*b(7,5)*S(5,4)+ww(6)*b(7,6)*S(6,4)-ww(7)*sum(b(8:13,7).*S(8:13,4));...
            Gs6*fipHPGR(8)-Gs5*p(8,4)+ww(1)*b(8,1)*S(1,4)+ww(2)*b(8,3)*S(2,4)+ww(3)*b(8,3)*S(3,4)+ww(4)*b(8,4)*S(4,4)+ww(5)*b(8,5)*S(5,4)+ww(6)*b(8,6)*S(6,4)+ww(7)*b(8,7)*S(7,4)-ww(8)*sum(b(9:13,8).*S(9:13,4));...
            Gs6*fipHPGR(9)-Gs5*p(9,4)+ww(1)*b(9,1)*S(1,4)+ww(2)*b(9,3)*S(2,4)+ww(3)*b(9,3)*S(3,4)+ww(4)*b(9,4)*S(4,4)+ww(5)*b(9,5)*S(5,4)+ww(6)*b(9,6)*S(6,4)+ww(7)*b(9,7)*S(7,4)+ww(8)*b(9,8)*S(8,4)-ww(9)*sum(b(10:13,9).*S(10:13,4));...
            Gs6*fipHPGR(10)-Gs5*p(10,4)+ww(1)*b(10,1)*S(1,4)+ww(2)*b(10,3)*S(2,4)+ww(3)*b(10,3)*S(3,4)+ww(4)*b(10,4)*S(4,4)+ww(5)*b(10,5)*S(5,4)+ww(6)*b(10,6)*S(6,4)+ww(7)*b(10,7)*S(7,4)+ww(8)*b(10,8)*S(8,4)+ww(9)*b(10,9)*S(9,4)-ww(10)*sum(b(11:13,10).*S(11:13,4));...
            Gs6*fipHPGR(11)-Gs5*p(11,4)+ww(1)*b(11,1)*S(1,4)+ww(2)*b(11,3)*S(2,4)+ww(3)*b(11,3)*S(3,4)+ww(4)*b(11,4)*S(4,4)+ww(5)*b(11,5)*S(5,4)+ww(6)*b(11,6)*S(6,4)+ww(7)*b(11,7)*S(7,4)+ww(8)*b(11,8)*S(8,4)+ww(9)*b(11,9)*S(9,4)+ww(10)*b(11,10)*S(10,4)-ww(11)*sum(b(12:13,11).*S(12:13,4));...
            Gs6*fipHPGR(12)-Gs5*p(12,4)+ww(1)*b(12,1)*S(1,4)+ww(2)*b(12,3)*S(2,4)+ww(3)*b(12,3)*S(3,4)+ww(4)*b(12,4)*S(4,4)+ww(5)*b(12,5)*S(5,4)+ww(6)*b(12,6)*S(6,4)+ww(7)*b(12,7)*S(7,4)+ww(8)*b(12,8)*S(8,4)+ww(9)*b(12,9)*S(9,4)+ww(10)*b(12,10)*S(10,4)+ww(11)*b(12,11)*S(11,4)-ww(12)*sum(b(13,12)*S(13,4));...
            Gs6*fipHPGR(13)-Gs5*p(13,4)+ww(1)*b(13,1)*S(1,4)+ww(2)*b(13,3)*S(2,4)+ww(3)*b(13,3)*S(3,4)+ww(4)*b(13,4)*S(4,4)+ww(5)*b(13,5)*S(5,4)+ww(6)*b(13,6)*S(6,4)+ww(7)*b(13,7)*S(7,4)+ww(8)*b(13,8)*S(8,4)+ww(9)*b(13,9)*S(9,4)+ww(10)*b(13,10)*S(10,4)+ww(11)*b(13,11)*S(11,4)+ww(12)*b(13,12)*S(12,4)+0*ww(13)];

fg5 = @(t5,ff) [Gs6*fipHPGR(1)-Gs5*p(1,5)-ff(1)*sum(b(2:13,1).*S(2:13,5));...
            Gs6*fipHPGR(2)-Gs5*p(2,5)+ff(1)*b(2,1)*S(1,5)-ff(2)*sum(b(3:13,2).*S(3:13,5));...
            Gs6*fipHPGR(3)-Gs5*p(3,5)+ff(1)*b(3,1)*S(1,5)+ff(2)*b(3,3)*S(2,5)-ff(3)*sum(b(4:13,3).*S(4:13,5));...
            Gs6*fipHPGR(4)-Gs5*p(4,5)+ff(1)*b(4,1)*S(1,5)+ff(2)*b(4,3)*S(2,5)+ff(3)*b(4,3)*S(3,5)-ff(4)*sum(b(5:13,4).*S(5:13,5));...
            Gs6*fipHPGR(5)-Gs5*p(5,5)+ff(1)*b(5,1)*S(1,5)+ff(2)*b(5,3)*S(2,5)+ff(3)*b(5,3)*S(3,5)+ff(4)*b(5,4)*S(4,5)-ff(5)*sum(b(6:13,5).*S(6:13,5));...
            Gs6*fipHPGR(6)-Gs5*p(6,5)+ff(1)*b(6,1)*S(1,5)+ff(2)*b(6,3)*S(2,5)+ff(3)*b(6,3)*S(3,5)+ff(4)*b(6,4)*S(4,5)+ff(5)*b(6,5)*S(5,5)-ff(6)*sum(b(7:13,6).*S(7:13,5));...
            Gs6*fipHPGR(7)-Gs5*p(7,5)+ff(1)*b(7,1)*S(1,5)+ff(2)*b(7,3)*S(2,5)+ff(3)*b(7,3)*S(3,5)+ff(4)*b(7,4)*S(4,5)+ff(5)*b(7,5)*S(5,5)+ff(6)*b(7,6)*S(6,5)-ff(7)*sum(b(8:13,7).*S(8:13,5));...
            Gs6*fipHPGR(8)-Gs5*p(8,5)+ff(1)*b(8,1)*S(1,5)+ff(2)*b(8,3)*S(2,5)+ff(3)*b(8,3)*S(3,5)+ff(4)*b(8,4)*S(4,5)+ff(5)*b(8,5)*S(5,5)+ff(6)*b(8,6)*S(6,5)+ff(7)*b(8,7)*S(7,5)-ff(8)*sum(b(9:13,8).*S(9:13,5));...
            Gs6*fipHPGR(9)-Gs5*p(9,5)+ff(1)*b(9,1)*S(1,5)+ff(2)*b(9,3)*S(2,5)+ff(3)*b(9,3)*S(3,5)+ff(4)*b(9,4)*S(4,5)+ff(5)*b(9,5)*S(5,5)+ff(6)*b(9,6)*S(6,5)+ff(7)*b(9,7)*S(7,5)+ff(8)*b(9,8)*S(8,5)-ff(9)*sum(b(10:13,9).*S(10:13,5));...
            Gs6*fipHPGR(10)-Gs5*p(10,5)+ff(1)*b(10,1)*S(1,5)+ff(2)*b(10,3)*S(2,5)+ff(3)*b(10,3)*S(3,5)+ff(4)*b(10,4)*S(4,5)+ff(5)*b(10,5)*S(5,5)+ff(6)*b(10,6)*S(6,5)+ff(7)*b(10,7)*S(7,5)+ff(8)*b(10,8)*S(8,5)+ff(9)*b(10,9)*S(9,5)-ff(10)*sum(b(11:13,10).*S(11:13,5));...
            Gs6*fipHPGR(11)-Gs5*p(11,5)+ff(1)*b(11,1)*S(1,5)+ff(2)*b(11,3)*S(2,5)+ff(3)*b(11,3)*S(3,5)+ff(4)*b(11,4)*S(4,5)+ff(5)*b(11,5)*S(5,5)+ff(6)*b(11,6)*S(6,5)+ff(7)*b(11,7)*S(7,5)+ff(8)*b(11,8)*S(8,5)+ff(9)*b(11,9)*S(9,5)+ff(10)*b(11,10)*S(10,5)-ff(11)*sum(b(12:13,11).*S(12:13,5));...
            Gs6*fipHPGR(12)-Gs5*p(12,5)+ff(1)*b(12,1)*S(1,5)+ff(2)*b(12,3)*S(2,5)+ff(3)*b(12,3)*S(3,5)+ff(4)*b(12,4)*S(4,5)+ff(5)*b(12,5)*S(5,5)+ff(6)*b(12,6)*S(6,5)+ff(7)*b(12,7)*S(7,5)+ff(8)*b(12,8)*S(8,5)+ff(9)*b(12,9)*S(9,5)+ff(10)*b(12,10)*S(10,5)+ff(11)*b(12,11)*S(11,5)-ff(12)*sum(b(13,12)*S(13,5));...
            Gs6*fipHPGR(13)-Gs5*p(13,5)+ff(1)*b(13,1)*S(1,5)+ff(2)*b(13,3)*S(2,5)+ff(3)*b(13,3)*S(3,5)+ff(4)*b(13,4)*S(4,5)+ff(5)*b(13,5)*S(5,5)+ff(6)*b(13,6)*S(6,5)+ff(7)*b(13,7)*S(7,5)+ff(8)*b(13,8)*S(8,5)+ff(9)*b(13,9)*S(9,5)+ff(10)*b(13,10)*S(10,5)+ff(11)*b(13,11)*S(11,5)+ff(12)*b(13,12)*S(12,5)+0*ff(13)];
        
[t1,xx] = ode23(fg1,tspan,x0);
[t2,yy] = ode23(fg2,tspan,x0);
[t3,zz] = ode23(fg3,tspan,x0);
[t4,ww] = ode23(fg4,tspan,x0);
[t5,ff] = ode23(fg5,tspan,x0);
subplot(2,3,1);
plot(t1,xx)
title('Bloque 1')
subplot(2,3,2);
plot(t2,yy)
title('Bloque 2')
subplot(2,3,3);
plot(t3,zz)
title('Bloque 3')
subplot(2,3,4);
plot(t4,ww)
title('Bloque 4')
subplot(2,3,5);
plot(t5,ff)
title('Bloque 5')
legend('m1','m2','m3','m4','m5','m6','m7','m8','m9','m10','m11','m12','m13','Location','northoutside','Orientation','horizontal')
subplot(2,3,6)
loglog(Xtc,fptHPGRu,'-*',Xtc,fpeHPGRu,'-*',Xtc,fpcHPGRu,'-s')
grid on
end
