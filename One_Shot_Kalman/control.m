function [u, P_pos, xk] = control(uk, t, u_an, y_an, Q, R, P_pos ,xk)

%% Matrices de la Dinamica del Sistema
A=[0 1 ; -918.27 -90.90];   % matris de transicion de estado
B=[0;918.27];               % matris de trancision de control
C=[1 0];                    % matris de salida

%% Ubicacion de los polos
p = [ 5+5*i -5-5*i];  
L = acker(A,B,p);

%% ONE-SHOT KALMAN
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(A,B,t);
%% Actualizacion de tiempos
% estimacion a priori des estado del sistema
X_k_pri = (fi * xk) + ( T * uk);
% estimacion a priori de la covarianza
P_k_pri = (fi * P_pos * fi') + Q;
%% Actualizacion de medicion
% Ganancia de Kalman
K= ( P_k_pri * C' ) / ( ( C * P_k_pri * C' ) + R);
% estimacion del estado a posteriori
X_k_pos = X_k_pri + K*(u_an - ( C*X_k_pri) );
% estimacion a posteriori de el error de covarianza
P_pos = (eye(2) - K*C)*P_k_pri;
% calculo de la señal de salida
u = -L * X_k_pos;   
% Actualizacion de valores
xk = X_k_pri;

end

