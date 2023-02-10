function J = Jacobian(q)
% Geometry
L0 = 1.180;
L1 = 0.540;
L2 = 0.500;
L3 = 1.400;
L4 = 2.800;
L5 = 0.400;
L6 = 0.150;
L7 = 0.750;
L8 = 1.940;
L9 = 0.540;
L10 = 0.810;
L11 = 0.200; 
L12 = 0.400; 

% Case vectors
S0F = [L4;-L1];
S0E = [L3;-L2];
S1A = [-L8;-L10];
S1B = [-L9;-L10];
S2C = [L5;0];
S2D = [L11;-L6];
S2E = [-L12;0];

% q-Vectors
r1 = q(1:2, 1);
phi1 = q(3,1); 
r2 = q(4:5, 1); 
phi2 = q(6,1);

A1 = A(phi1);
A2 = A(phi2);
B1 = B(phi1);
B2 = B(phi2); 


J = zeros(5,6); 
d = r2 + A2*S2C - r1 - A1*S1B; 
J(1:2, 1:3) = [eye(2), B1*S1A];
J(3, 1:6) = [-2*d', -2*d'*B1*S1B, 2*d', 2*d'*B2*S2C]; 
J(4:5, 4:6) = [eye(2), B2*S2E]; 






