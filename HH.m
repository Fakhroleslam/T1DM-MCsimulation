function [sys,x0,str,ts] = HH(~,x,~,flag,u_init)

switch flag
  case 0
    sizes = simsizes;
    sizes.NumContStates  = 1;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 1;
    sizes.NumInputs      = 0;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0  = u_init;
    str = [];
    ts  = [0 0];
    
  case 1
    tau  = 400;
    xdot = -x(1)/tau; 
    sys  = xdot;

  case 3
    sys = x(1);

  case {2 4 9}
    sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end