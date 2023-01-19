function a = RHvel(q,t)
r1 = q(1:2,1);
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);

% Initialization of the right hand side
a = zeros(6,1);
% Longitudinal driver
a(6,1) = 4;
A1 = A(phi1);
A2 = A(phi2);
B1 = B(phi1);
B2 = B(phi2);
L1 = 0.5;
L2 = 0.7;
L3 = 1.3;
L4 = 1.8;
L5 = 0.4;
L6 = 0.6;
L7 = 1.1;

Phi = zeros(6,1);
Phi(1:2,1) = [0;0] - r1 - A1*[-L1;0];
d1 = r1 + A1*[0;-L2] - r2 - A2*[0;0];
Phi(3,1)   = d1'*d1 - L3^2;
Phi(4:5,1) = [L6;0] - r2 - A2*[0;-L5];
d2 = r2 + A2*[L4;0] - [L6+L7;0];
Phi(6,1) = d2'*d2 - (1.85 + 0.15*t)^2;
