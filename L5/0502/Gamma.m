function g = Gamma(q, qd, t)

%q-vector
r1 = q(1:2,1);
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);
r3 = q(7:8,1);
phi3 = q(9,1);

% qd-vector
r1d = qd(1:2,1);
phi1d = qd(3,1);
r2d = qd(4:5,1);
phi2d = qd(6,1);
r3d = qd(7:8,1);
phi3d = qd(9,1); 

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
theta = deg2rad(20); 
%phi_t = 0.1*t^2 + 3*t;
A1 = A(phi1);
A2 = A(phi2);
A3 = A(phi3);
B1 = B(phi1);
B2 = B(phi2);
B3 = B(phi3); 

g = zeros(8,1); % THis is vector for RHS as jacobian is equal

g(1:2,1) = phi2d^2*A1*S1A;
g(3:4,1) = phi2d^2*A1*S1B - phi3d^2*A3*S3B;
g(5:6,1) = phi2d^2*A2*S2C - phi3d^2*A3*S3C; 
g(7,1) = 0;
g(8,1) = 0;
%Gamma(9,1) = 2*0.1;




