function a = RHVel(q,t)

r1 = q(1:2,1);
phi1 = q(3,1);
r2 = q(4:5,1);
phi2 = q(6,1);
r3 = q(7:8,1);
phi3 = q(9,1); 

a = zeros(9,1);
a(9,1) = 2*0.1*t + 3;

end

