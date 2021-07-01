
% parametrso planta
wn=10;
Hs=tf([1,2],[ 1 2 wn^2]); % funcion ejemplo
h = 0.1/sqrt(wn); % tiempo muestra
Hz = c2d(Hs,h);   %discretiza la planta
n=[0.0311 - 0.02918];
d=[1 -1.843 0.9387];
[A,B,C,D] = tf2ss(n,d); % espacio de estados 

% parametro filtro

uk = 1;
Xem1=[0;0]; % estado inicial
Pkm1=1e6 ; % covarianza inicial 
Q = 0.5;
R = 0.5;
Y = step(Hs,10); %senal real
Yest = zeros(1,200);

for k=1:200
    
    Ys(k)= Y(k)+0.05*(0.2-rand); % se;al con ruido
    
    % Actualizacion de tiempso
    Xem = A*Xem1 + B*uk;
    Pkm = A*Pkm1*A'+Q;
    
    %Actualizacion de la medicion
    Kk = (Pkm*C')/(C*Pkm*C'+R)
    Xe=Xem+Kk*(Ys(k)*C*Xem);
    Pk = (eye(2)*Kk*C)*Pkm;
    
    Xem1=Xem;
    Pkm1=Pk;
    Yest(k)=C*Xe;
       
end
% figure(1)
% plot(Y)
% figure(2)
% plot(Yest)
figure(3)
plot(Y)
hold on
plot(Ys)
hold on
plot(Yest)
hold on
legend('referencia','ruido','filtro de kalman')
