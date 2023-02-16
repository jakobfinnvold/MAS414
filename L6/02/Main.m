clear; close all; clc; 

%Geometry
L1 = 2.8;
L2 = 0.54;
L3 = 0.81;
L4 = 1.94;
L5 = 0.54;
L6 = 0.7;
L7 = 0.725;
L8 = 0.035;
L9 = 0.755;
L10 = 0.675;
L11 = 0.625; 
D_p = 0.15; 

% Geometry vectors
S1A = [-L4;-L3];
S1B = [-L5;-L3]; 
S2B = [-L6;0]; 
S3C = [L10;0]; 
S0C = [L1;L2]; 

% Mass properties
m1 = 7000;
J_G1 = 10900;
m2 = 55;
J_G2 = 9;
m3 = 75;
J_G3 = 13;
beta = 1100e6; %Pascal

M = diag([m1,m1,J_G1,m2,m2,J_G2,m3,m3,J_G3]); 

% Time analysis
tmin = 0;
tmax = 20;
dt = 0.01;
t = [tmin:dt:tmax]';
N = length(t); 

% Initial guess
q_init = [L4;L3;0;
    L4-L5+0.64817;-0.2643;-asin(L2/(L9+L10));
    L4-L5+0.740768;-0.3021;-asin(L2/(L9+L10));
    0;0;0;0;0;0;0;0;0]; 

% Position test
Ptest = Phi(q_init(1:9,1)); 

% Velocity test
VelTest = Jacobian(q_init(1:9,1));