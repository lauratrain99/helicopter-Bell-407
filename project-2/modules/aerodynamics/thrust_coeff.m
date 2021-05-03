function [CT] = thrust_coeff(params)
% thrust_coeff gets the CT using Momentum Theory
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

