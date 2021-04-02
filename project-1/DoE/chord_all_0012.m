clear; clc; close all;

% This file finds out the optimium chord configuration with a NACA0012 
% and a 4 blade configuration

%% Add paths

addpath ../aerodynamics
addpath ../conversions
addpath ../params
addpath ../power

%% Fixed parameters

params.R = 5.33;                               % m
params.m = 2040;                               % kg
params.Omega = rpm2rad_s(413);                 % rad/s
params.h = ft2m(15000);                        % m
params.rho = ISA_atmosphere(params.h);         % kg/m^3
params.x = linspace(0.001,1,100)';

%% Design variables for LINEAR CHORD NACA 0012

% Number of blades
linearchord12.nb = 4;

% Chord at the root
linearchord12.c0 = 0.27;                             % m

% Chord at the tip
linearchord12.cF = 0.27;                             % m

% Chord distribution
linearchord12.c = chord(linearchord12, params);            % m

% Twist slope
linearchord12.twist.thetaTW = -2;                    % deg/m

% NACA 0012
linearchord12.aero.Cl_alpha = 5.63;                  % 1/rad
linearchord12.aero.Cd0 = 0.0061;                    
linearchord12.aero.K = 0.0138/linearchord12.aero.Cl_alpha^2;  % 1/rad^2


%% Analyses
chord_span = linspace(0.1, 1, 100);            % m
[c_0, c_F] = meshgrid(chord_span);
power = 0 * c_0;
for i = 1:length(chord_span)
    for j = 1:length(chord_span)
        linearchord12.c0 = c_0(i, j);                             % m
        linearchord12.cF = c_F(i, j);                             % m
        linearchord12.c = chord(linearchord12, params); 
        linearchord12 = power_BETMT(params, linearchord12);

%         fprintf("-----------NOMINAL CASE------------\n")
%         fprintf("The collective angle is %.2fº \n", rad2deg(nominal.twist.theta0))
%         fprintf("Cpi = %.8f \n", nominal.Cpi)
%         fprintf("Cp0 = %.8f \n", nominal.Cp0)
%         fprintf("Total power = %.2f kW \n\n", nominal.P)
        power(i, j) = linearchord12.P;
    end
end

figure(1)
contourf(c_0, c_F, power, 'ShowText', 'on')
xlabel('Chord in the root [m]')
ylabel('Chord in the tip [m]')
title('Power [kW] vs chord distribution')
grid on
colormap cool
% shading interp
% colorbar
[~, minIdx] = min(power(:)); 
[row,col] = ind2sub(size(power),minIdx); 
xMin = c_0(row,col); 
yMin = c_F(row,col); 
% Mark min  on plot

data_wanted = [250, 255, 260, 270];
figure(2)
contourf(c_0, c_F, power, data_wanted,'ShowText', 'on')
hold on 
plot(xMin, yMin, 'rs', 'MarkerSize', 12)
xlim([0.1, 0.8])
ylim([min(chord_span), 0.25])
xlabel('Chord in the root [m]')
ylabel('Chord in the tip [m]')
title('Power [kW] vs chord distribution')
grid on
colormap cool

fprintf("-----------LINEAR CHORD CASE------------\n")
% fprintf("The collective angle is %.2fº \n", rad2deg(nominal.twist.theta0))
fprintf("c0 = %.2f \n", xMin)
fprintf("cF = %.2f \n", yMin)
fprintf("Minimum power = %.2f kW \n\n", power(row, col))