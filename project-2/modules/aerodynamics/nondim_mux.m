function [mux] = nondim_mux(params, alphaR)
% nondim_mux gets the parameter mu_x for blade dynamics theory
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
%            mux, non dimensional forward flight parameter
%    
%%  
    mux = params.V / (params.Omega * params.R) * cos(alphaR);
    
end
