clear; close all; clc; 
% Geometry
L0 = 1.18;
L1 = 0.54;
L2 = 0.5;
L3 = 1.4;
L4 = 2.8;
L5 = 0.4;
L6 = 0.15;
L7 = 0.75;
L8 = 1.94;
L9 = 0.54;
L10 = 0.81;
L11 = 0.2; 
L12 = 0.4; 

% Case vectors
S0F = [L4;-L1];
S0E = [L3;-L2];
S1A = [-L8;-L10];
S1B = [-L9;-L10];
S2C = [L5;0];
S2D = [L11;-L6];
S2E = [-L12;0];

% q-Vectors
% r1 = q(1:2, 1);
% phi1 = q(3,1); 
% r2 = q(4:5, 1); 
% phi2 = q(6,1);
% r1d = qd(1:2,1);
% phi1d = qd(3,1);
% r2d = qd(4:5, 1);
% phi2 = qd(6,1); 

% Problem properties
m1 = 3800;
m2 = 75;
J_G1 = 3955;
J_G2 = 3.1;

M = diag([m1,m1,J_G1,m2,m2,J_G2]); 

c_damp = 5500;
k_spring = 12e5;
L0_Spring = 1.18;

q_init = [1.543069001347181;1.427808830719795;0.351098023786103;
1.674584579945459;-0.209133521257303;0.814184741606332;0;0;0;0;0;0;]; 


% Time
tmin = 0;
tmax = 15;
dt = 0.01;
t = [tmin:dt:tmax]';
N = length(t); 

[time, Y, Yd, Ydd, ReacForc] = RK4extraMultiBodyWithExtraData('fm',t, dt,q_init,6,11,M,c_damp,k_spring,L0_Spring);

BodyPlot(t,Y,2,'',1);
BodyPlot(t,Yd,2,'d',1);
%BodyPlot(t,Ydd,2,'dd',1);