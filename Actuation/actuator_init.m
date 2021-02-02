function actuator_init

global h
% Initialize TrueTime kernel
ttInitKernel('prioDM');   % deadline-monotonic scheduling

data.uk = 0;
data.tk = 0;
data.h = h;

% Periodic actuator task
starttime = 0.0;

ttCreatePeriodicTask('actuator_task', starttime, data.h, 'actuator_code', data);



