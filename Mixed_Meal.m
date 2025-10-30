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

function [sys,x0,str,ts] = Mixed_Meal(~,x,u,flag,x_G,x_P,x_F)
% x_G: CHO percentage in the meal
% x_P: Protein percentage in the meal
% x_F: FFA percentage in the meal

%% Physiological Parameters
    k_G = .022;   % [1/min]
    k_P = .015;   % [1/min]
    k_F = .0097;  % [1/min]
    
%% flags
switch flag
  case 0
    sizes = simsizes;
    sizes.NumContStates  = 3;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 2;
    sizes.NumInputs      = 1;
    sizes.DirFeedthrough = 0;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0  = [0 0 0];
    str = [];
    ts  = [0 0];
    
  case 1 % Continuous States
    %% Inputs
    ff = 1;
    G_emp = u(1)*1000*ff; % [mg/min]
    
    %% States
    N_G = x(1);
    N_P = x(2);
    N_F = x(3);
    N_dot_G = x_G*G_emp-k_G*N_G;
    N_dot_P = x_P*G_emp-k_P*N_P;
    N_dot_F = x_F*G_emp-k_F*N_F;
    sys = [N_dot_G N_dot_P N_dot_F];
    
  case 3 % Outputs
    u_2 = k_G*x(1)+.6*k_P*x(2);
    u_3 = k_F*x(3);
    sys = [u_2 u_3];

  case {2 4 9}
    sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end