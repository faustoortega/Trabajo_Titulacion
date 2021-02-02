function [u] = control(data,t)
%% Espacio de Estados
sys = ss(data.A,data.B,data.C,data.D);

%% Matrices en K
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(sys.A,sys.B,t);

%% Ubicacion de los polos
%**************************************************************************
%Ackerman
pole1 = -1.5 + 1.5j; % polo 1 en tiempo continuo
pole2 = -1.5 - 1.5j; % polo 2 en tiempo continuo

% pole1 = -103.93 + 87.1j; % polo 1 en tiempo continuo
% pole2 = -103.93 - 87.1j; % polo 2 en tiempo continuo

z1 = exp(pole1*t); % polo 1 en tiempo discreto
z2 = exp(pole2*t); % polo 2 en tiempo discreto

L = acker(fi,T,[z1 z2])
%**************************************************************************
%LQR
Q = [10 0; 0 10];

%L = dlqr(fi,T,Q,0.001,0)

%% ONE-SHOT KALMAN
%% Actualizacion de tiempos
% estimacion a priori des estado del sistema
data.X = (fi * data.X) + ( T * data.uk);
% estimacion a priori de la covarianza
data.P = (fi * data.P * fi') + data.Q;

%% Actualizacion de medicion
% Ganancia de Kalman
data.K= ( data.P * data.C' ) / ( ( data.C * data.P * data.C' ) + data.R);
% estimacion del estado a posteriori
data.X = data.X + data.K*(data.y - ( data.C * data.X) );
% estimacion a posteriori de el error de covarianza
data.P = (eye(2) - data.K*data.C)*data.P;
% calculo de la señal de salida
u = -L * data.X; 

end

