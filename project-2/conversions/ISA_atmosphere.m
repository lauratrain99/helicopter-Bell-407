function [rho] = ISA_atmosphere(h)
% ISA_atmosphere computes the density of air at a certain height h in
% meters in the troposphere (valid up to 11 km)
%
% INPUTS
%               h, altitude from sea level [m]
%
% OUTPUTS
%             rho, density of air [kg/m^3]
% 
%%
    % constants
    R = 287.058;                            % J/(kg*K)                     
    az = -6.5e-3;                           % K/m
    g = 9.81;                               % m/s^2
    
    % stagnation conditions
    poISA = 101300;                         % Pa
    ToISA = 288.15;                         % K
    
    % atmospheric properties
    T = ToISA + az*h;                       % K
    p = poISA*(T/ToISA).^(-g/(az*R));       % Pa
    rho = p/(R*T);                          % kg/m^3
    
end