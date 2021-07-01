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
data.y = 0;         % Salida Anterior
data.u_an = 0;         % señal de control anterior
data.tk_tau=0;         % tiempo entre muestras
%% Matrices de la Dinamica del Sistema
data.A = [0 1 ; -918.27 -90.90];   % matris de transicion de estado
data.B = [0;918.27];               % matris de trancision de control
data.C = [1 0];                    % matris de salida
data.D = 0;


%% Datos Kalman Filter
data.Q = 2e-7;      %Covarianza del ruido del poceso
data.R = 8e-5;      % Covarianza del ruido en la medicion
data.P = 1e6;
data.K = 0;
data.X = [0 ; 0];

%% creacion de tarea periodica
ttCreatePeriodicTask('ctrl_task', starttime, period, 'one_shot_code', data)

