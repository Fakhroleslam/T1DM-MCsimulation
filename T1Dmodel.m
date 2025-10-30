%==========================================================================
%   Copyright (c) 2025, PSE TMU
%   Process System Engineering (PSE) research group at Tarbiat Modares University (TMU)
%   All rights reserved.
%
%   This code is provided "as is" without any warranties, express or implied,
%   including but not limited to the warranties of merchantability and fitness
%   for a particular purpose.
%
%   Author: Mohammad Fakhroleslam
%   Contact:
%   fakhroleslam@modares.ac.ir
%
%   Last update: 2025-10-29
%%=========================================================================

function [sys,x0,str,ts] = T1Dmodel(~,x,u,flag,bw,age,PhysParams)
% Physiological Parameters
% Volume of extracellular fluid as a function of bodyweight and age
V_ExF = @(bw,age) .497*bw*age^(-.206); % [L]
% Plasma volume as a function of body weight
V_Pl  = @(bw) .047*bw; % [L]

    p_1   = PhysParams(1);  % [1/min]
    p_2   = PhysParams(2);  % [1/min]
    p_3   = PhysParams(3);  % [1/min]
    p_4   = PhysParams(4);  % [mL/min/microU]
    p_5   = 1/V_Pl(bw);      % [1/L]
    p_6   = PhysParams(5);  % [L/min/micromol]
    p_7   = PhysParams(6);  % [1/min]
    p_8   = PhysParams(7);  % [mL/min/muU]  = P_8 in E_Minimal6 * (p_F3/p_F2)/(p_3/p_2)
    n     = PhysParams(8);  % [1/min]
    a     = 0.00021;        % [dL/min/mg] = a in E_Minimal6 * (k_1/k_2)
    b     = 0.0055;         % [dL/mg]
    G_b   = PhysParams(9);  % [mg/dL]
    F_b   = PhysParams(10); % [mumol/L]
    Vol_G = V_ExF(bw,age)*10; % [dL]
    Vol_F = V_ExF(bw,age);  % [L]
    u_Ib  = PhysParams(11); % [mU/min]
    I_b   = p_5/n*u_Ib;
    Z_b   = F_b;
    
% initial conditions
    I_0 = I_b; % 
    X_0 = 0;   % 
    G_0 = G_b; % 
    F_0 = F_b; %
    x_0 = [I_0 X_0 G_0 F_0];
    
% flags
switch flag
  case 0
    sizes = simsizes;
    sizes.NumContStates  = 4;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 2;
    sizes.NumInputs      = 3;
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0  = x_0;
    str = [];
    ts  = [0 0];
    
  case 1 % Continuous States
    u(1) = u(1)*11.7*p_5;
    % Inputs
    u_I = u(1); % The rate of Insulin Absorption [mU/min]
    u_G = u(2); % The rate of Glucose Absorption [mg/min]
    u_F = u(3); % The rate of FFA Absorption     [mumol/min]
    
    %% States
    I = u(1);
    X = x(2);
    G = x(3);
    F = x(4);
    
    I_dot = -n*I+p_5*u_I;
    X_dot = -p_2*X+p_3*(I-I_b);
    G_dot = -p_1*G-p_4*X*G+p_6*G*F+p_1*G_b-p_6*G_b*Z_b+u_G/Vol_G;
        p_9 = a*exp(-b*G);
    F_dot = -p_7*F-p_8*X*F+p_9*F*G+p_7*F_b-p_9*F_b*G_b+u_F/Vol_F;
    
    sys = [I_dot X_dot G_dot F_dot];
    
  case 3 % Outputs
    u(1) = u(1)*11.7*p_5;
    sys = [x(3) u(1)];

  case {2 4 9}
    sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end