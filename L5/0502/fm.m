function yd = fm(t, y, M, damper, Mdriver)

q = y(1:9,1); % Position from 3 bodies
qd= y(10:18,1); % Velocity from 3 bodies


r2d   = qd(4:5,1); % For viscous friction at body 2

theta = 20*pi/180;
% Forces
g = -9.81;
Fgravity = M*[0;g;0;0;g;0;0;g;0];
VelTrans = [cos(theta);sin(theta)]'*r2d;% Velcity along the sliding line
fdamping = -VelTrans*damper; % magnitude of damping force including sign
Fdamper = [0;0;0; fdamping*[cos(theta); sin(theta)];0; 0;0;0]; % Damping force decomposed into x- and y-components

Factuator = [0;0;Mdriver;0;0;0;0;0;0]; % Moment force from actuator at A
Fext = Fgravity + Fdamper + Factuator; % Putting all forces in single matrix
RH = [Fext; Gamma(q,qd)]; % Right hand side of equations to solve
J = Jacobian(q);
Coef = [M, -J'; J, zeros(8,8)];

x = Coef\RH; 
qdd = x(1:9,1); % Accelerations
lambda = x(10:17,1); % Lambda values page 24 L5

Jtranspose = J';
ReacForc(1:13,1)  = 0;

% Reaction force calculation
ReacForc(1:2,1) = (  Jtranspose(1:2,1:2)*lambda(1:2,1)  )'; % Reaction force on body 1 in point A
ReacForc(3:4,1) = (  Jtranspose(1:2,3:4)*lambda(3:4,1)  )'; % Reaction force on body 1 in point B
ReacForc(5:6,1) = (  Jtranspose(7:8,3:4)*lambda(3:4,1)  )'; % Reaction force on body 3 in point B
ReacForc(7:8,1) = (  Jtranspose(4:5,5:6)*lambda(5:6,1)  )'; % Reaction force on body 2 in point C
ReacForc(9:10,1) =(  Jtranspose(7:8,5:6)*lambda(5:6,1)  )'; % Reaction force on body 3 in point C
ReacForc(11,1) = (  Jtranspose(6,7)*lambda(7,1)  )'; % Reaction moment on body 2 in point D
ReacForc(12:13,1) = (  Jtranspose(4:5,8)*lambda(8,1)  )'; % Reaction force on body 3 in point D

yd = [qd; qdd; ReacForc]; 

