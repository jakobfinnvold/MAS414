function g = Gamma(q,qd,t)
% Proper notation for the coordinates for each body
r1   = q(1:2,1);
phi1 = q(3,1);
r2   = q(4:5,1);
phi2 = q(6,1);
r1d   = qd(1:2,1);
phi1d = qd(3,1);
r2d   = qd(4:5,1);
phi2d = qd(6,1);

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

% Initialization of the gamma-vector
g = zeros(6,1);
% Revolute joint between body 1 and ground
g(1:2,1) = phi1d^2*A1*s1Am;
%
% Revolute-revolute joint between body 1 and 2
d = r2 + A2*s2Cm - r1 - A1*s1Bm;
dd = r2d + phi2d*B2*s2Cm - r1d - phi1d*B1*s1Bm;
g(3,1) = -2*dd'*dd - 2*d'*( -phi2d^2*A2*s2Cm + phi1d^2*A1*s1Bm);
%
% Translational joint between body 2 (box) and ground
g(4,1) = 0;
g(5,1) = 0;
% Rotational driver
g(6,1) = 0;
