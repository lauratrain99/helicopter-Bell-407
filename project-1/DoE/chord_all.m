
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
chord_span = linspace(0.1, 1, 100);            % m
[c_0, c_F] = meshgrid(chord_span);
power = 0 * c_0;
for i = 1:length(chord_span)
    for j = 1:length(chord_span)
        nominal.c0 = c_0(i, j);                             % m
        nominal.cF = c_F(i, j);                             % m
        nominal.c = chord(nominal, params); 
        nominal = power_BETMT(params, nominal);

        fprintf("-----------LINEAR CHORD, CONSTANT TWIST------------\n")
        fprintf("The collective angle is %.2fº \n", rad2deg(nominal.twist.theta0))
        fprintf("c0 = %.2f \n", nominal.c0)
        fprintf("cF = %.2f \n", nominal.cF)
        fprintf("Total power = %.2f kW \n\n", nominal.P)
        power(i, j) = nominal.P;
    end
end

[min_power, minIdx] = min(power(:)); 
[row,col] = ind2sub(size(power),minIdx); 
xMin = c_0(row,col); 
yMin = c_F(row,col); 

if exist('figures_num', 'var')
else
    figures_num = 0;
end

figures_num = figures_num + 1;

figure(figures_num)
plot(xMin, yMin, 'rx', 'MarkerSize', 12)
hold on
contourf(c_0, c_F, power, 'ShowText', 'on')
hold on 
plot(xMin, yMin, 'rx', 'MarkerSize', 12)
xlabel('Chord in the root [m]')
ylabel('Chord in the tip [m]')
legend(sprintf('Chord i the root = %.2f m, Chord in the tip = %.2f m, power = %.2f kW', xMin, yMin, min_power))
title('Power [kW] vs chord distribution. Nominal case')
grid on
colormap cool
saveas(gcf, 'plots/linear_chord.png')
% shading interp
% colorbar

% Mark min  on plot

figures_num = figures_num + 1;

data_wanted = linspace(290, 300, 11);
figure(figures_num)
plot(xMin, yMin, 'rx', 'MarkerSize', 12)
hold on
contourf(c_0, c_F, power, data_wanted,'ShowText', 'on')
hold on 
plot(xMin, yMin, 'rx', 'MarkerSize', 12)
xlim([0.15, 0.8])
ylim([min(chord_span), 0.25])
xlabel('Chord in the root [m]')
ylabel('Chord in the tip [m]')
legend(sprintf('Chord i the root = %.2f m, Chord in the tip = %.2f m, power = %.2f kW', xMin, yMin, min_power))
title('Power [kW] vs chord distribution. Nominal case')
grid on
colormap cool
saveas(gcf, 'plots/linear_chord_detail.png')
% fprintf("-----------LINEAR CHORD CASE------------\n")
% % fprintf("The collective angle is %.2fÂº \n", rad2deg(nominal.twist.theta0))
% fprintf("c0 = %.2f \n", xMin)
% fprintf("cF = %.2f \n", yMin)
% fprintf("Minimum power = %.2f kW \n\n", power(row, col))