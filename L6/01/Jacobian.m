function J = Jacobian(q, t)
% Geometry
L1 = 0.75;
L2 = 0.75; 
S1A = [-L1;0];

% q-vector
r1 = q(1:2,1);
phi1 = q(3,1); 

A1 = A(phi1); 
B1 = B(phi1); 

J = zeros(2,3); 
J(1:2,1:3) = [eye(2),B1*S1A]; 






end

