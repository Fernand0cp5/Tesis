%Tolva de alimentacion
%TA: Tolva de Alimentaci�n, en donde confluyen el flujo de alimentaci�n
% de mineral desde chancado secundario, y el flujo de mineral rechazado por
% el Harnero (OS: sobretama�o).
%N� de tama�os de clases:
load('FrH.mat','FrH')
Fal = 35; %[ton/hora]
FrH = [FrH];
n = 13;
Fa = Fal*[0.0239 0.4001 0.2089 0.1090 0.0549 0.0441 0.0542 0.0374 0.0159 0.0085 0.0088 0.0085 0.0258];
%Variables de entrada:
%Flujo de alimentaci�n de mineral por tama�os, desde chancado secundario:
%Fa(i) en [ton(i)/hora]
% Fa(1) = x(1); %tama�o 45.000 [mm]
% Fa(2) = x(2); %tama�o 31.500 [mm]
% Fa(3) = x(3); %tama�o 22.400 [mm]
% Fa(4) = x(4); %tama�o 16.000 [mm]
% Fa(5) = x(5); %tama�o 11.200 [mm]
% Fa(6) = x(6); %tama�o 8.000 [mm]
% Fa(7) = x(7); %tama�o 5.600 [mm]
% Fa(8) = x(8); %tama�o 2.800 [mm]
% Fa(9) = x(9); %tama�o 1.000 [mm]
% Fa(10) = x(10); %tama�o 0.500 [mm]
% Fa(11) = x(11); %tama�o 0.315 [mm]
% Fa(12) = x(12); %tama�o 0.200 [mm]
% Fa(13) = x(13); %tama�o 0.125 [mm]

% %Flujo de alimentaci�n de mineral por tama�os, rechazado por el Harnero
% %(OS: sobretama�o): FrH(i) en [ton(i)/hora]
% FrH(1) = x(14); %tama�o 45.000 [mm]
% FrH(2) = x(15); %tama�o 31.500 [mm]
% FrH(3) = x(16); %tama�o 22.400 [mm]
% FrH(4) = x(17); %tama�o 16.000 [mm]
% FrH(5) = x(18); %tama�o 11.200 [mm]
% FrH(6) = x(19); %tama�o 8.000 [mm]
% FrH(7) = x(20); %tama�o 5.600 [mm]
% FrH(8) = x(21); %tama�o 2.800 [mm]
% FrH(9) = x(22); %tama�o 1.000 [mm]
% FrH(10) = x(23); %tama�o 0.500 [mm]
% FrH(11) = x(24); %tama�o 0.315 [mm]
% FrH(12) = x(25); %tama�o 0.200 [mm]
% FrH(13) = x(26); %tama�o 0.125 [mm]

%C�lculo del Flujo de alimentaci�n de mineral hacia HPGR por tama�os:
%FaHPGR(i) en [ton(i)/hora]
for i = 1:n;
FaHPGR(i) = Fa(i) + FrH(i);
end
[ TA ] = [ FaHPGR ]
