clc,clear all
Gs(1)=10;
Gs(2)=8;
Gs(3)=7;
Gs(4)=5;
Gs(5)=1;
Vel=2; %rad/s
angulo=.5;
dt=angulo/Vel;
m(1)=0;t(1)=0 ;
for i=2:100
M1=strcat('DM=',num2str((Gs(1)-Gs(2))*dt));
M10=strcat('M(0)=',num2str(m(i-1)));
M11=dsolve(M1,M10);
T(i)=i*dt;
t=T(i);
m(i)=subs(M11); 
end
plot(T,m)