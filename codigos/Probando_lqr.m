%% Matrices de la Dinamica del Sistema
A = [0 -23.8; 0 0];
B = [0; -23.8];
C = [1 0];
D = 0;

%% Espacio de Estados
sys = ss(A,B,C,D);

%% Matrices en K
ts = 5e-3;
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(sys.A,sys.B,ts);

%% LQR problem

% weighting matrices
Q = [10 0;0 10]; 
R = [0.001];
N = 0;
%Kalmaan
P = 1e6;
K = 0;
X = [0 ; 0];
uk=1;
u=[];
con=1;
u_an=0;
for i=ts:ts:ts*100
    
    % solution to LQR problem
    [fi, T ]= c2d(sys.A,sys.B,ts);
    L = dlqr(fi, T, Q, R, N)
    
    %% Actualizacion de tiempos
    % estimacion a priori des estado del sistema
    X = (fi * X) + ( T * uk);
    % estimacion a priori de la covarianza
    P = (fi * P * fi') + Q;

    %% Actualizacion de medicion
    % Ganancia de Kalman
    K= ( P * C' ) / ( ( C * P * C' ) + R);
    % estimacion del estado a posteriori
    X = X + K*(u_an - ( C * X) )
    % estimacion a posteriori de el error de covarianza
    P = (eye(2) - K*C)*P;
    % calculo de la señal de salida
    u(con) = -L * X;
    u_an = u;
    con=con+1;
    
end


