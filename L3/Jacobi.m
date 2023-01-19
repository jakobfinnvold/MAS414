function J = Jacobi(q)
% Proper notation for the coordinates for each body
r1 = q(1:2,1);
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);

A1 = A(phi1);
A2 = A(phi2);
B1 = B(phi1);
B2 = B(phi2);

% Geometry
% Geometry
L1 = 0.5;
L2 = 0.7;
L3 = 1.3;
L4 = 1.8;
L5 = 0.4;
L6 = 0.6;
L7 = 1.1;
% Constant vectors
s0A  = [-L7; L6];
s1Am = [-L1; 0];
s1Bm = [L2; 0];
s2Cm = [-L5; 0];
s3Bm = [-L3; 0];
s3Cm = [L4; 0];


% Initialization of the jacobian matrix
J = zeros(6,6);
% Revolute joint between body 1 and ground
J(1:2,1:3) = [eye(2), B1*s1Am]; %eye(2) = Identity matrix
%
% Revolute-revolute joint between body 1 and 2
d = r2 + A2*s2Cm - r1 - A1*s1Bm;
J(3,1:6) = 	[-2*d', -2*d'*B1*s1Bm, 2*d', 2*d'*B2*s2Cm];
%
% Translational joint between body 2 (box) and ground
J(4,6) = 1;
J(5,5) = 1;
%
% Rotational driver
J(6,3) = 1;
