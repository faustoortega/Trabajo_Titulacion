function controller_init(arg)

global K A B C D Q R h
% Initialize TrueTime kernel
ttInitKernel('prioDM') % deadline-monotonic scheduling

data.exectime = 18e-3;   % control task execution time

data.L = K;
data.A = A;
data.B = B;
data.C = C;
data.D = D;
data.u = 0;
data.h = h;

%kalman
data.P = zeros(2,2);
data.K = zeros(2,2);
data.xhat = [0;0];
data.R = [0.001*0.001, 0; 0, 0.003*0.003];
data.Q = [0.0001*0.0001, 0;0,0.0001*0.0001];


% Sporadic controller task, activated by arriving network message
deadline = 1e-3;
ttCreateTask('controller_task', deadline, 'controller_code', data);
ttAttachNetworkHandler('controller_task')

