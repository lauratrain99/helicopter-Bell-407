clear; clc; close all;

% This files finds the optimum chord in the root fixing the tip chord

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

%% Design variables for ROOT CHORD CASE

% Number of blades
rootchord.nb = 4;

% Chord at the root
rootchord.c0 = 0.27;                             % m

% Chord at the tip
rootchord.cF = 0.27;                             % m

% Chord distribution
rootchord.c = chord(rootchord, params);            % m

% Twist slope
rootchord.twist.thetaTW = -2;                    % deg/m

% NACA 0016
rootchord.aero.Cl_alpha = 6.05;                  % 1/rad
rootchord.aero.Cd0 = 0.0076;                    
rootchord.aero.K = 0.3/rootchord.aero.Cl_alpha^2;  % 1/rad^2


%% Analyses
chord_span = linspace(0.1, 1, 100);   
twist_angle = linspace(-10, 10, 100);
c_0 = chord_span;

c_F = 0.1;
rootchord.cF = c_F;

power = zeros(length(twist_angle), length(chord_span));
for k = 1:length(twist_angle)
    rootchord.twist.thetaTW = twist_angle(k); 
    for i = 1:length(chord_span)
            rootchord.c0 = c_0(i);
            rootchord.c = chord(rootchord, params); 
            rootchord = power_BETMT(params, rootchord);
            power(k, i) = rootchord.P;
            fprintf("-----------LINEAR CHORD CASE------------\n")
            fprintf("Twist angle %.2fº \n", rootchord.twist.thetaTW)
            fprintf("c0 = %.2f \n", rootchord.c0)
            fprintf("cF = %.2f \n", rootchord.cF)
%             fprintf("Minimum power = %.2f kW \n\n", power(row, col))  
    end
end
[min_power, minIdx] = min(power(:)); 
[row,col] = ind2sub(size(power),minIdx); 
c0_minP = c_0(col); 
twist_angle_minP = twist_angle(row);
% twist_angle_minP = 
% plot(twist_angle, min_power)

figure(1)
contourf(c_0, twist_angle, power, [291, 292, 295, 300, 320, 340], 'ShowText', 'on')
hold on
plot(c0_minP, twist_angle_minP, 'rx', 'MarkerSize', 12)
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title('Power [kW] (tip chord = 0.1 m)')
colormap cool
% shading interp
grid on

% figure(1)
% contourf(c_0, c_F, power, 'ShowText', 'on')
% xlabel('Chord in the root [m]')
% ylabel('Chord in the tip [m]')
% title('Power [kW] vs chord distribution')
% grid on
% colormap cool
% % shading interp
% % colorbar
% [~, minIdx] = min(power(:)); 
% [row,col] = ind2sub(size(power),minIdx); 
% xMin = c_0(row,col); 
% yMin = c_F(row,col); 
% % Mark min  on plot
% 
% data_wanted = linspace(290, 300, 11);
% figure(2)
% contourf(c_0, c_F, power, data_wanted,'ShowText', 'on')
% hold on 
% plot(xMin, yMin, 'rs', 'MarkerSize', 12)
% xlim([0.15, 0.8])
% ylim([min(chord_span), 0.25])
% xlabel('Chord in the root [m]')
% ylabel('Chord in the tip [m]')
% title('Power [kW] vs chord distribution')
% grid on
% colormap cool
% 
% fprintf("-----------LINEAR CHORD CASE------------\n")
% % fprintf("The collective angle is %.2fÂº \n", rad2deg(nominal.twist.theta0))
% fprintf("c0 = %.2f \n", xMin)
% fprintf("cF = %.2f \n", yMin)
% fprintf("Minimum power = %.2f kW \n\n", power(row, col))