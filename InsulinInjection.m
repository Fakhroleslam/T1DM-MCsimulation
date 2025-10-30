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

function [sys,x0,str,ts] = InsulinInjection(t,~,~,flag)

switch flag
  case 0
    sizes = simsizes;
    sizes.NumContStates  = 0;
    sizes.NumDiscStates  = 0;
    sizes.NumOutputs     = 3; % Insulin Infusion
    sizes.NumInputs      = 0; % Blood Glucose Concentration
    sizes.DirFeedthrough = 1;
    sizes.NumSampleTimes = 1;
    sys = simsizes(sizes);
    x0  = [];
    str = [];
    ts  = [0 0];

  case 3 % Outputs
%     G     = u(1); % Blood Glucose Concentration
    U     = evalin('base','U');
    time  = U(1,:)*60; % The time of SC injection [min]
    Ins  = U(2,:); % The amount of injection
    Type  = U(3,:); % Insulin Type: {1} RI, {2} MI, and {3} NPH
    UI    = 0;
    IT    = zeros(1,3);
    dt    = evalin('base','dt');
    if ~isempty(time) && round(time(1))<=t && t<=round(time(1))+dt
        UI = Ins(1)/dt;
        IT(Type(1)) = 1;
        U(:,1) = [];
        assignin('base','U',U)
    end
    sys = IT*UI;

  case {1 2 4 9}
    sys=[];
  otherwise
    DAStudio.error('Simulink:blocks:unhandledFlag', num2str(flag));
end