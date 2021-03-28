function [Cp0, analysis] = parasitic_power(params, analysis)
% parasitic_power computes the parasitic power coeff applying 
% Blade Element Theory
%
% INPUTS
%     params, struct with fixed parameters
%          R: radius of the helicopter disk [m]
%          m: mass [kg]
%      Omega: rotational speed [rad/s]
%        rho: density of air [kg/m^3]
%          x: nondimensional radial coordinate r/R
%
%   analysis, struct with design variables
%         nb: number of blades
%          c: chord distribution [m]
%         c0: initial chord, at the root [m]
%         cF: final chord, at the tip [m]
%      twist: struct containing twist distribution
%             - thetaTW: slope per unit length[º/m]
%             - thetaT: slope [rad]
%             - theta0: twist angle at the root [rad]
%       aero: struct containing aerodynamic parameters
%             - Cl_alpha: lift coefficient slope [1/rad]
%             - Cd0: viscous drag coefficient
%             - K: Cd quadratic parameter term [1/rad^2]
%
%
% OUTPUTS
%   analysis, struct with design variables and results
%         nb: number of blades
%          c: chord distribution [m]
%         c0: initial chord, at the root [m]
%         cF: final chord, at the tip [m]
%      twist: struct containing twist distribution
%             - thetaTW: slope per unit length[º/m]
%             - thetaT: slope [rad]
%             - theta0: twist angle at the root [rad]
%             - theta: twist angle distribution [rad]
%       aero: struct containing aerodynamic parameters
%             - Cl_alpha: lift coefficient slope [1/rad]
%             - Cd0: viscous drag coefficient
%             - K: Cd quadratic parameter term [1/rad^2]
%             - alpha: angle of attack distrubution [rad]
%             - Cd: sectional drag coefficient distribution 
%             - Cl: sectional lift coefficient distribution
%         CT: thrust coefficient
%      sigma: solidity angle [rad]
%     lambda: inflow ratio
%        phi: inflow angle distribution [rad]
%        Cp0, parasitic power coefficient
%
%%  
    
    % thrust coefficient
    analysis.CT = thrust_coeff(params);
    
    % solidity
    analysis.sigma = solidity(analysis.nb, params.R, analysis.c);
    
    % inflow ratio
    analysis.lambda = inflow_ratio(analysis.CT);
    
    % collective angle
    [analysis.twist.theta0, analysis.twist.thetaT] = collective_angle(params, analysis);
    
    % angle of attack distribution
    analysis.phi = inflow_angle(analysis.lambda, params.x);
    analysis.twist.theta = twist_angle(analysis.twist, params.x);
    analysis.aero.alpha = AoA(analysis.twist.theta, analysis.phi);
    
    % sectional lift coefficient distribution
    analysis.aero.Cl = lift_coeff(analysis.aero);
    
    % sectional drag coefficient distribution
    analysis.aero.Cd = drag_coeff(analysis.aero);
    
    % parasitic power differential
    dCp0 = analysis.sigma .* analysis.aero.Cd  .* params.x.^3 / 2;
    
    % integrate along x to get parasitic power
    Cp0 = trapz(params.x,dCp0);
    
end