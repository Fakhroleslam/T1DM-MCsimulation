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

clearvars
warning off
clc

%% Input Parameters
Subject = 1;
N_sim   = 2000; % number of simulaitons

% Composition of the meal
x_G0 = 70/108; % CHO percentage in the meal
x_P0 = 18/108; % Protein percentage in the meal
x_F0 = 20/108; % FFA percentage in the meal

%% Modeling and physiological parameters
p_1  = 0.068;    % [1/min]
p_2  = 0.037;    % [1/min]
p_3  = 0.000012; % [1/min]
p_4  = 1;        % [mL/min/microU]
p_6  = 0.00006;  % [L/min/micromol]
p_7  = 0.03;     % [1/min]
p_8  = 4.5*.18137; % [mL/min/muU] = P_8 in E_Minimal6 * (p_F3/p_F2)/(p_3/p_2)
n    = 0.142;    % [1/min]
G_b  = 85;       % [mg/dl]
F_b  = 380;      % [mumol/L]
u_Ib = 11;       % [mU/min]
PhysParams_ = [p_1 p_2 p_3 p_4 p_6 p_7 p_8 n G_b F_b u_Ib];

XX = [
    75 28 100 % bw
    25 9 50 % age
    350 140 400]; % total daily meal
bw   = XX(1,Subject);
age  = XX(2,Subject);
TDMC = XX(3,Subject); % Total Daily Meal Consumption [gr]

%% Inputs
dt     = 2; % [min]
Ndays  = 1;
u_init = 5;

load U_opt
switch Subject
    case 1
        U_RI = U_opt.S1.RI;
        U_LI = U_opt.S1.LI;
    case 2
        U_RI = U_opt.S2.RI;
        U_LI = U_opt.S2.LI;
    case 3
        U_RI = U_opt.S3.RI;
        U_LI = U_opt.S3.LI;
end
U_RI(2,2) = U_RI(2,2)*1.15;
U_LI(2,2) = U_LI(2,2)*1.1;

%% Inputs of RI+NPH
% Normal Eating (NE)
U  = round((U_RI+.001)*10)/10;
LL = length(U);
U  = [U U];
U(1,LL+1:LL*2) = U(1,LL+1:LL*2)+24;
U(1,:) = U(1,:)-6.5;
U1 = sortrows(U')';
U1_meal = [7 9.5 12 16 20];

%% Inputs of LI+NPH
% Normal Eating (NE)
U  = round((U_LI+.001)*10)/10;
LL = length(U);
U  = [U U];
U(1,LL+1:LL*2) = U(1,LL+1:LL*2)+24;
U(1,:) = U(1,:)-6.5;
U2 = sortrows(U')';
U2_meal = [7 9.5 12 16 20];

%% Simulation
ParameterUncertainty = 8; % percent
InitBasalUncertainty = 7; % percent
MealValueUncertainty = 10;  % percent
MealCompsUncertainty = [10 8 6];  % percent for CHO/FFA/Pro
InsInjectUncertainty = [-.1 .4]; % (lower and upper limits) Units

for cc = 1:N_sim % counter
    tic
    if cc==N_sim
        ParameterUncertainty = 0;
        InitBasalUncertainty = 0;
        MealValueUncertainty = 0;
        MealCompsUncertainty = [0 0 0];
        InsInjectUncertainty = [0 0];
    end
    PhysParams(1:8)  = PhysParams_(1:8) .*(1+ParameterUncertainty/100*(rand(1,8)*2-1));
    PhysParams(9:11) = PhysParams_(9:11).*(1+InitBasalUncertainty/100*(rand(1,3)*2-1));
    % http://www.nel.gov/evidence.cfm?evidence_summary_id=250227
    x_G = x_G0+MealCompsUncertainty(1)/100*(rand*2-1); % CHO percentage in the meal
    x_F = x_F0+MealCompsUncertainty(2)/100*(rand*2-1); % FFA percentage in the meal
    x_P = x_P0+MealCompsUncertainty(3)/100*(rand*2-1); % Protein percentage in the meal
    x_sum = x_G+x_P+x_F;
    x_G = x_G/x_sum;
    x_F = x_F/x_sum;
    x_P = x_P/x_sum;
    EI  = 1+MealValueUncertainty/100*(rand*2-1); % Eating Index {under-, normal-, and over-eating}
    MM  = TDMC/350*EI; % Meal Consumption Multiplier

    % Simulation for RINPH
    U = U1;
    IIU = InsInjectUncertainty;
    U(2,:) = U(2,:)+rand(1,length(U))*(IIU(2)-IIU(1))+IIU(1);
    sim('T1DvirtualPatient',24*60*Ndays)
    tout1_NE = tout;
    GB_RI_NE(:,cc) = GB;
    IB_RI_NE(:,cc) = IB;
    
    % Simulation for LINPH
    U = U2;
    IIU = InsInjectUncertainty;
    U(2,:) = U(2,:)+rand(1,length(U))*(IIU(2)-IIU(1))+IIU(1);
    sim('T1DvirtualPatient',24*60*Ndays)
    tout2_NE = tout;
    GB_LI_NE(:,cc) = GB;
    IB_LI_NE(:,cc) = IB;
    tt = toc;
    disp([num2str(cc),' of ',num2str(N_sim),' simulated!  ',num2str(tt*(N_sim-cc)/60,3),' min remained.']) % counter
end

switch Subject
    case 1, save Results_S1
    case 2, save Results_S2
    case 3, save Results_S3
end
MC_PlotForPaper