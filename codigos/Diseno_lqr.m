clear all, close all, clc


A = [1 1; 0 1];
B = [0; 1];
C = [1 0];
D = 0;
%sampling time
ts = 1e-3;
%% state-space object

sys = ss(A,B,C,D,ts)

% open-loop eigenvalues

eigen_ol = eig(A)

%% natural response of the open-loop system

tHor = 10e-3;

x = [-3; 5];

u = 0;

x_History = x;
u_History = u;

for i=ts:ts:tHor
   x = A*x + B*u;
   x_History = [x_History x];
   u_History = [u_History u];
    
end

t = 0:ts:tHor;

plot(t,x_History(1,:),t,x_History(2,:),t,u_History);
grid on
legend('x_1','x_2','u')
title('Open-loop')

%% LQR problem

% weighting matrices

Q = [10 0;
     0 10];
 
R = [0.001];

N = 0;

% solution to LQR problem

[K, S, eigen_CL] = dlqr(A, B, Q, R, N)

K = -K

%% natural response of the closed-loop system

tHor = 50e-3;

x = [-3; 5];

u = 0;

x_History = x;
u_History = u;

for i=ts:ts:tHor
   u = K*x;
   x = A*x + B*u;
   x_History = [x_History x];
   u_History = [u_History u];
    
end

t = 0:ts:tHor;

figure(2)
plot(t,x_History(1,:),t,x_History(2,:),t,u_History);
grid on
legend('x_1','x_2','u')
title('Closed-loop')