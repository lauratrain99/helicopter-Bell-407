function [analysis] = power_BETMT(params, analysis)
% power computes the total power accounting for parasitic + induced 
%
% INPUTS
%     params, struct with fixed parameters
%          R: radius of the helicopter disk [m]
%        rho: density of air [kg/m^3]
%      Omega: rotational speed [rad/s]
%
%   analysis, struct with design variables and results
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
%        Cpi: induced power coefficient
%        Cp0: parasitic power coefficient
%         Pu: nondimensinal power
%          P: total power [kW]
%
%%  
    % get induced and parasitic power
    Cpi = induced_power(params);
    [Cp0, analysis] = parasitic_power(params, analysis);
    
    analysis.Cpi = Cpi;
    analysis.Cp0 = Cp0;
    
    % compute non dimensional power
    analysis.Pu = ref_power(params);
    
    Cp = analysis.Cpi + analysis.Cp0;
    
    analysis.P = analysis.Pu*Cp / 1000;
    
end