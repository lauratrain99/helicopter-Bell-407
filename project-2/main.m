clear; clc; close all;

% WORKFLOW ARRAGEMENT 2 analysis

%% Add paths

addpath conversions/
addpath modules/aerodynamics
addpath modules/blade-dynamics
addpath modules/trim

%% Fixed parameters

params.R = 5.33;                               % radius of the disk [m]
params.m = 2040;                               % total mass [kg]
params.Omega = rpm2rad_s(413);                 % rotational speed [rad/s]
params.h = ft2m(15000);                        % flight altitude [m]
params.rho = ISA_atmosphere(params.h);         % density of air [kg/m^3]
params.x = linspace(0.001,1,100)';             % non dimensional x vector
params.nb = 4;                                 % number of blades
params.c0 = 0.27;                              % constant chord [m]
params.Cl_alpha = 6.05;                        % lift coeff slope [1/rad]
params.V = 10;                                 % forward velocity [m/s]
params.SFP = 2;                                % reference area [m^2]
params.Iy = 100;                               % pitch moment of inertia [kg*m^2]

%% Iterative procedure - WORKFLOW ARRANGEMENT 2

% input a value for the lateral flapping
beta0 = pi/8;

% compute the trim values
% alphaD_req, rotor disk tilting
% betaC_req, coning flapping
% TD_req, thrust requirements
[alphaD_req, betaC_req, betaS_req, TD_req] = trim_module(params);

% compute the pilot's input 
% theta0, collective angle
% thetaS, cyclic angle
[theta0, thetaS] = bladedyn_module(params, alphaD_req, beta0, betaS_req, betaC_req);

% compute the actual thrust
TD = aero_module(params, thetaS, theta0, alphaD_req, betaC_req);

%% Results
fprintf("--------RESULTS-------- \n\n")
fprintf("The needed thrust for trim is %.2f N \n", TD_req)
fprintf("The cyclic angle the pilot should input is %.2f deg \n", rad2deg(thetaS))
fprintf("The collective angle the pilot should input is %.2f deg \n", rad2deg(theta0))


