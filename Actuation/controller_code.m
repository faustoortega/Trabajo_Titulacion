function [exectime, data] = controller_code(seg, data)

switch seg
    case 1
        rcvData = ttGetMsg;
        if isempty(rcvData)
            disp('Error in controller: no message received!');
        end
        
        x1 = rcvData(1);
        x2 = rcvData(2);
        tk = rcvData(3);
        tsk = rcvData(4);
        
        tauk = tk - tsk;
        
        r = ttAnalogIn(1);    % Read reference value
         
        %% half kalman
        
         %from t(k) to ts(k+1)    
        
        sys = ss(data.A, data.B, data.C, data.D);
        sys = c2d(sys, data.h-tauk);
      
        data.xhat = sys.a*data.xhat + sys.b*data.u;
        data.P = sys.a*data.P*sys.a' + data.Q; 
  
        data.K = data.P*data.C'*inv(data.C*data.P*data.C' + data.R);
        data.xhat = data.xhat + data.K*data.C*([x1;x2] - data.xhat);       


        %data.P = (eye(2)-data.K*data.C)*data.P;
        data.P = data.P - data.C*data.K*data.P;
        
         %from ts(k) to t(k)
         
        sys = ss(data.A, data.B, data.C, data.D);
        sys = c2d(sys, tauk);
         
        data.xhat = sys.a*data.xhat + sys.b*data.u;
        data.P = sys.a*data.P*sys.a' + data.Q; 
                
        data.u = -data.L(1)*(data.xhat(1)-r) - data.L(2)*data.xhat(2);      
        ttAnalogOut(1, data.xhat(1));
        ttAnalogOut(2, data.xhat(2));
        ttAnalogOut(3, data.K(1,1));
        ttAnalogOut(4, data.K(1,2));
        ttAnalogOut(5, data.K(2,1));
        ttAnalogOut(6, data.K(2,2));
        
        %% luenberger observer
        
%                 sys = ss(data.A, data.B, data.C, data.D);
%                 sys = c2d(sys, tauk);
%                 xhat = sys.a*[x1; x2] + sys.b*data.u;
%         
%                 data.u = -data.L(1)*(xhat(1)-r) - data.L(2)*xhat(2);
        
        %%
        %exectime = 1e-6;
          exectime = rand*data.exectime;
        
    case 2
        ttSendMsg(4, data.u, 8);    % Send 80 bits to node 4 (actuator)
        exectime = -1; % finished
end