function J=parametros(x)
P=40308.7;%[Watts];
%a(1)=87.74270966450217;
%a(2)=141.02326716924657;
%a(3)=71.42713711433252;
%a(4)=41.30545393133288;
%a(5)=25.211578789632288;
%a(6)=12.56261298696965;
%a(7)=2.0494511033461853;
%a(8)=0.6346520631643215;
%a(9)=0.4914977601068599;
%a(10)=0.4112346656234704;
a(11)=0.30931698697666116;
F(1)=(x(1)*exp(-x(2)/P))-a(11);
J=(F(1))^2;
end
