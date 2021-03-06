%% Numerical implemations - Section 2.4, 2.5, 2.6
%  written by Will Nesse, modified by Chris Miles
%
% One program to do it all: Euler, Heun and Runge-Kutta
%
% Instructions: 
% (1) set your initial data below
% (2) set the step size and number of iterations, or alternatively set the ending time
% t_end to get N
% (3) set/modify the function definition "f" to fit the DE problem
% (4) run the program (click the green triangle) to call the three
% numerical algorithms to plot results. Label and save your graphs
% appropriately.
%
% (5) *modification* if you know the true solution, find the appropriate
%      lines and uncomment them to produce a plot of the relative error

function [] = numerics()
clc;
close all;
clear all;

%%% initial data
x0 = 0;
y0 = 1;

%%% set number of steps and step size
h = .01;

%%% set if you want to print only at a certain stepsize (larger than h)
% hprint = 0.2;

%%% find N based on ending time, you could set N manually
x_end = 1;
N = round((x_end - x0)/h);


% set f(x, y)
%f = @(x,y) 5-0.2*y-0.5*y^(3.5);
f = @(x,y) x-y;

% if you happen to know the true solution, set uncomment the line below
% and write it in the same syntax
% y = @(x) x.^2 + 3;

% just some technical stuff to print out the function on our graph
fstr = func2str(f);
fstr = strrep(fstr, '@(x,y)','');
fstr = texlabel(fstr);


%%% Call numerical algorithm, either Euler, Heun, or Runge-Kutta, or all of
%%% them!

[xE,yE] = Euler(f,x0,y0,h,N);
[xH,yH] = Heun(f,x0,y0,h,N);
[xRK,yRK] = RK(f,x0,y0,h,N);


%% if you want to print only some of the values, set hprint above and uncomment
% these lines appropriately
%
% Nprint = (hprint/h);
% xE(1: Nprint: N+1)
% yE(1: Nprint: N+1)

% you could also compute the error (by setting y=@(x), the true solution
% above ) and then uncomment the line:
% errE = error(yE, y(xE))

% note you could do something similar for H or RK. 




% plots our three techniques
figure(1)
plot(xE,yE,'k', xH,yH, 'r',xRK,yRK,'b','linewidth',2)
xlabel('x','FontSize',16)
ylabel('y','FontSize',16)
set(gca,'FontSize',16)
title(['h = 0.05 for f(x,y)=', fstr])
legend('Euler method', 'Improved Euler', 'Runge-Kutta method')
hold on
scatter(xE,yE, 'k');
scatter(xH,yH, 'r');
scatter(xRK,yRK,'b');

% if you want to plot the error by knowing the true solution, uncomment 
% the lines below. Currently plots error of Euler's method but this can
% modified easily by replacing xE, yE 

%figure;
%plot(xE, error(yE, y(xE)), 'linewidth',2)
%xlabel('x','FontSize',16)
%ylabel('% error','FontSize',16)
%set(gca,'FontSize',16)


%% Computes the relative error if you happen to know the exact function
%  value
function [err] = error(ya,yb)
err = abs((ya-yb)./yb);
end 



%% Euler method
% Solve the IVP y'(x)=f(x,y) with y(y0)=x0. The function f is given as a
% symbolic function.
% Given: step size h and number of steps. 

function [xE,yE] = Euler(f,x0,y0,h,N)
    
    xE = zeros(1,N+1); yE = zeros(1,N+1);   % Initialization
    xE(1) = x0; yE(1) = y0;                 % Initial condition

    for i=1:N                               % For loop over the steps
        xE(i+1) = xE(i)+h;                  % Next x
        yE(i+1) = yE(i)+h*f(xE(i),yE(i));   % Euler iteration - next y
    end
    
end 

%% Heun method (improved Euler)
% Solve the IVP y'(x)=f(x,y) with y(y0)=x0. The function f is given as a
% symbolic function.
% Given: step size h and number of steps. 

function [xH,yH] = Heun(f,x0,y0,h,N)

    xH = zeros(1,N+1); yH = zeros(1,N+1);   % Initialization 
    xH(1) = x0; yH(1) = y0;                 % Initial condition

    for i=1:N                               % For loop over the steps
        k1 = f(xH(i),yH(i));                % k1
        k2 = f(xH(i)+h,yH(i)+h*k1);         % k2
        k = (k1+k2)/2;                      % k
        xH(i+1) = xH(i)+h;                  % Next x
        yH(i+1) = yH(i)+h*k;                % Heun iteration - next y
    end

end
%% RK method
% Solve the IVP y'(x)=f(x,y) with y(y0)=x0. The function f is given as a
% symbolic function.
% Given: step size h and number of steps. 

function [xRK,yRK] = RK(f,x0,y0,h,N)

    xRK = zeros(1,N+1); yRK = zeros(1,N+1); % Initialization
    xRK(1) = x0; yRK(1) = y0;               % Initial condition

    for i=1:N                               % For loop over the steps
        k1 = f(xRK(i),yRK(i));              % k1
        k2 = f(xRK(i)+h/2,yRK(i)+h*k1/2);   % k2       
        k3 = f(xRK(i)+h/2,yRK(i)+h*k2/2);   % k3
        k4 = f(xRK(i)+h,yRK(i)+h*k3);       % k4
        k = (k1+2*k2+2*k3+k4)/6;            % k
        xRK(i+1) = xRK(i)+h;                % Next x
        yRK(i+1) = yRK(i)+h*k;              % Runge Kutta iteration - next y
    end

end

end 