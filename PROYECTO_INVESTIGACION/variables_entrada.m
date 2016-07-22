% *************************************************************************
% ********************* CONDICIONES INICIALES ****************************
% *************************************************************************

% a) Capacidad de tratamiento
     D   =  0.8;    % Di�metro de los rodillos: D en [m]
     L   =  0.25;   % Largo de los rodillos: L en [m]
     s0  =  0.019;  % Gap operacional: s0 en [m]
     U   =  0.67;   % Velocidad perif�rica de los rodillos: U en [m/s]
     Rp  =  41;     % Presion de operaci�n: Rp en [bar]
     ros =  2.74;   % Densidad del s�lido seco: ros en [t/m3]
     roa =  1.62;   % Densidad aparente de la alimentaci�n: roa en [t/m3]
     
     sim('HPGR.mdl')
     
%      RES = [roe W Gs alfaIP P U L D Xc];
     Xc
% b) Prechandado
     n = 13;                %N� de tama�os de clases:
    %Fracci�n en peso de alimentaci�n discreta al HPGR: f(i)aHPGR en
    %[ton(i)/tonT] (13 mallas)
     faHPGR(1) = 0.0239;    %fracci�n retenido discreto, tama�o 45.000 [mm]
     faHPGR(2) = 0.4001;    %fracci�n retenido discreto, tama�o 31.500 [mm]
     faHPGR(3) = 0.2089;    %fracci�n retenido discreto, tama�o 22.400 [mm]
     faHPGR(4) = 0.1090;    %fracci�n retenido discreto, tama�o 16.000 [mm]
     faHPGR(5) = 0.0549;    %fracci�n retenido discreto, tama�o 11.200 [mm]
     faHPGR(6) = 0.0441;    %fracci�n retenido discreto, tama�o 8.000 [mm]
     faHPGR(7) = 0.0542;    %fracci�n retenido discreto, tama�o 5.600 [mm]
     faHPGR(8) = 0.0374;    %fracci�n retenido discreto, tama�o 2.800 [mm]
     faHPGR(9) = 0.0159;    %fracci�n retenido discreto, tama�o 1.000 [mm]
     faHPGR(10) = 0.0085;   %fracci�n retenido discreto, tama�o 0.500 [mm]
     faHPGR(11) = 0.0088;   %fracci�n retenido discreto, tama�o 0.315 [mm]
     faHPGR(12) = 0.0085;   %fracci�n retenido discreto, tama�o 0.200 [mm]
     faHPGR(13) = 0.0258;   %fracci�n retenido discreto, tama�o 0.125 [mm]
    %Tama�os de clases de part�cula: X(i) en [mm] (13 mallas)
     X(1) = 45;             %tama�o 45.000 [mm]
     X(2) = 31.5;           %tama�o 31.500 [mm]
     X(3) = 22.4;           %tama�o 22.400 [mm]
     X(4) = 16;             %tama�o 16.000 [mm]
     X(5) = 11.2;           %tama�o 11.200 [mm]
     X(6) = 8;              %tama�o 8.000 [mm]
     X(7) = 5.6;            %tama�o 5.600 [mm]
     X(8) = 2.8;            %tama�o 2.800 [mm]
     X(9) = 1;              %tama�o 1.000 [mm]
     X(10) = 0.5;           %tama�o 0.500 [mm]
     X(11) = 0.315;         %tama�o 0.315 [mm]
     X(12) = 0.2;           %tama�o 0.200 [mm]
     X(13) = 0.125;         %tama�o 0.125 [mm]

     sim('HPGR_2.mdl')
     
    
        [ SAL ] = [fipHPGR]
	     