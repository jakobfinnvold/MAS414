function J = Jacobian(q)
%q-vector
r1 = q(1:2,1);
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);
r3 = q(7:8,1);
phi3 = q(9,1);

% Geometry
L1 = 0.5;
L2 = 0.7;
L3 = 1.3;
L4 = 1.8;
L5 = 0.4;
L6 = 0.6;
L7 = 1.1;

% Vectors
S0A = [-L7;L6];
S1A = [-L1;0]; 
S1B = [L2;0];
S3B = [-L3;0];
S3C = [L4;0];
S2C = [-L5;0];

% Angles, drivers & rot matrices
theta = 20*pi/180; 
A1 = A(phi1);
A2 = A(phi2);
A3 = A(phi3);
B1 = B(phi1);
B2 = B(phi2);
B3 = B(phi3); 

J = zeros(8,9);

J(1:2, 1:3) = [eye(2), B1*S1A]; 
J(3:4,1:9) = [eye(2), B1*S1B, zeros(2,3), -eye(2), -B3*S3B];
J(5:6, 4:9) = [eye(2), B2*S2C, -eye(2), -B3*S3C];
J(7,6) = 1;
J(8,4:5) = [-sin(theta), cos(theta)];
%Jacobian(9,3) = 1; 



