function [exectime, data] = estandar_code(segment, data)

switch segment
    case 1
  %% lectura de entradas 
        data.uk = ttAnalogIn(1);              % muetreo estado de la Planta
        data.y = ttAnalogIn(2);            % salida anterior de la planta
%% Calculo de Tiempos      
        
 
        sys = ss(data.A, data.B , data.C , data.D);% espacio de estados
        sys_d = c2d(sys , data.h );
        
        data.x = sys_d.a * data.x + sys_d.b*data.uk;

        data.u = data.C*data.x;
        
        exectime=data.exectime;
        
    case 2
   %% EScritura en el puerto de Salida
        ttAnalogOut(1, data.u);
        ttAnalogOut(2, data.x(1,1));
        ttAnalogOut(3, data.x(2,1));
        
        
        exectime = -1;
end