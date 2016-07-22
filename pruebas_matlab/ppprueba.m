%Modelo dinamico
clear x t x0
x0(1) = 0;
x0(2) = 0;
tf = 5;
tspan = [0 tf];
fg1 = @(t1,xx) [Gs2*fipHPGR(1)-Gs1*p(1,1)-xx(1)*3600*sum(b(2:13,1).*S(2:13,1));...
            Gs2*fipHPGR(2)-Gs1*p(2,1)+xx(1)*3600*b(2,1)*S(1,1)-xx(2)*3600*sum(b(3:13,2).*S(3:13,1))]
           
[t1,xx] = ode45(fg1,tspan,x0);
plot(t1,xx)
