function [theta0, thetaT] = collective_angle(params, analysis)
% collective_angle gets the value for the collective angle and the twist
% slope
%
% INPUTS
%     params, struct with fixed parameters
%         nb: number of blades
%          R: radius of the helicopter disk [m]
%          x: nondimensional radial coordinate r/R
%
%   analysis, struct with design variables and results
%      sigma: solidity angle [rad]
%      twist: struct containing twist distribution
%             - thetaTW: slope per unit length[º/m]
%             - thetaT: slope [rad]
%     lambda: inflow ratio
%       aero: struct containing aerodynamic parameters
%             - Cl_alpha: lift coefficient slope [1/rad]
%         CT: thrust coefficient
%
% OUTPUTS
%     theta0, collective angle [rad]
%     thetaT, geometric twist slope [1/rad]
%    
%%  
    % get geometric twist slope
    thetaT = deg2rad(analysis.twist.thetaTW) * params.R;
    %theta0 = 6/(sigma*Cl_alpha)*CT + 3*lambda/2 - 3*thetaT/4;
    
    % get collective angle by solving an implicit equation
    f = @(collective) trapz(params.x, analysis.sigma.*analysis.aero.Cl_alpha / 2 .*(collective + thetaT*params.x - 1./params.x * analysis.lambda).*params.x.^2) - analysis.CT;
    theta0 = fzero(f,0.5);
     
end


