function [phi] = inflow_angle(lambda, x)
% inflow_angle gets the inflow angle distribution along the radial
% coordinate
%
% INPUTS
%     lambda, inflow ratio
%          x, r/R coordinate
%
% OUTPUTS
%        phi, inflow angle [rad]
%    
%%
    phi = lambda./x;
    
end

