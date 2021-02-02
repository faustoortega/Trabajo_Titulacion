%% CONTROLLER DESIGN

clear all, close all, clc

global K
global A B C D
global Q R h
%s = tf('s');
%G = 1000/(s^2+s);

h = 100e-3; %sampling period
%num = 1000;
%den = [1 1 0];

%num = 1;
%den = [1 0 0];

%[A B C D] = tf2ss(num,den);
%A = [0 0; 1 0];
%B = [0; 1];
%C = [1 1];
%D = 0;
%sys = ss(A,B,C,D,h)

A = [0 -23.8095; 0 0];
B = [0; -23.8095];
C = [1 0; 0 1];
%C = [1 0];
D = [0];

sys = ss(A, B, C, D);
sys_d = c2d(sys, h);

pole1 = -15 + 10j; %poles in continous time
pole2 = -15 - 10j;

z1 = exp(pole1*h); %poles in discrete time
z2 = exp(pole2*h);

%% Design by Ackermann

 %K = acker(sys_d.a, sys_d.b, [z1 z2]); %controller design

%% Optimal design
%Q = [2 0; 0 0.5];
%R = 0.01;

Q = [1 0; 0 1];
R = 1;

[K,S,e] = lqrd(A,B,Q,R,h);

%K = [0.3951, -0.9728];

%% SIMULATION IN FRONT OF GIVEN CONDITIONS

% tTop = 0.5; %maximum time for simulation
% %tick = 0.0001; %granularity
%
% x = [1; -1]; %given initial conditions
%
% history_x = []; %buffer initialization
% %history = [history sys_d.c*x];
% history_x = [history_x x];
% history_u = [];
% history_u = [history_u 0];
%
% for i = 0 : h : tTop
%     u = -K*x; %applies[0.0001] control
%     x = sys_d.a*x+sys_d.b*u;
%     y = sys_d.c*x;
%     history_x = [history_x x]; %updates buffer
%     %history_y = [history y]; %updates buffer
%     history_u = [history_u u];
% end
%
% time = 0:h:tTop+h;
%
% figure
% plot(time, history_x(1,:), time, history_x(2,:), time, history_u(:));
% xlabel('Time [s]');
% ylabel('x, u');
% legend('x[1]','x[2]','u');
% %axis([0 tTop -1 1])

% %% With Kalman
% 
% Qn = 2e-7;
% Rn = 8e-3;
% %Rn = 8e-5;
% 
% Q = [Qn^2 0; 0 Qn^2];
% R = [Rn^2 0; 0 Rn^2];
% 
% %Sz=[pi/180*pi/180, 0; 0, 0.1*h*0.1*h];
% %Sw=[0,0;0,Qn*h*Qn*h];
% 
% meanValue = 0;
% 
% tTop = 100; %maximum time for simulation
% %tick = 0.0001; %granularity
% 
% x = [0; 0]; %given initial conditions
% xhat = [0; 0]; %initial state estimate
% P = zeros(2,2); %initial variance
% 
% u = 0;
% 
% % Initialize arrays for later plotting
% x1 = []; % true x1 state array
% x1hat = []; % estimated x1 array
% x1meas = []; % measured x1 array
% x2 = []; % true x2 array
% x2hat = []; % estimated x2 array
% x2meas = []; % measured x2 array
% ref = []; %reference
% r = 0;
% 
% for i = 0 : h : tTop
%     
%     if mod(i,50) == 0
%         r=~r;
%     end
%     
%     u = -K*[xhat(1)-r;xhat(2)];
%     %u = 0; %input
%     
%     % Simulate the linear system
%     ProcessNoise = sqrt(Qn)*randn + meanValue;
%     x = sys_d.A * x + sys_d.B * (u + ProcessNoise);
%     
%     % Simulate the noisy measurement
%     MeasNoise = sqrt(Rn)*randn(size(sys_d.C,1)) + meanValue;
%     y = sys_d.C * x + MeasNoise;
%     
%     % Extrapolate the most recent state estimate to the present time
%     
%     xhat = sys_d.A * xhat + sys_d.B * u;
%     
%     % Form the Innovation vector.
%     Inn = y - sys_d.C * xhat;
%     
%     % Compute the covariance of the Innovation
%     S = sys_d.C * P * sys_d.C' + R;
%     
%     % Form the Kalman Gain matrix.
%     Kal = sys_d.A * P * sys_d.C' * inv(S);
%     % Update the state estimate
%     xhat = xhat + Kal * Inn;
%     % Compute the covariance of the estimation error
%     P = sys_d.A * P * sys_d.A' - sys_d.A * P * sys_d.C' * inv(S) * sys_d.C * P *sys_d.A' + Q;
%     
%     % Save some parameters for plotting later
%     x1 = [x1; x(1)];
%     x1meas = [x1meas; y(1)];
%     x1hat = [x1hat; xhat(1)];
%     x2 = [x2; x(2)];
%     x2meas = [x2meas; y(2)];
%     x2hat = [x2hat; xhat(2)];
%     ref = [ref; r];
% end
% data.h = 10e-3;
% % Plot the results
% close all;
% t = 0 : h : tTop;
% subplot(2,2,1)
% plot(t,x1,t,x1meas,t,x1hat,t,ref,'linewidth',2);
% grid
% title('x1');
% xlabel('Time (sec)');
% legend('True','Measured','Estimated','Reference');
% 
% subplot(2,2,2)
% plot(t,x1-x1meas, t,x1-x1hat, 'linewidth',2);
% legend()
% grid;
% title('x1 error');
% xlabel('Time (sec)');
% legend('Measured', 'Estimated');
% 
% subplot(2,2,3)
% plot(t,x2, t,x2meas, t,x2hat,'linewidth',2);
% grid;
% title('x2');
% xlabel('Time (sec)');
% legend('True', 'Measured', 'Estimated');
% 
% subplot(2,2,4)
% plot(t,x2-x2meas, t,x2-x2hat, 'linewidth',2);
% grid;
% title('x2 error');
% xlabel('Time (sec)');
% legend('Measured', 'Estimated');
