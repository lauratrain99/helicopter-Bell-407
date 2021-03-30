

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
nominal.nb = 4;

% Chord at the root
nominal.c0 = 0.34;                             % m

% Chord at the tip
nominal.cF = 0.1;                             % m

% Chord distribution
nominal.c = chord(nominal, params);            % m

% Twist slope
nominal.twist.thetaTW = -2;                    % deg/m

% NACA 0016
nominal.aero.Cl_alpha = 6.05;                  % 1/rad
nominal.aero.Cd0 = 0.0076;                    
nominal.aero.K = 0.3/nominal.aero.Cl_alpha^2;  % 1/rad^2


%% Analyses

twist_angle = linspace(-10, 10, 100);
power = 0 * twist_angle;
for i = 1:length(twist_angle)
    nominal.twist.thetaTW = twist_angle(i);  
    nominal = power_BETMT(params, nominal);
    fprintf("-----------NOMINAL CASE------------\n")
    fprintf("The collective angle is %.2fº \n", rad2deg(nominal.twist.theta0))
    fprintf("Cpi = %.8f \n", nominal.Cpi)
    fprintf("Cp0 = %.8f \n", nominal.Cp0)
    fprintf("Total power = %.2f kW \n\n", nominal.P)
    power(i) = nominal.P;
end

[min_power, index] = min(power);


if exist('figures_num', 'var')
else
    figures_num = 0;
end

figures_num = figures_num + 1;
figure(figures_num)
plot(twist_angle(index), min_power, 'rx', 'MarkerSize', 12)
hold on
plot(twist_angle, power, 'b')
title('Power vs twist angle. c0 = 0.34 m, cF = 0.1 m. NACA 0016')
legend(sprintf('twist angle = %.2f deg/m, Power = %.2f kW', twist_angle(index), min_power))
xlabel('Twist angle [deg/m]')
ylabel('Power [kW]')
grid minor
saveas(gcf, 'plots/linear_twist.png')



