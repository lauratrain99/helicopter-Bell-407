function [Cl] = lift_coeff(aero)
% lift_coeff computes the sectional lift coefficient
%
% INPUTS
%       aero, struct with aerodynamic parameters
%   Cl_alpha: lift coefficient slope [1/rad]
%      alpha: AoA distribution [rad]
%
% OUTPUTS
%         Cl, section lift coeff distribution
%
%%
     Cl = aero.Cl_alpha*aero.alpha;
     
end

