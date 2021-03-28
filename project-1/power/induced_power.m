function [Cpi] = induced_power(params)
% induced_power computes the induced power coeff applying Momentum Theory, where
% the induced velocity is constant
%
% INPUTS
%     params, struct with fixed parameters
%          R: radius of the disk [m]
%          m: mass [kg]
%      Omega: rotational speed [rad/s]
%          h: altitude [m]
%
% OUTPUTS
%        Cpi, induced power coefficient
%
%%
    
    % thrust coefficient
    CT = thrust_coeff(params);
    
    % induced power coefficient
    Cpi = CT/2 * sqrt(2*CT);
    
    
end