function [exectime, data] = one_shot_code(segment, data)

switch segment
    case 1
  %% lectura de entradas 
        data.uk = ttAnalogIn(1);              % muetreo estado de la Planta
        data.y = ttAnalogIn(2);            % salida anterior de la planta
        
        
  %% Llamada a la senal de control  
        [data] = control(data);%  Tarea de control
        exectime=data.exectime;
        
    case 2
   %% EScritura en el puerto de Salida
        ttAnalogOut(1, data.u);
        ttAnalogOut(2, data.X(1,1))
        ttAnalogOut(3, data.X(2,1))
        %data.u_an = data.u;                   % memoria
        
        exectime = -1;
end