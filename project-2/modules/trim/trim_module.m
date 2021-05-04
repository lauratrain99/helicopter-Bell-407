function [alphaD, betaC, betaS, TD] = trim_module(params)
% trim_module obtains the thrust magnitude, the inclination of the rotor disk
% plane to the horizon and the flapping cyclic angle to trim the helicopter
% longitudinally assuming steady flight
%
% INPUTS:
%         params, structure with all the fixed parameters in the problem
%              R: radius of the disk [m]
%              m: total mass [kg]
%          Omega: rotational speed [rad/s]
%              h: flight altitude [m]
%            rho: density of air [kg/m^3]
%              x: non dimensional x vector
%             nb: number of blades
%             c0: constant chord [m]
%       Cl_alpha: lift coeff slope [1/rad]
%              V: forward velocity [m/s]
%            SFP: reference area [m^2]
%             Iy: pitch moment of inertia [kg*m^2]
%   
% OUTPUTS:
%          alphaD, rotor disk tilting wrt horizon [rad]
%           betaC, rotor disk tilting wrt helicopter [rad]
%           betaS, side flapping [rad]
%              TD, thrust magnitude [N]
%
%%
    % compute weight
    g = 9.81;
    W = params.m * g;
    
    % get drag
    Df = drag(params);
    
    % rotor disk tilting
    alphaD = - Df/W;
    
    % cyclic flapping
    betaC = atan(0.15/1.5);
    
    % side flapping
    betaS = 0;
    
    % thrust requirement
    TD = W;
    
end