% This file uses the optimimum twist configuration and a linear
% chord configuration to check the three aerodynamic profiles with 
% a 5 blade configuration

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

%% Design variables for AERODYNAMIC PROFILE OPTIMIZATION

% Number of blades
blades5.nb = 5;

% Chord at the root
blades5.c0 = 0.27;                             % m

% Chord at the tip
blades5.cF = 0.27;                             % m

% Chord distribution
blades5.c = chord(blades5, params);            % m

% Twist slope
blades5.twist.thetaTW = -2;                    % deg/m

% NACA 0016
blades5.aero.Cl_alpha = 6.05;                  % 1/rad
blades5.aero.Cd0 = 0.0076;                    
blades5.aero.K = 0.3/blades5.aero.Cl_alpha^2;  % 1/rad^2


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
blades5.cF = c_F;

for airfoil = 1:3
    blades5.aero.Cl_alpha = Cl_alpha(airfoil);
    blades5.aero.Cd0 = Cd0(airfoil);
    blades5.aero.K = k_par(airfoil);
    
    for k = 1:length(twist_angle)
        blades5.twist.thetaTW = twist_angle(k); 
        for i = 1:length(chord_span)
                blades5.c0 = c_0(i);
                blades5.c = chord(blades5, params); 
                blades5 = power_BETMT(params, blades5);
                power(k, i, airfoil) = blades5.P;
                fprintf("-----------LINEAR CASE------------\n")
                fprintf("Number of blades %i \n", blades5.nb)
                fprintf("Twist angle %.2fº \n", blades5.twist.thetaTW)
                fprintf("Airfoil %i \n", airfoil)
                fprintf("c0 = %.2f \n", blades5.c0)
                fprintf("cF = %.2f \n", blades5.cF)
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

if exist('figures_num', 'var')
else
    figures_num = 0;
end

figures_num = figures_num + 1;

figure(figures_num)
plot(c0_minP(1), twist_angle_minP(1), 'rx', 'MarkerSize', 12)
hold on
contourf(c_0, twist_angle, power_0012, 'ShowText', 'on')
hold on
plot(c0_minP(1), twist_angle_minP(1), 'rx', 'MarkerSize', 12)
legend(sprintf('Chord root = %.2f, twist angle = %.2f, Power = %.2f kW', c0_minP(1), twist_angle_minP(1), min_power(1)))
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title(sprintf('Power [kW] (tip chord = 0.1 m), NACA 0012'))
colormap cool
grid on
saveas(gcf, 'plots/5_blades_0012.png')

figures_num = figures_num + 1;

figure(figures_num)
plot(c0_minP(2), twist_angle_minP(2), 'rx', 'MarkerSize', 12)
hold on
contourf(c_0, twist_angle, power_0016, 'ShowText', 'on')
hold on
plot(c0_minP(2), twist_angle_minP(2), 'rx', 'MarkerSize', 12)
legend(sprintf('Chord root = %.2f, twist angle = %.2f, Power = %.2f kW', c0_minP(2), twist_angle_minP(2), min_power(2)))
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title(sprintf('Power [kW] (tip chord = 0.1 m), NACA 0016'))
colormap cool
grid on
saveas(gcf, 'plots/5_blades_0016.png')

figures_num = figures_num + 1;

figure(figures_num)
plot(c0_minP(3), twist_angle_minP(3), 'rx', 'MarkerSize', 12)
hold on
contourf(c_0, twist_angle, power_0020, 'ShowText', 'on')
hold on
plot(c0_minP(3), twist_angle_minP(3), 'rx', 'MarkerSize', 12)
legend(sprintf('Chord root = %.2f, twist angle = %.2f, Power = %.2f kW', c0_minP(3), twist_angle_minP(3), min_power(3)))
xlabel('Chord in the root [m]')
ylabel('Twist angle [deg/m]')
title(sprintf('Power [kW] (tip chord = 0.1 m), NACA 0020'))
colormap cool
grid on
saveas(gcf, 'plots/5_blades_0020.png')

