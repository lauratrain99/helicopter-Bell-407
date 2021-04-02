clear; clc; close all;

% This file runs the nominal case for the three different 
% aerodynamic profiles

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
aeroProfiles.nb = 4;

% Chord at the root
aeroProfiles.c0 = 0.27;                             % m

% Chord at the tip
aeroProfiles.cF = 0.27;                             % m

% Chord distribution
aeroProfiles.c = chord(aeroProfiles, params);            % m

% Twist slope
aeroProfiles.twist.thetaTW = -2;                    % deg/m

% NACA 0016
aeroProfiles.aero.Cl_alpha = 6.05;                  % 1/rad
aeroProfiles.aero.Cd0 = 0.0076;                    
aeroProfiles.aero.K = 0.3/aeroProfiles.aero.Cl_alpha^2;  % 1/rad^2


%% Analyses

%NACA 0012, NACA 0016, NACA0020
Cd0 = [0.0061, 0.0076, 0.0090];
Cl_alpha = [5.63, 6.05, 4.51];
k = [0.0138, 0.3, 0.456] ./Cl_alpha.^2;

for airfoil = 1:3
    aeroProfiles.aero.Cl_alpha = Cl_alpha(airfoil);
    aeroProfiles.aero.Cd0 = Cd0(airfoil);
    aeroProfiles.aero.K = k(airfoil);
    aeroProfiles = power_BETMT(params, aeroProfiles);
    fprintf("-----------NOMINAL CASE, AERO OPTIMIZATION------------\n")
    fprintf("The collective angle is %.2fº \n", rad2deg(aeroProfiles.twist.theta0))
    fprintf("Cpi = %.8f \n", aeroProfiles.Cpi)
    fprintf("Cp0 = %.8f \n", aeroProfiles.Cp0)
    fprintf("Total power = %.2f kW \n\n", aeroProfiles.P)
    power(airfoil) = aeroProfiles.P;
end



