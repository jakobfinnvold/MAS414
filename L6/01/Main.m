clear; close all; clc; 

% Geometry
L1 = 0.75;
L2 = 0.75; 

S1A = [-L1;0]; 
% Properties
omega_1_set = 4;
omega_2_set = 8;

m1 = 20;
J_G1 = 3.75;
M = diag([m1,m1,J_G1]); 

% Forces
c_damp = 10; 

% Initial guess
q_init = [L1;0;0;
    0;0;0;
    0]; 

% Time analysis
tmin = 0;
tmax = 30;
dt = 0.01;
t = [tmin:dt:tmax]'; 
N = length(t); 

%First test of Position
PTest = Phi(q_init(1:3,1),1); 

%First test of velocity
VelTest = Jacobian(q_init(1:3,1),1);

% First test of acceleration
AcTest = Gamma(q_init(1:3,1),q_init(4:6,1),1); 

% Time integration
[time_elaps, Y, Yd, Ydd, ExtraStates, ExtraDotStates, ExtraData] = RK4extraMultiBody_ExtraStates_ExtraData('fm', t, dt, q_init, 3, 1, 3, M, c_damp); 

%BodyPlot(t, Y, 1, '', 1); 
%BodyPlot(t, Yd, 1, 'd', 1); 
%BodyPlot(t, Ydd, 1, 'dd',1); 
%BodyPlot(t,ExtraDotStates, 1, 's',1);