
%% Diseno del Controlador
clear all , close all , clc
global A B C D
h = 0.05; % periodo de muestreo

% A = [ 0 -23.8095 ; 0 0 ] ;  % matris A
% B = [ 0 ; -23.8095];        % matris B
% C = [1 0 ] ;                % matris C
% D = 0;

A = [0 1 ; -918.27 -90.90];   % matris de transicion de estado
B = [0;918.27];               % matris de trancision de control
C = [1 0];                    % matris de salida
D = 0;
sys = ss(A, B , C , D);% espacio de estados

sys_d = c2d(sys , h );

%% diseno optimo

Q = [2 0; 0 0.5 ] ;
R = 0.01;
[K, S , e ] = lqrd(A, B , Q, R , h ) ;

%% Simulacion con condiciones iniciales
tm = 5;      % tiempo maximo
x = [ 1 ; -1]; % condiciones iniciales

%% Buffers
history_x = [];
history_x = [ history_x x ];
history_u = [];
history_u = [ history_u 0];
time=[]
u = -K*x;
for i=0:h:tm
    x = sys_d.a * x + sys_d.b*2.4 ;
    y = sys_d.c * x ;
    %actualizacion de buffers
    history_x = [ history_x x ];
    history_u = [ history_u u ];
    time=[time h];
    u = C*x;
end

time = 0:h:tm + h ;
figure
plot( time , history_x(1, :), time, history_x(2 , :), time, history_u( : ));
xlabel('Time [s]');
ylabel('x, u');
legend('x[1]', 'x[2]', 'u');

