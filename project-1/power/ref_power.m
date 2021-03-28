function [Pu] = ref_power(params)
% ref_power gets the reference nondimensional power using Momentum Theory
%
% INPUTS
%     params, struct with fixed parameters
%          R: radius of the disk [m]
%          m: mass [kg]
%      Omega: rotational speed [rad/s]
%        rho: density of air [kg/m^3]
%
% OUTPUTS
%         Pu, reference nondimensional power
%    
%%                                 
    Pu = params.rho*pi*params.R^2*(params.Omega*params.R)^3;
    
end

