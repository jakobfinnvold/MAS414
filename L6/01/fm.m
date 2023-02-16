function yd = fm(t,y,M,c_damp)

% Geometry
L1 = 0.75;
L2 = 0.75; 
S1A = [-L1;0];

q = y(1:3,1);
qd = y(4:6,1); 

% q-vector
r1 = q(1:2,1);
phi1 = q(3,1); 
r1d = qd(1:2,1);
phi1d = qd(3,1); 

A1 = A(phi1); 
B1 = B(phi1); 

% velocity parameters
omega_1_set = 4;
omega_2_set = 8;
error = 0;
iError = 0;
dt = 0.01; 

Kp = 10;
Ki = 1;

if t <= 15.0
    error = omega_1_set - phi1d; 
else
    error = omega_2_set - phi1d;
end 

iError = iError + error*dt; 

M_1 = Kp*error + Ki*iError;

F_damp = [0;0;-phi1d*c_damp]; 

F_ext = F_damp + [0;0;M_1]; 

RH = [F_ext;Gamma(q,qd)]; 

J = Jacobian(q); 
Cf = [M, -J';J,zeros(2,2)]; 

% Solving
x = Cf\RH;
qdd = x(1:3,1);
lambda = x(4:5,1); 

Jtranspose = J'; 

% Reaction forces
ReactForce(1:2,1) = Jtranspose(1:2,1:2)*lambda(1:2,1); 



yd = [qd;qdd;error;M_1;ReactForce]; 

