function [Cd] = drag_coeff(aero)
% drag_coeff computes the sectional drag coefficient
%
% INPUTS
%       aero, struct with aerodynamic parameters
%        Cd0: viscous drag coeff
%          K: Cd quadratic parameter term [1/rad^2]   
%      alpha: AoA distribution [rad]
%
% OUTPUTS
%         Cd, section drag coeff distribution
%
%%  
    Cd = aero.Cd0 + aero.K*aero.Cl.^2;
     
end

