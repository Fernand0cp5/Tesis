% *************************************************************************
% ********************* CONDICIONES INICIALES ****************************
% *************************************************************************

% a) Capacidad de tratamiento
     D   =  0.8;    % Diámetro de los rodillos: D en [m]
     L   =  0.25;   % Largo de los rodillos: L en [m]
     s0  =  0.019;  % Gap operacional: s0 en [m]
     U   =  0.67;   % Velocidad periférica de los rodillos: U en [m/s]
     Rp  =  41;     % Presion de operación: Rp en [bar]
     ros =  2.74;   % Densidad del sólido seco: ros en [t/m3]
     roa =  1.62;   % Densidad aparente de la alimentación: roa en [t/m3]
     
     sim('HPGR.mdl')
     
%      RES = [roe W Gs alfaIP P U L D Xc];
     Xc
% b) Prechandado
     n = 13;                %N° de tamaños de clases:
    %Fracción en peso de alimentación discreta al HPGR: f(i)aHPGR en
    %[ton(i)/tonT] (13 mallas)
     faHPGR(1) = 0.0239;    %fracción retenido discreto, tamaño 45.000 [mm]
     faHPGR(2) = 0.4001;    %fracción retenido discreto, tamaño 31.500 [mm]
     faHPGR(3) = 0.2089;    %fracción retenido discreto, tamaño 22.400 [mm]
     faHPGR(4) = 0.1090;    %fracción retenido discreto, tamaño 16.000 [mm]
     faHPGR(5) = 0.0549;    %fracción retenido discreto, tamaño 11.200 [mm]
     faHPGR(6) = 0.0441;    %fracción retenido discreto, tamaño 8.000 [mm]
     faHPGR(7) = 0.0542;    %fracción retenido discreto, tamaño 5.600 [mm]
     faHPGR(8) = 0.0374;    %fracción retenido discreto, tamaño 2.800 [mm]
     faHPGR(9) = 0.0159;    %fracción retenido discreto, tamaño 1.000 [mm]
     faHPGR(10) = 0.0085;   %fracción retenido discreto, tamaño 0.500 [mm]
     faHPGR(11) = 0.0088;   %fracción retenido discreto, tamaño 0.315 [mm]
     faHPGR(12) = 0.0085;   %fracción retenido discreto, tamaño 0.200 [mm]
     faHPGR(13) = 0.0258;   %fracción retenido discreto, tamaño 0.125 [mm]
    %Tamaños de clases de partícula: X(i) en [mm] (13 mallas)
     X(1) = 45;             %tamaño 45.000 [mm]
     X(2) = 31.5;           %tamaño 31.500 [mm]
     X(3) = 22.4;           %tamaño 22.400 [mm]
     X(4) = 16;             %tamaño 16.000 [mm]
     X(5) = 11.2;           %tamaño 11.200 [mm]
     X(6) = 8;              %tamaño 8.000 [mm]
     X(7) = 5.6;            %tamaño 5.600 [mm]
     X(8) = 2.8;            %tamaño 2.800 [mm]
     X(9) = 1;              %tamaño 1.000 [mm]
     X(10) = 0.5;           %tamaño 0.500 [mm]
     X(11) = 0.315;         %tamaño 0.315 [mm]
     X(12) = 0.2;           %tamaño 0.200 [mm]
     X(13) = 0.125;         %tamaño 0.125 [mm]

     sim('HPGR_2.mdl')
     
    
        [ SAL ] = [fipHPGR]
	     