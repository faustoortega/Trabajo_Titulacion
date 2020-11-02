function [ u] = task_control( xk, tau_k, u_an,y_an )

%% Matrices de la Dinamica del Sistema
A=[0 1 ; -918.27 -90.90];   % matris de transicion de estado
B=[0;918.27];               % matris de trancision de control
C=[1 0];                    % matris de salida
D = 0;
%% Ubicacion de los polos
p = [-42+42*i -42-42*i]; 
 
L = acker(A,B,p);

%% Tarea de Control
xk_vec = [xk;u_an];
[fi, T ]= c2d(A,B,tau_k);
X_k_tao = (fi * xk_vec) + ( T * y_an);
u = L * X_k_tao;           % Calculo de la Señal de salida

end

