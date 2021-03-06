load('alfaIP.mat','alfaIP');
load('U.mat','U')
load('D.mat','D')
load('roe.mat','roe')
load('s0.mat','s0')
load('L.mat','L')
load('fipHPGR.mat','fipHPGR')
load('NB.mat','NB')
load('n.mat','n')
Z = (D/2)*sin(alfaIP*pi/180);
Gs6 = 3600*roe*s0*L*U
Hk = (1/NB)*Gs6*Z/(3600*U)
xs = [0 0.49 11.55 12.32 12.47 12.22 13.03 11.82 5.44 3.05 2.55 2.2 12.86]/100;
%velocidad espec�fica de fractura para cada tama�o en cada bloque: S(i,k)
for i = 1:n,
    for k = 1:NB,
        S(i,k) = (Ppb(k)/Hk)*SiE(i)/3600 %S(i,k) en [1/s]
    end
end
S = S*3600
for i=1:13;
    m(i) = Hk*fipHPGR(i)
end

syms b c d e f g h i j k l 
%m(1) = 0.000001
fa= [Gs6*fipHPGR(3)/NB-Gs6*xs(3)/NB+m(2)*b*S(2,1)-m(3)*(1*S(3,1)),...
     Gs6*fipHPGR(4)/NB-Gs6*xs(4)/NB+m(2)*c*S(2,1)+m(3)*b*S(3,1)-m(4)*(1*S(4,1)),...
     Gs6*fipHPGR(5)/NB-Gs6*xs(5)/NB+m(2)*d*S(2,1)+m(3)*c*S(3,1)+m(4)*b*S(4,1)-m(5)*(1*S(5,1)),...
     Gs6*fipHPGR(6)/NB-Gs6*xs(6)/NB+m(2)*e*S(2,1)+m(3)*d*S(3,1)+m(4)*c*S(4,1)+m(5)*b*S(5,1)-m(6)*(1*S(6,1)),...
     Gs6*fipHPGR(7)/NB-Gs6*xs(7)/NB+m(2)*f*S(2,1)+m(3)*e*S(3,1)+m(4)*d*S(4,1)+m(5)*c*S(5,1)+m(6)*b*S(6,1)-m(7)*(1*S(7,1)),...
     Gs6*fipHPGR(8)/NB-Gs6*xs(8)/NB+m(2)*g*S(2,1)+m(3)*f*S(3,1)+m(4)*e*S(4,1)+m(5)*d*S(5,1)+m(6)*c*S(6,1)+m(7)*b*S(7,1)-m(8)*(1*S(8,1)),...
     Gs6*fipHPGR(9)/NB-Gs6*xs(9)/NB+m(2)*h*S(2,1)+m(3)*g*S(3,1)+m(4)*f*S(4,1)+m(5)*e*S(5,1)+m(6)*d*S(6,1)+m(7)*c*S(7,1)+m(8)*b*S(8,1)-m(9)*(1*S(9,1)),...
     Gs6*fipHPGR(10)/NB-Gs6*xs(10)/NB+m(2)*i*S(2,1)+m(3)*h*S(3,1)+m(4)*g*S(4,1)+m(5)*f*S(5,1)+m(6)*e*S(6,1)+m(7)*d*S(7,1)+m(8)*c*S(8,1)+m(9)*b*S(9,1)-m(10)*(1*S(10,1)),...
     Gs6*fipHPGR(11)/NB-Gs6*xs(11)/NB+m(2)*j*S(2,1)+m(3)*i*S(3,1)+m(4)*h*S(4,1)+m(5)*g*S(5,1)+m(6)*f*S(6,1)+m(7)*e*S(7,1)+m(8)*d*S(8,1)+m(9)*c*S(9,1)+m(10)*b*S(10,1)-m(11)*(1*S(11,1)),...
     Gs6*fipHPGR(12)/NB-Gs6*xs(12)/NB+m(2)*k*S(2,1)+m(3)*j*S(3,1)+m(4)*i*S(4,1)+m(5)*h*S(5,1)+m(6)*g*S(6,1)+m(7)*f*S(7,1)+m(8)*e*S(8,1)+m(9)*d*S(9,1)+m(10)*c*S(10,1)+m(11)*b*S(11,1)-m(12)*(1*S(12,1))]
   
 Solu = solve(fa(1),fa(2),fa(3),fa(4),fa(5),fa(6),fa(7),fa(8),fa(9),fa(10))

