function [ u] = task_control( data, t )
%% Espacio de Estados
sys = ss(data.A,data.B,data.C,data.D);

%% ONE-SHOT KALMAN
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(sys.A,sys.B,t);

%% Ubicacion de los polos
%**************************************************************************
%Ackerman

pole1 = -103.93 + 87j; % polo 1 en tiempo continuo
pole2 = -103.93 - 87j; % polo 2 en tiempo continuo

z1 = exp(pole1*t); % polo 1 en tiempo discreto
z2 = exp(pole2*t); % polo 2 en tiempo discreto

L = acker(fi,T,[z1 z2]);

%**************************************************************************
%LQR
Q = [10 0; 0 10];
R = 0.0000001;
%L = dlqr(fi,T,Q,R);

%% Tarea de Control
xk = [data.xk; data.u_an];
[fi, T ] = c2d(sys.A, sys.B, t);
X_k_tao = (fi * xk) + ( T * data.y);
u = L * X_k_tao;           % Calculo de la Señal de salida

end

