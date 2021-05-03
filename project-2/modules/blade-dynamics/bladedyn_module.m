function [theta0, thetaS] = bladedyn_module(params, alphaD, beta0, betaS, betaC)
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
%          beta0, lateral flapping [rad]
%          betaS, longitudinal flapping [rad]
%          betaC, coning flapping [rad]
%   
% OUTPUTS:
%         theta0, collective angle [rad]
%         thetaS, cyclic angle [rad]
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
    
    % model main equation as A*f = B*p + w - i
    A = [1, 0, 0; 
        1/3 * mu_x, 1/8 * mu_x^2 + 1/4, 0;
        0, 0, 1/8 * mu_x^2 - 1/4];
    
    % flapping response
    f = [beta0;
        betaS;
        betaC];
    
    B = [gamma/8 * (mu_x^2 + 1), gamma/6 * mu_x, 0;
        0, 0, 1/8 * (mu_x^2 + 2); 
        2/3 * mu_x, 1/8 * (2 + 3 * mu_x^2), 0];
    
    % inflow wind
    w = [gamma * lambda_x / 6;
        0;
        lambda_x * mu_x / 2];
    
    % inflow induced velocity
    i = [gamma / 6 * inflow_rat;
        0;
        mu_x / 2 * inflow_rat];
    
    % solve for p
    p = B\(A * f - w + i);
    
    % pilot's input
    theta0 = p(1);
    thetaS = p(2);
    
    
end