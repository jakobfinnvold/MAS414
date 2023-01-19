clear; close all; clc; 

% Geometry
L1 = 0.5;
L2 = 0.7;
L3 = 1.3;
L4 = 1.8;
L5 = 0.4;
L6 = 0.6;
L7 = 1.1;

%vectors
S0A = [-L7;-L6];
S1A = [-L1;0];
S1B = [L2;0];
S2C = [-L5;0]; 

q = [-1.100+0.500;0.6;0;(1.3+1.8+0.4+0.1);0.6;0];

T = 0;

MKE = Phi(q,T);
solution = NewtonRaphson('Phi',q,T);
MKE2 = Phi(solution,T) ;

tmin = 0;
tmax = 20;
N = 1000;
t = linspace(tmin,tmax,N)';
dt = t(2,1) - t(1,1);
Y = zeros(N,6);
Yd = zeros(N,6);
Ydd = zeros(N,6);
Y1 = zeros(N,6);
Ydnum = zeros(N,6);
Yddnum = zeros(N,6); % All the matrices for solutions
q = solution;

for i=1:N
    q = NewtonR('Phi','Jacobi',q,t(i,1));
    J = Jacobi(q);
    qd = J\RHvel(q,t(i,1));
    qdd = J\Gamma(q,qd,t(i,1));

    Y(i,1:6) = q'; % Position
    Yd(i,1:6) = qd'; % Velocity
    Ydd(i,1:6) = qdd'; % Acceleration
end 


BodyPlot(t,Y,2,'',1);
BodyPlot(t,Yd,2,'d',2)% Function call - the function is defined in a separate file
BodyPlot(t,Ydd,2,'dd',3)% Function call - the function is defined in a separate file