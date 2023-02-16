function Phi = Phi(q, t)

% Geometry
L1 = 0.75;
L2 = 0.75; 
S1A = [-L1;0];

% q-vector
r1 = q(1:2,1);
phi1 = q(3,1); 

A1 = A(phi1); 

Phi = zeros(2,1); 
Phi(1:2,1) = r1 + A1*S1A; 

end

