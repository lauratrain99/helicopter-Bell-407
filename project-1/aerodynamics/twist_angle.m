function [theta] = twist_angle(twist, x)
% twist_angle gets the twist angle distribution along the radial
% coordinate
%
% INPUTS
%     twist, struct with twist parameters
%    theta0: collective angle [rad]
%    thetaT: geometric slope [1/rad]
%
% OUTPUTS
%     theta, twist distribution [rad]
%    
%%
    theta = twist.theta0 + twist.thetaT*x;
    
end
