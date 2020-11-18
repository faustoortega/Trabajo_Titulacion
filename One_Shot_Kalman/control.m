function [u, P_pos, xk] = control(data,t)
%% Espacio de Estados
sys = ss(data.A,data.B,data.C,data.D);
%% Ubicacion de los polos
p = [ 5+5*i -5-5*i];  
L = acker(sys.A,sys.B,p);

%% ONE-SHOT KALMAN
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(sys.A,sys.B,t);

%% Actualizacion de tiempos
% estimacion a priori des estado del sistema
X_k_pri = (fi * data.xk) + ( T * data.uk);
% estimacion a priori de la covarianza
P_k_pri = (fi * data.P_pos * fi') + data.Q;

%% Actualizacion de medicion
% Ganancia de Kalman
K= ( P_k_pri * data.C' ) / ( ( data.C * P_k_pri * data.C' ) + data.R);
% estimacion del estado a posteriori
X_k_pos = X_k_pri + K*(data.u_an - ( data.C*X_k_pri) );
% estimacion a posteriori de el error de covarianza
P_pos = (eye(2) - K*data.C)*P_k_pri;
% calculo de la señal de salida
u = -L * X_k_pos;   
% Actualizacion de valores
xk = X_k_pri;

end