bs = double(Solu.b)
cs = double(Solu.c)
ds = double(Solu.d)
es = double(Solu.e)
fs = double(Solu.f)
gs = double(Solu.g)
hs = double(Solu.h)
is = double(Solu.i)
js = double(Solu.j)
ks = double(Solu.k)

m1=1-(bs+cs+ds+es+fs+gs+hs+is+js+ks+ls);
m2=1-(bs+cs+ds+es+fs+gs+hs+is+js+ks);
m3=1-(bs+cs+ds+es+fs+gs+hs+is+js);
m4=1-(bs+cs+ds+es+fs+gs+hs+is);
m5=1-(bs+cs+ds+es+fs+gs+hs);
m6=1-(bs+cs+ds+es+fs+gs);
m7=1-(bs+cs+ds+es+fs);
m8=1-(bs+cs+ds+es);
m9=1-(bs+cs+ds);
m10=1-(bs+cs);
m11=1-bs;
m12=1;


bij =   [0  0  0  0  0  0  0  0  0  0   0   0  0;
         bs 0  0  0  0  0  0  0  0  0   0   0  0;
         cs bs 0  0  0  0  0  0  0  0   0   0  0;
         ds cs bs 0  0  0  0  0  0  0   0   0  0;
         es ds cs bs 0  0  0  0  0  0   0   0  0;
         fs es ds cs bs 0  0  0  0  0   0   0  0;
         gs fs es ds cs bs 0  0  0  0   0   0  0;
         hs gs fs es ds cs bs 0  0  0   0   0  0;
         is hs gs fs es ds cs bs 0  0   0   0  0;
         js is hs gs fs es ds cs bs 0   0   0  0;
         ks js is hs gs fs es ds cs bs  0   0  0;
         ls ks js is hs gs fs es ds cs  bs  0  0;
         m1 m2 m3 m4 m5 m6 m7 m8 m9 m10 m11 m12  0] 

save('bij.mat','bij')

% Gs6*fipHPGR(1)/NB-Gs6*xs(1)/NB-m(1)*((b+c+d+e+f+g+h+i+j+k+l+m1)*S(1,1)),...
% Gs6*fipHPGR(2)/NB-Gs6*xs(2)/NB+m(1)*b*S(1,1)-m(2)*((b+c+d+e+f+g+h+i+j+k+m2)*S(2,1)),...


%  Gs6*fipHPGR(12)/NB-Gs6*xs(12)/NB+m(1)*l*S(1,1)+m(2)*k*S(2,1)+m(3)*j*S(3,1)+m(4)*i*S(4,1)+m(5)*h*S(5,1)+m(6)*g*S(6,1)+m(7)*f*S(7,1)+m(8)*e*S(8,1)+m(9)*d*S(9,1)+m(10)*c*S(10,1)+m(11)*b*S(11,1)-m(12)*(m12*S(12,1)),...
%      
%  Gs6*fipHPGR(13)/NB-Gs6*xs(13)/NB+m(1)*m1*S(1,1)+m(2)*l*S(2,1)+m(3)*k*S(3,1)+m(4)*j*S(4,1)+m(5)*i*S(5,1)+m(6)*h*S(6,1)+m(7)*g*S(7,1)+m(8)*f*S(8,1)+m(9)*e*S(9,1)+m(10)*d*S(10,1)+m(11)*c*S(11,1)+m(12)*b*S(12,1)]













