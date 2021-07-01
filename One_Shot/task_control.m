function [ data] = task_control( data, t )
%% Espacio de Estados
sys = ss(data.A,data.B,data.C,data.D);

%% ONE-SHOT KALMAN
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(sys.A,sys.B,t);

%% Ubicacion de los polos
%**************************************************************************
%Ackerman
% pole1 = -103.93 + 87j; % polo 1 en tiempo continuo
% pole2 = -103.93 - 87j; % polo 2 en tiempo continuo

pole1 = -1.5 + 1.5j; % polo 1 en tiempo continuo
pole2 = -1.5 - 1.5j; % polo 2 en tiempo continuo

z1 = exp(pole1*t); % polo 1 en tiempo discreto
z2 = exp(pole2*t); % polo 2 en tiempo discreto

L = acker(fi,T,[z1 z2]);

%% Tarea de Control

data.X = (fi * data.X) + ( T * data.uk);
data.u = -L * data.X;           % Calculo de la Señal de salida

end

