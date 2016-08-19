% Volumen por bloque-------------
syms x
load('D.mat','D');
load('s0.mat','s0');
load ('h.mat','h');
load('L.mat','L');
load('Z.mat','Z');
% D=evalin('base','D');
% s0=evalin('base','s0');
% h=evalin('base','h');
% L=evalin('base','L');
% Z=evalin('base','Z');
a = 0;
bb = h;
in2 = (D/2+s0/2-sqrt((D/2)^2-x^2));
area1 = double(int(in2,'x',a,bb));
vol1 = (L*area1)*1E6;
[Resp] = [vol1]
save('vol1.mat','vol1')
%vol1 = (L*area1)*1E6;


