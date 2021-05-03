function [lambda] = inflow_ratio(CT)
% inflow_ratio gets the inflow ratio for hover flight
%
% INPUTS
%         CT, thrust coefficient
%
% OUTPUTS
%     lambda, inflow ratio vi/(Omega*R)
%    
%%
    lambda = 1/2 * sqrt(2*CT);
    
end


