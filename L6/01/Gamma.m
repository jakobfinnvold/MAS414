function g = Gamma(q,qd,t)

% Geometry
L1 = 0.75;
L2 = 0.75; 
S1A = [-L1;0];

% q-vector
r1 = q(1:2,1);
phi1 = q(3,1); 
r1d = qd(1:2,1);
phi1d = qd(3,1); 

A1 = A(phi1); 
B1 = B(phi1); 

g = zeros(2,1); 

g(1:2,1) = phi1d^2*A1*S1A; 



end

