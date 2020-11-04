function [ u] = task_control( data, tau_k )
%% Espacio de Estados
sys = ss(data.A,data.B,data.C,data.D);

%% Ubicacion de los polos
p = [-42+42*i -42-42*i];  
L = acker(sys.A,sys.B,p);

%% Tarea de Control
xk_vec = [data.xk;data.u_an];
[fi, T ] = c2d(sys.A, sys.B, tau_k);
X_k_tao = (fi * xk_vec) + ( T * data.y_an);
u = L * X_k_tao;           % Calculo de la Señal de salida

end

