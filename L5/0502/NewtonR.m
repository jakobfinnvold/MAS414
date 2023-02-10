function b = NewtonR(Phi,Jacobi,x,t,tol,relax)
% function b = NewtonR(Phi,Jacobi,x,t,eps,k1,k2)
%
% Phi er en streng indeholdende navnet p� funktionen 
%     indeholdende bindingsligningerne Phi(x,p)
% Jacobi er en streng indeholdende navnet p� funktionen
%     indeholdende jacobimatrice Jacobi(x,p)
% x er en vektor med startg�ttet for de variable koordinater
% p er en vektor med mulige konstanter. Hvis ingen konstanter 
%     eksisterer s�ttes p til et 0 i funktionskaldet
% relax er en relaxationsfaktor for �ndringen af koordinatvektoren
%     i Newton-Raphson iterationen. Den b�r som standard s�ttes 
%     til 1 i funktionskaldet.
% 
% Output fra NewtonR er en vektor med koordinater, der tilfredsstiller 
% det opstillede ligningssystem
% 
% 
% Morten Ebbesen, Aalborg University, 2005

if nargin < 5 | isempty(tol), tol = 1e-10; end
if nargin < 6 | isempty(relax), relax = 1.0; end

nmax = 150;
% error = norm(feval(Phi,x,t,k1,k2));
error = norm(feval(Phi,x,t));
i = 0;
while (error>tol & i<nmax)
    i = i + 1;
%     deltax = feval(Jacobi,x,k1)\feval(Phi,x,t,k1,k2);
    J = feval(Jacobi,x);
    P = feval(Phi,x,t);
    deltax = J\P;
%     deltax = feval(Jacobi,x)\feval(Phi,x,t);
    error = norm(deltax);
    x = x - relax*deltax;
%     x = x - deltax;
end
b = x;