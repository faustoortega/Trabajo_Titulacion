function [exectime, data] = one_shot_code(segment, data)

switch segment
    case 1
  %% lectura de entradas 
        data.xk = ttAnalogIn(1);              % muetreo estado de la Planta
        data.y_an = ttAnalogIn(2);            % salida anterior de la planta        
  %% Calculo de Tiempos      
        t_k = ttCurrentTime()                 % obtencion del tiempo de transcurrido
        data.tk_tau = data.tk_tau + data.h;   % proximo instante de actuacion
        tau = data.tk_tau - t_k;              % calculo tiempo entre la  muestra y la actuacion
  %% Llamada a la senal de control      
        %data.u = task_control(data.xk, tau, data.u_an, data.y_an);%  Tarea de control
	data.u = task_control(data,tau)%  Tarea de control

        exectime=0.01;        
    case 2
   %% EScritura en el puerto de Salida
        ttAnalogOut(1, data.u);
        data.u_an = data.u;     % memoria
        
        exectime = -1;
end
