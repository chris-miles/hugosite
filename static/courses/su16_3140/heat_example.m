%% heat.m -- basic finite difference setup on the heat equation
% written by Chris Miles, 2016
%
% solves u_t = u_xx on [0,L] with initial conditions  u(x,0) = f(x), left
% NEUMANN boundary u_x(0,t) = ux0 and right DIRICHLET boundary u(L, t) = uL
% for the sake of illustration but  These can be adjusted towhatever you
% would like.
%
% Many improvements could be made to this, including:
%   1. writing each time step as matrix multiplication
%   2. switching to an IMPLICIT time step instead of explicit,
%   3. using ghost points (index -1 and N+1) for more accurate boundaries
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% clear everything
clear all;
close all;

t_0 = 0; % initial time
t_f = 0.25; % end time
M = 1250; % number of time steps
N = 50; % number of space steps

L = 1; % length of interval
% define the mesh in space
dx = L/(N-1);
x = 0:dx:1; % equally spaced gridpoints from 0 to 1 of length dx
x = x';

% define the mesh in time, same idea
dt = (t_f-t_0)/M;
t = t_0:dt:t_f;

% define the ratio r, this shows up a lot
r = dt/dx^2;

favcolor = [27, 158, 141]/256; % this is just my favorite plotting color

% fixed temperature at the right end point u(L,t) = uL
uL=0.5;

% fixed flux at the left end point u_x(0, t) = ux0
ux0 = 0; % insulated left end point

% define the initial condition, just f(x) = 0.5x
for i=1:N
    u(i,1) = 0.5*x(i);
end

% for internal points, have
%    u_new(j) = u_old(j) + r*(u_old(j+1)-2*u_old(j)+u_old(j-1))
%    which comes from finite difference approximation
%
% for the two end-points, have
%    u_new(1) = u_old(2) - r*(ux0),      because we specify flux
%    u_new(N) = uL,                     because temperature ix fixed

figure(1);

for j=1:M % step through in time
    
    u(1,j+1) = u(2, j) - r*ux0; % assign left boundary
    
    % update internal points s
    for i=2:N-1
        u(i,j+1) = u(i,j) + r*(u(i+1,j)-2*u(i,j)+u(i-1,j));
    end
    
    u(N,j+1) = uL ; % fix right boundary
    
    currentu = u(:,j); % current u(x,tj)
    
    % here we'll plot our solution live as we update it
    plot(x, currentu, 'color', favcolor , 'linewidth',3.5);
    title(['t = ', num2str(j*dt)],'fontsize',20) % update title with time
    ylim([0,0.5]);
    set(gca, 'FontSize', 20, 'LineWidth', 1.5); % prettier plot
    xlim([0,1]);
    xlabel('x');
    ylabel('u(x,t)')
    drawnow;  % redraws after every time step
    %pause(.01);   if it runs too fast, you can pause between steps
end

% now we'll plot a 3D surface plot of the evolution
figure(2);
[X, T] = meshgrid(x, t);
s=surf(X,T,u');
set(s, 'EdgeAlpha', 0, 'FaceColor', 'interp');
xlabel('x');
ylabel('t');
zlabel('u(x,t)')
axis tight;
set(gca, 'FontSize', 20, 'LineWidth', 1.5);
rotate3d;

% some people get upset by 3D, so here's a contour plot instead
figure(3);
[X, T] = meshgrid(x, t);
p=pcolor(X,T,u');
xlabel('x');
ylabel('t');
set(p, 'EdgeAlpha', .0, 'FaceColor', 'interp');
set(gca, 'FontSize', 20, 'LineWidth', 1.5);
colorbar;


