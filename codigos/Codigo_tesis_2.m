clear all , close all , clc
global A B C D

A = [0 -23.8 ; 0 0];   % matris de transicion de estado
B = [0;-23.8];          % matris de trancision de control
C = [1 0];
D = 0

% A = [0 1 ; 0 0];   
% B = [0;1];         
% C = [1 0];
% D = 0
sys = ss(A,B,C,D);

%% Datos Kalman Filter
Q = 2e-7;      %Covarianza del ruido del poceso
R = 8e-5;      % Covarianza del ruido en la medicion
P = 1e6;
K = 0;
X = [0 ; 0];
%% Parametros senal de entrada   
uk=1;
Y = step(sys,1); %senal real
tm=5;             % tiempo maximo
h = 1e-3;         % periodo de muestreo
%% LQR
q = [1 0; 0 1] ;
r = 0.01;
%% Buffers
history_x = [];
history_x = [ history_x X ];
history_u = [];
history_u = [ history_u 0];
u_an=0
%% Bucle de lazo cerrado
for k=1:1:90
    
    Ys(k) = Y(k)+0.1*(0.2-rand); % senal con ruido

    %% Matrices discretas

    [fi, T ]= c2d(sys.A,sys.B,h);
   
    [L, S , e ] = lqrd(fi, T, q, r, h); %lqr
    
    %% Actualizacion de tiempos
    % estimacion a priori des estado del sistema
    X = (fi * X) + ( T * );
    % estimacion a priori de la covarianza
    P = (fi * P * fi') + Q;

    %% Actualizacion de medicion
    % Ganancia de Kalman
    K= ( P * C' ) / ( ( C * P * C' ) + R);
    % estimacion del estado a posteriori
 
    X = X + K*(u_an - ( C * X) );
    % estimacion a posteriori de el error de covarianza
    P = (eye(2) - K*C)*P;
    % calculo de la señal de salida
    u = -L * X
    history_x = [ history_x X ];
    history_u = [ history_u u ];
    u_an = u;
       
end

 figure
 plot( history_x( 1, :))%, history_x( 2 , :), history_u( : ));
