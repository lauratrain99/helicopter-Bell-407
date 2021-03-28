function [alpha] = AoA(theta, phi)
% AoA gets the angle of attack distribution along the radial coordinate
%
% INPUTS
%      theta, twist angle distribution [rad]
%        phi, inflow angle distribution [rad]
%
% OUTPUTS
%      alpha, angle of attack distribution [rad]
%    
%%
    alpha = theta - phi;
    
end

