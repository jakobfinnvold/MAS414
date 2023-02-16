function [tspan,Y,Yd,Ydd,ExtraStates,ExtraStates_dot,ExtraData] = RK4extraMultiBody_ExtraStates_ExtraData(f,tspan,dt,yini,Nvar,NExtraStates,NextraData,varargin)
% [tspan,Y,Yd,Ydd,ExtraStates,ExtraStates_dot,ExtraData] = RK4extraMultiBody_ExtraStates_ExtraData(f,tspan,dt,yini,Nvar,NExtraStates,NextraData,var1,var2...)
% 
% INPUT
% f            -> name of function
% tspan        -> interval of integration linspace(tmin:dt:tmax)
% dt           -> increment - fixed time step
% yini         -> initial values [position; velocity; hydraulic pressure] in a
%                 collumn
% Nvar         -> number of mechanical equations that is integrated (number of
%                 position coordinates
% NExtraStates -> Number of extra state variables that are integrated for
%                 examples hydraulic pressures 
% NextraData   -> Number of extra data that are returned to the calling 
%                 file without being integrated
% var1,var2    -> extra variables that is passed on to the function f
% 
% OUTPUT
% tspan           -> interval of integration linspace(tmin:dt:tmax)
% Y               -> Position
% Yd              -> Velocity
% Ydd             -> Acceleration
% ExtraStates     -> Extra states returned to calling file - for example
%                    hydraulic pressures
% ExtraStates_dot -> Derivative of extra states returned to calling file -
%                    for example the derivative of hydraulic pressures
% ExtraData       -> values passed on from derivative function - for example
%                    lagrangian multipliers or reaction forces

n = length(tspan);
m = length(yini);
% p = 3*Nvar;
pp = 2*Nvar + NExtraStates;
qq = 2*Nvar + NExtraStates + 1;
q = 2*Nvar;
r = 2*Nvar+1;
s = Nvar+1;
y = yini;
Y(1:n,1:Nvar) = 0;
Yd(1:n,1:Nvar) = 0;
Ydd(1:n,1:Nvar) = 0;
ExtraStates(1:n,1:NExtraStates) = 0;
ExtraStates_dot(1:n,1:NExtraStates) = 0;
ExtraData(1:n,1:NextraData) = 0;
Y(1,1:Nvar) = yini(1:Nvar,1)';
Yd(1,1:Nvar) = yini(s:q,1)';
ExtraStates(1,1:NExtraStates) = yini(r:pp,1)';

for i=1:(n-1)
    temp1 = feval(f,tspan(i),y,varargin{:});
    Ydd(i,1:Nvar) = temp1(s:q,1)';
    ExtraStates_dot(i,1:NExtraStates) = temp1(r:pp,1)';
    ExtraData(i,1:NextraData) = temp1(qq:pp+NextraData,1)';
    k1 = dt*temp1(1:pp,1);
%     k1 = dt*temp1(1:q,1);
    temp2 = feval(f,tspan(i)+dt/2,y(1:pp,1)+k1/2,varargin{:});
    k2 = dt*temp2(1:pp,1);
%     k2 = dt*temp2(1:q,1);
    temp3 = feval(f,tspan(i)+dt/2,y(1:pp,1)+k2/2,varargin{:});
    k3 = dt*temp3(1:pp,1);
%     k3 = dt*temp3(1:q,1);
    temp4 = feval(f,tspan(i)+dt,y(1:pp,1)+k3,varargin{:});
    k4 = dt*temp4(1:pp,1);
%     k4 = dt*temp4(1:q,1);
    y(1:pp,1) = y(1:pp,1) + k1/6 + k2/3 +k3/3 + k4/6;
    Y(i+1,1:Nvar) = y(1:Nvar,1)';
    Yd(i+1,1:Nvar) = y(s:q,1)';
    ExtraStates(i+1,1:NExtraStates) = y(r:pp,1)';
end
temp1 = feval(f,tspan(n),y,varargin{:});
Ydd(n,1:Nvar) = temp1(s:q,1)';
% Lambda(n,1:Nlambda) = temp1(r:q+Nlambda,1)';
ExtraStates_dot(n,1:NExtraStates) = temp1(r:pp,1)';
ExtraData(n,1:NextraData) = temp1(qq:q+NExtraStates+NextraData,1)';
