function [exectime, data] = one_shot_code(segment, data)

switch segment
    case 1
  %% lectura de entradas 
        data.uk = ttAnalogIn(1);              % muetreo estado de la Planta
        data.y = ttAnalogIn(2);            % salida anterior de la planta        
  %% Calculo de Tiempos      
        t_k = ttCurrentTime()  ;               % obtencion del tiempo de transcurrido
        data.tk_tau = data.tk_tau + data.h ;  % proximo instante de actuacion
        tau = data.tk_tau - t_k ;             % calculo tiempo entre la  muestra y la actuacion
  %% Llamada a la senal de control      
	    data = task_control(data,tau)%  Tarea de control

        exectime=data.exectime;      
    case 2
   %% EScritura en el puerto de Salida
        ttAnalogOut(1, data.u);
        ttAnalogOut(2, data.X(1,1));
        ttAnalogOut(3, data.X(2,1));
        %data.u_an = data.u;     % memoria
        
        exectime = -1;
end
