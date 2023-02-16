function yd = fm(t,y,M,c_damper, k_spring, L0_s)

q = y(1:6,1);
qd = y(7:12,1); 

% Geometry
L0 = 1.18;
L1 = 0.54;
L2 = 0.5;
L3 = 1.4;
L4 = 2.8;
L5 = 0.4;
L6 = 0.15;
L7 = 0.75;
L8 = 1.94;
L9 = 0.54;
L10 = 0.81;
L11 = 0.2; 
L12 = 0.4; 

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
r1d = qd(1:2,1);
phi1d = qd(3,1);
r2d = qd(4:5, 1);
phi2d = qd(6,1); 


A1 = A(phi1);
A2 = A(phi2);
B1 = B(phi1);
B2 = B(phi2); 

% Forces
g = -9.81; 
FGrav = M*[0;g;0;0;g;0]; 

% % Spring
d_s = r2 + A2*S2D - S0F;
d_sDot = r2d + phi2d*B2*S2D; 
L_s = norm(d_s);
u_s = d_s/L_s; 

F_spring = (L0_s - L_s) * k_spring * u_s; 
Mom_spring = (B2*S2D)'*F_spring; 

F_s = [0;0;0;F_spring;Mom_spring]; 

% % Damper
L_sDot = (d_s'*d_sDot)/L_s;
F_damper = -c_damper*L_sDot*u_s;
Mom_damp = (A2*S2D)'*F_damper; 

F_d = [0;0;0;F_damper;Mom_damp]; 

% % % All external forces
F_ext = FGrav + F_s + F_d; 

RH = [F_ext; Gamma(q,qd)];
J = Jacobian(q);
Coef = [M, (-J)'; J, zeros(5,5)];

x = Coef\RH; % Error her????
qdd = x(1:6,1);
lambda = x(7:11,1); 

% Reaction forces
Jtranspose = J';
ReacFor(1:11,1) = 0;
ReacFor(1:2,1) = (  Jtranspose(1:2,1:2)*lambda(1:2,1)  ); % Reaction force on body 1 in point A
ReacFor(3:4,1) = (  Jtranspose(1:2,3)*lambda(3,1)  ); % Reaction force on body 1 in point B
ReacFor(5:6,1) = (  Jtranspose(4:5,3)*lambda(3,1)  ); % Reaction force on body 2 in point C
ud1 = 1/norm(Jtranspose(4:5,3))*Jtranspose(4:5,3);
ReacFor(7,1) = ud1'*(Jtranspose(1:2,3)*lambda(3,1)); % force in the rev-rev joint in the longitudinal direction <0 -> compression and >0 -> tension
ReacFor(8:9,1) = (  Jtranspose(4:5,4:5)*lambda(4:5,1)  ); % Reaction force on body 2 in point E
ReacFor(10,1)  = k_spring*(L0-L_s); % Spring force
ReacFor(11,1)  = c_damper*L_sDot; % Damping force



yd = [qd;qdd;ReacFor]; 

