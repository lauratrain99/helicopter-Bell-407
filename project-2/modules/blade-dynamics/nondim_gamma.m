function [gamma] = nondim_gamma(params)
% nondim_gamma obtains the gamma parameter in blade dynamics theory
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
%   
% OUTPUTS:
%          gamma, non dimensional gamma parameter
%  
%%
    gamma = params.rho * params.Cl_alpha * params.R^4 * params.c0 / params.Iy;

end

