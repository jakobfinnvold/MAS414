function J = Jacobian(q,t)

r1 = q(1:2,1)
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);
r3 = q(7:8,1);
phi3 = q(9,1); 

A1 = A(phi1);
A2 = A(phi2);
A3 = A(phi3); 
B1 = B(phi1);
B2 = B(phi2); 
B3 = B(phi3); 

% Geometry vectors
S1A = [-L4;-L3];
S1B = [-L5;-L3];
S2B = [-L6;0]; 
S3C = [L10;0];
S0C = [L1;L2]; 

J = zeros(8,9);
J(1:3,1:2) = [eye(2), B1*S1A]; 
J(3:4,1:6) = [eye(2), B1*S1B, -eye(2), -B2*S2B]; 
J(5,6) = 1;
J(5,9) = -1;

n = [0;1];
d = r2-r3;

J(6,4:9) = [(A2*n)', (B2*n)'*d, -(A2*n)', 0]; 
J(7:8, 7:9) = [eye(2),B3*S3C]; 

end

