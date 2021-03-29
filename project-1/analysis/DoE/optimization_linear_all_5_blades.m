clear; clc; close all;

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

%% Design variables for NOMINAL CASE

% Number of blades
nominal.nb = 5;

% Chord at the root
nominal.c0 = 0.27;                             % m

% Chord at the tip
nominal.cF = 0.27;                             % m

% Chord distribution
nominal.c = chord(nominal, params);            % m

% Twist slope
nominal.twist.thetaTW = -2;                    % deg/m

% NACA 0016
nominal.aero.Cl_alpha = 6.05;                  % 1/rad
nominal.aero.Cd0 = 0.0076;                    
nominal.aero.K = 0.3/nominal.aero.Cl_alpha^2;  % 1/rad^2


%% Analyses

%NACA 0012, NACA 0016, NACA0020
Cd0 = [0.0061, 0.0076, 0.0090];
Cl_alpha = [5.63, 6.05, 4.51];
k_par = [0.0138, 0.3, 0.456] ./Cl_alpha.^2;

min_chord = 0.1; %m
max_chord = 1; %m

chord_span = linspace(min_chord, max_chord, 100);   
twist_angle = linspace(-10, 10, 100);
c_0 = chord_span;

c_F = min_chord;
nominal.cF = c_F;

for airfoil = 1:3
    nominal.aero.Cl_alpha = Cl_alpha(airfoil);
    nominal.aero.Cd0 = Cd0(airfoil);
    nominal.aero.K = k_par(airfoil);
    
    for k = 1:length(twist_angle)
        nominal.twist.thetaTW = twist_angle(k); 
        for i = 1:length(chord_span)
                nominal.c0 = c_0(i);
                nominal.c = chord(nominal, params); 
                nominal = power_BETMT(params, nominal);
                power(k, i, airfoil) = nominal.P;
                fprintf("-----------LINEAR CHORD CASE------------\n")
                fprintf("Twist angle %.2fº \n", nominal.twist.thetaTW)
                fprintf("Airfoil %i \n", airfoil)
                fprintf("c0 = %.2f \n", nominal.c0)
                fprintf("cF = %.2f \n", nominal.cF)
    %             fprintf("Minimum power = %.2f kW \n\n", power(row, col))  
        end
    end
end

power_0012 = power(:, :, 1);

[min_power(1), minIdx] = min(power_0012(:)); 
[row,col] = ind2sub(size(power),minIdx); 
c0_minP(1) = c_0(col); 
twist_angle_minP(1) = twist_angle(row);

power_0016 = power(:, :, 2);

[min_power(2), minIdx] = min(power_0016(:)); 
[row,col] = ind2sub(size(power),minIdx); 
c0_minP(2) = c_0(col); 
twist_angle_minP(2) = twist_angle(row);

power_0020 = power(:, :, 3);

[min_power(3), minIdx] = min(power_0020(:)); 
[row,col] = ind2sub(size(power),minIdx); 
c0_minP(3) = c_0(col); 
twist_angle_minP(3) = twist_angle(row);


figure(1)
contourf(c_0, twist_angle, power_0012, 'ShowText', 'on')
hold on
plot(c0_minP(1), twist_angle_minP(1), 'rx', 'MarkerSize', 12)
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title('Power [kW] (tip chord = 0.1 m), NACA 0012')
colormap cool
% shading interp
grid on

figure(2)
contourf(c_0, twist_angle, power_0016, [291, 292, 295, 300, 320, 340], 'ShowText', 'on')
hold on
plot(c0_minP(2), twist_angle_minP(2), 'rx', 'MarkerSize', 12)
text(c0_minP(2), twist_angle_minP(2), sprintf('Chord root = %.2f, twist angle = %.2f', c0_minP(2), twist_angle_minP(2)))
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title('Power [kW] (tip chord = 0.1 m), NACA 0016')
colormap cool
% shading interp
grid on

figure(3)
contourf(c_0, twist_angle, power_0020, 'ShowText', 'on')
hold on
plot(c0_minP(3), twist_angle_minP(3), 'rx', 'MarkerSize', 12)
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title('Power [kW] (tip chord = 0.1 m), NACA 0020')
colormap cool
% shading interp
grid on

