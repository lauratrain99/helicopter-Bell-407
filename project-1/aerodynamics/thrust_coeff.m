function [CT] = thrust_coeff(params)
% thrust_coeff gets the CT using Momentum Theory
%
% INPUTS
%     params, struct with fixed parameters
%          R: radius of the disk [m]
%          m: mass [kg]
%      Omega: rotational speed [rad/s]
%        rho: density of air [kg/m^3]
%
% OUTPUTS
%         CT, thrust coefficient
%    
%%  
    % gravity [m/s^2]
    g = 9.81;                                 
    
    % thrust coeff []
    CT  = params.m*g / (params.rho*pi*params.R^2*(params.Omega*params.R)^2);
    
end

