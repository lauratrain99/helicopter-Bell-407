function [beta0, thetaS, thetaC] = bladedyn_module(params, alphaD, theta0, betaS, betaC)
% bladedyn_module obtains the pilot's input required for given flapping
% conditions
%
% INPUTS:
%         params, structure with all the fixed parameters in the problem
%              R: radius of the disk [m]
%              m: total mass [kg]
%          Omega: rotational speed [rad/s]
%              h: flight altitude [m]
%            rho: density of air [kg/m^3]
%              x: non dimensional x vector
%             nb: number of blades
%             c0: constant chord [m]
%       Cl_alpha: lift coeff slope [1/rad]
%              V: forward velocity [m/s]
%            SFP: reference area [m^2]
%             Iy: pitch moment of inertia [kg*m^2]
%         alphaD, helicopter rotor tilt [rad]
%         theta0, collective angle [rad]
%          betaS, longitudinal flapping [rad]
%          betaC, coning flapping [rad]
%   
% OUTPUTS:
%          beta0, lateral flapping [rad]
%         thetaS, cyclic angle [rad]
%         thetaC, coning angle [rad]
%
%%
    % compute inflow ratio
    CT = thrust_coeff(params);
    inflow_rat = inflow_ratio(CT);
    
    % get alphaR
    alphaR = alphaD - betaC;
    
    % get parameters mu_x, gamma and lambda_x,
    mu_x = nondim_mux(params, alphaR);
    gamma = nondim_gamma(params);
    lambda_x = nondim_lambda_x(params, alphaR);
    
    % the goal is to get a vector with [beta0, thetaS, thetaC]
    % we have [theta0, betaS, betaC]
    % model main equation as A*output = B*input + w - i
    A = [gamma/8 * (mu_x^2 + 1), 0, 0; 
        0, 1/8 * mu_x^2 + 1/4, 0;
        2/3 * mu_x, 0, 1/8 * mu_x^2 - 1/4];
    
    % input
    input = [theta0;
            betaS;
            betaC];
    
    B = [1, gamma/6 * mu_x, 0;
        1/3 * mu_x, 0, 1/8 * (mu_x^2 + 2); 
        0, 1/8 * (2 + 3 * mu_x^2), 0];
    
    % inflow wind
    w = [gamma * lambda_x / 6;
        0;
        lambda_x * mu_x / 2];
    
    % inflow induced velocity
    i = [gamma / 6 * inflow_rat;
        0;
        mu_x / 2 * inflow_rat];
    
    % solve for output
    output = B\(A * input - w + i);
    
    beta0 = output(1);
    thetaS = output(2);
    thetaC = output(3);
    
    
end