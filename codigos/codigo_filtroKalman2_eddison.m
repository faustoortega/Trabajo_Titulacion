clear all;
close all;
time=(0:0.01:0.99)';
datos=[-20.2515;-21.0646;-21.7643;-22.3079;-22.6640;-22.8143;-22.7545;
    -22.4933;-22.0501;-21.4529;-20.7350;-19.9325;-19.0809;-18.2137;
    -17.3601;-16.5438;-15.7819;-15.0853;-14.4581;-13.8987;-13.4007;
    -12.9549;-12.5503;-12.1763;-11.8238;-11.4855;-11.1567;-10.8341;
    -10.5154;-10.1981;-9.8794;-9.5554;-9.2225;-8.8781;-8.5221;-8.1585;
    -7.7958;-7.4472;-7.1298;-6.86305;-6.6670;-6.5613;-6.5645;-6.6944;
    -6.9694;-7.4101;-8.0408;-8.8890;-9.9845;-11.3547;-13.0194;-14.9834;
    -17.2305;-19.7176;-22.37344;-25.1001;-27.7796;-30.2835;-32.4856;
    -34.2747;-35.5661;-36.3106;-36.4981;-36.1570;-35.3487;-34.1592;
    -32.6881;-31.0381;-29.3056;-27.5738;-25.9087;-24.3578;-22.9513;
    -21.7049;-20.6226;-19.6999;-18.9267;-18.2892;-17.7715;-17.3572;
    -17.0306;-16.7779;-16.5883;-16.4548;-16.3747;-16.3486;-16.3799;
    -16.4726;-16.6299;-16.8519;-17.1350;-17.4708;-17.8470;-18.2475;
    -18.6546;-19.0492;-19.4122;-19.7249;-19.9684;-20.1240];

%% Funcion de trasferencia
% Parametros de la planta
J=0.0037;
m=0.9715;
d=0.246;
k=0.5;
g=9.8;

% Parametros del motor
Kt=0.113;
Ke=0.0115;
R=13;
L=0.01;

% Representacion del sistema lineal en el espacio de estados
A = [0 1 0
    -(m*g*d)/(J+m*d^2) -k/(J+m*d^2) Kt/(J+m*d^2)
    0 -Ke/L -R/L];
B = [0 ; 0 ; 1/L];
C = [1 0 0];
D = [0];

sys = ss(A,B,C,D);
%% respuesta a step
[datos1,tiempo]=step(sys,5);

%% Datos Kalman Filter
Q = 0.005;      %Covarianza del ruido del poceso
R = 0.005;      % Covarianza del ruido en la medicion
P = 1e6;
K = 0;
X = [0 ; 0; 0];
%% Parametros senal de entrada   
u = zeros(1,length(datos1));
h=0.01;
Ys=Q(1);
uk=1

x_History = X;
%% Bucle de lazo cerrado
for k=1:length(datos1)
    
 
     Ys(k) = datos1(k)+0.0001*(0.1-rand) ; % senal con ruido

    
    %% Matrices en K
    % calculo de las matrices de la dinamica del sistema en t
    [fi, T ]= c2d(sys.A,sys.B,h)

    
    %% Actualizacion de tiempos
    % estimacion a priori des estado del sistema
    X = (fi * X) + ( T * datos1(k));
    % estimacion a priori de la covarianza
    P = (fi * P * fi') + Q;

    %% Actualizacion de medicion
    % Ganancia de Kalman
    K= ( P * C' ) / ( ( C * P * C' ) + R);
    % estimacion del estado a posteriori
 
    %X = X + K*(Ys(k) - ( C * X) );
    X = X + K*(datos1(k) - ( C * X) );
    % estimacion a posteriori de el error de covarianza
    P = (eye(3) - K*C)*P;
    % calculo de la señal de salida
    %
    u(k) = C * X ;
    x_History = [x_History X];
   
    
          
end


plot(tiempo,u)


