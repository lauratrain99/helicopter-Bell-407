% This file finds the optimum constant chord
% for the nominal case

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

%% Design variables for CONSTANT CHORD CASE

% Number of blades
constchord.nb = 4;

% Chord at the root
constchord.c0 = 0.27;                             % m

% Chord at the tip
constchord.cF = 0.27;                             % m

% Chord distribution
constchord.c = chord(constchord, params);            % m

% Twist slope
constchord.twist.thetaTW = -2;                    % deg/m

% NACA 0016
constchord.aero.Cl_alpha = 6.05;                  % 1/rad
constchord.aero.Cd0 = 0.0076;                    
constchord.aero.K = 0.3/constchord.aero.Cl_alpha^2;  % 1/rad^2


%% Analyses
chord_span = linspace(0.01, 1, 100);            % m
power = 0 * chord_span;
for i = 1:length(chord_span)
    constchord.c0 = chord_span(i);                             % m
    constchord.cF = constchord.c0;                             % m
    constchord.c = chord(constchord, params); 
    constchord = power_BETMT(params, constchord);

fprintf("-----------NOMINAL CASE------------\n")
fprintf("The collective angle is %.2fº \n", rad2deg(constchord.twist.theta0))
fprintf("Cpi = %.8f \n", constchord.Cpi)
fprintf("Cp0 = %.8f \n", constchord.Cp0)
fprintf("Total power = %.2f kW \n\n", constchord.P)
power(i) = constchord.P;
end

[min_power, index] = min(power);

if exist('figures_num', 'var')
else
    figures_num = 0;
end

figures_num = figures_num + 1;

figure(figures_num)
plot(chord_span(index), min_power, 'rx', 'MarkerSize', 12)
hold on
plot(chord_span, power, 'b')
hold on
% plot(chord_span(index), min_power, 'rx', 'MarkerSize', 12)
legend(sprintf('Chord = %.2f m, Power = %.2f', chord_span(index), min_power))
title('Costant chord. Nominal case (twist angle = -2 deg/m, NACA 0016)')
xlabel('Chord [m]')
ylabel('Power [kW]')
grid minor
saveas(gcf, 'plots/constant_chord.png')







