function one_shot_init(Arg)

ttInitKernel('prioFP')
%% Datos Tarea Periodica
data.exectime = 0.1;   % control task execution time
starttime = 0.0;       % control task start time
period = 0.05;          % control task period
data.h = 0.05;          % periodo

%% Inicializacion Variables de Datos One-Shoot
data.u=0;              % señal de control
data.uk = 0;           % Señal de referencia       
data.y_an = 0;         % Salida Anterior
data.u_an = 0;         % señal de control anterior
data.tk_tau=0;         % tiempo entre muestras

%% Datos Kalman Filter
data.Q = 2e-10;      %Covarianza del ruido del poceso
data.R = 8e-10;      % Covarianza del ruido en la medicion
data.P_pos = 1e6;
data.xk=[0 ; 0];

%% creacion de tarea periodica
ttCreatePeriodicTask('ctrl_task', starttime, period, 'one_shot_code', data)

