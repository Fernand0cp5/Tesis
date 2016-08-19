clc
clear all
close all
num=[1];
den=[1 2 0.5 1];
G=tf(num,den);
Y=step(G,50);
sim('Jose_Varela_mods3')
figure (2),plot(Datos(:,1),Datos(:,2));title('Ecuación Diferencial');xlabel('Tiempo[seg]');ylabel('Amplitud');
