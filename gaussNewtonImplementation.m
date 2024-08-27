clc;clear all;close all;format shortG; % Formatting

n = 100; % Number of data points

% Generates data points with random errors based on known sine curve
x = linspace(-2,6,n); 
y = 1.5*sin(2*x+3)+0.8;
randErrors = (rand(n,1)'-0.5);
y = y + randErrors;
% ------------------------------------------------------------------

b = [2, 2, 2, 2]'; % Starting guess for beta parameters

% Iterates through 
for i=1 : 400
  J = [sin(b(2)*x + b(3)); % Jacobian matrix construction
      (b(1)*x.*cos(b(2)*x + b(3)));
      (b(1)*cos(b(2)*x + b(3)));
      ones(n,1)']';

  r = (y - (b(1)*sin(b(2)*x + b(3)) + b(4)))'; % Residual calculation
   
  delta_b = inv(J'*J)*J'*r; % Calculating delta_beta
  
  b = b + 0.01*delta_b; % Iterating step; damping coefficient = 0.01
end
% -------------------------------------------------------------------

vector_of_betas = b % Displays final beta vector
y_reg = b(1)*sin(b(2)*x + b(3)) + b(4);

hold
scatter(x, y); % Plots data points
plot(x, y_reg); % Plots regression curve
title("Line of Best Fit Through Random Sinusoidal Data");
xlabel("x");
ylabel("y");

