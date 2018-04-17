%% slopefield.m
% Chris Miles, 9/1/2015
% Demonstration for Math 2250
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% In this file, I'll demonstrate how to plot a slope field using MATLAB.
% For simplicity, let's take y'=x+y. 

% We first need to tell MATLAB which x and y values we want to plot over.
% To do so, we'll make a "grid" of x,y values using the command 
% meshgrid(a:k:b, c:j:d), where a,b are the highest and lowest x values
% and will be plotted at increments of of k, and similar for c,d being the
% range of y values.

[x,y] = meshgrid(-3:.3:3, -2:.3:2);
% we'll particularly take x to range from -3 to 3 and plot every .3, and
% take y from -2 to to 2 and plot every .3. If you want more lines, make
% the increment SMALLER. 

dy = x+y; % this is just our differential equation, f(x,y)

dx = ones(size(dy)); 

% to explain why dx is "one", just think of the fractional form
% dy    f(x,y)
% -- =  -------
% dx      1
% 
% which is exactly our ODE, thus we can think of dy=f, dx =1. This also
% happens to be the required form for the function we're going to use,
% called quiver. 

% quiver (get it? it draws arrows) is the slope field command it MATLAB
% it takes input of the form quiver(x,y, dx,dy)

quiver(x,y, dx,dy);

% we could be done here, but I think that the plot is ugly. quiver thinks
% that it is being useful and makes the arrows bigger or smaller depending
% on how big dy/dx is. I think it looks better if all the arrows are the
% same size, so we will make them all unit vectors (remember this from calc
% 2?) by dividing by their size. 

dy_unit = dy./sqrt(dx.^2+dy.^2);
dx_unit = dx./sqrt(dx.^2+dy.^2);

quiver(x,y, dx_unit,dy_unit);
% this makes a much prettier picture. 
