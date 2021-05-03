function [TD] = aero_module(params, theta0, thetaS, alphaD, betaC)
% aero_module obtains the actual thrust for given flapping and pilot
% input conditions
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
%         theta0, collective angle [rad]
%         thetaS, cyclic angle [rad]
%         alphaD, helicopter rotor tilt [rad]
%          betaC, coning flapping [rad]
%   
% OUTPUTS:
%              TD, thrust magnitude [N]
%
%%  
    % compute the inflow ratio
    CT = thrust_coeff(params);
    inflow_rat = inflow_ratio(CT);
    
    % get alphaR
    alphaR = alphaD - betaC;
    
    % get non dimensional parameter mu_x
    mu_x = nondim_mux(params, alphaR);
    
    % compute the actual thrust
    TD = params.nb * 1/4 * params.rho * params.c0 * params.Cl_alpha * ...
         params.Omega^2 * params.R^3 * (mu_x * thetaS + theta0 * (2/3 + mu_x^2) + ...
         params.V/(params.Omega * params.R) * sin(alphaR) - ...
         2*trapz(params.x, inflow_rat*params.x));
     
    
end