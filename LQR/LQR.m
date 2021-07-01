%% Matrices de la Dinamica del Sistema
A = [0 -23.8; 0 0];
B = [0; -23.8];
C = [1 0];
D = 0;

%% Espacio de Estados
sys = ss(A,B,C,D);

%% Matrices en K
ts = 0.05;
% calculo de las matrices de la dinamica del sistema en t
[fi, T ]= c2d(sys.A,sys.B,ts);

%% Valores
[Num, Den]=ss2tf(A,B,C,D)
G = tf(Num,Den)
G = G*G
rlocus(G)

%% LQR
Q = C'*C
R_t = 6.3e-5;
P = dare(fi,T,Q,R_t)
K = R*B'*P





