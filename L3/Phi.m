function Phi = Phi(q,t)
    % Geometry
    L1 = 0.5;
    L2 = 0.7;
    L3 = 1.3;
    L4 = 1.8;
    L5 = 0.4;
    L6 = 0.6;
    L7 = 1.1;

    %vectors
    S0A = [-L7;L6];
    S1A = [-L1;0];
    S1B = [L2;0];
    S2C = [-L5;0]; 

    r1 = q(1:2,1);
    phi1 = q(3,1);
    r2 = q(4:5, 1);
    phi2 = q(6,1); 
    y2 = r2(2,1); 

    A1 = A(phi1);
    A2 = A(phi2);
    %B1 = B(phi1);
    %B2 = B(phi2);

    Phi = zeros(6,1); 
    Phi(1:2, 1) = r1 + A1*S1A - S0A;
    d = r2 + A2*S2C - r1 - A1*S1B;
    Phi(3,1) = transpose(d)*d - (L3+L4)^2;
    Phi(4,1) = phi2;
    Phi(5,1) = y2 - L6;
    Phi(6,1) = phi1 - 4*t;


end

