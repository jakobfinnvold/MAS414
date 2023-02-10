clear; close all; clc; 

% Geometry
L1 = 0.5;
L2 = 0.7;
L3 = 1.3;
L4 = 1.8;
L5 = 0.4;
L6 = 0.6;
L7 = 1.1;
theta = 20*pi/180;

% Vectors
S0A = [-L7;L6];
S1A = [-L1;0]; 
S1B = [L2;0];
S3B = [-L3;0];
S3C = [L4;0];
S2C = [-L5;0]; 

q_init = [(-L7+cos(theta)*L1), (L6+sin(theta)*L1), theta,...  % body 1
     (-L7 + cos(theta)*(L1 + L2 + L3 + L4 + L5)), (L6 + sin(theta)*(L1 + L2 + L3 + L4 + L5)), theta,...  % body 2
     (-L7 + cos(theta)*(L1 + L2 + L3)), (L6 + sin(theta)*(L1 + L2 + L3)), theta,...
     0,0,0, 0,0,0, 0,0,0]'

% Reaction forces
g = -9.81;
m1 = 7;
J_G1 = 1.4;
m2 = 15;
J_G2 = 2.7;
m3 = 10;
J_G3 = 8.5;
Mdriver = 95;
damper = 10; 
M = diag([m1,m1,J_G1,m2,m2,J_G2,m3,m3,J_G3]); 
theta = 20*pi/180;

% Looping params
tmin = 0;
tmax = 20;
dt = 0.01;
t = [tmin:dt:tmax];
N = length(t); 


[time, Y, Yd, Ydd, ReacForc] = RK4extraMultiBodyWithExtraData('fm', t, dt, q_init, 9,13,M,damper, Mdriver); 

% Plot of the results
BodyPlot(t,Y,3,'',1)% Function call - the function is defined in a separate file
BodyPlot(t,Yd,3,'d',2)% Function call - the function is defined in a separate file
BodyPlot(t,Ydd,3,'dd',3)% Function call - the function is defined in a separate file



