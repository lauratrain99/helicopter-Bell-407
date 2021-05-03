function [lambda_x] = nondim_lambda_x(params, alphaR)
% lambda_x obtains the lambda_x parameter in blade dynamics theory
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
%         alphaR, helicopter rotor tilt - coning flapping[rad]
%   
% OUTPUTS:
%       lambda_x, non dimensional lambda_x parameter
%  
%%    
    lambda_x = params.V / (params.Omega * params.R) * sin(alphaR);

end

