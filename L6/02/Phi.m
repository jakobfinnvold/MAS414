function Phi = Phi(q,t)

r1 = q(1:2,1)
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);
r3 = q(7:8,1);
phi3 = q(9,1); 

A1 = A(phi1);
A2 = A(phi2);
A3 = A(phi3); 

% Geometry vectors
S1A = [-L4;-L3];
S1B = [-L5;-L3];
S2B = [-L6;0]; 
S3C = [L10;0];
S0C = [L1;L2]; 



% Phi vector
Phi = zeros(8,1);
Phi(1:2,1) = r1 + A1*S1A; 
Phi(3:4,1) = r1 + A1*S1B - r2 - A2*S2B;
Phi(5,1) = phi2 - phi3; 
d = r2 - r3;
n = [0;1]; 
Phi(6,1) = (A2*n)'*d; 
Phi(7:8,1) = r3 + A3*S3C - S0C; 

end

