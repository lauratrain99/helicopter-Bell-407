function [Iy] = pitch_inertia(params)
% pitch_inertia gets the Moment of Inertia Iy of the blade
% blade is made of fiberglass composite (fc) of density rho_fc
% thickness is defined by NACA0016
% Assumptions:rectangular blade with uniform distribution of material
%
% INPUT:
%               params.c0, chord
%               params.R0, blade length
%               
% OUTPUT:
%               params.Iy, Moment of inertia of blade
%
%%
    rho_fc = 1522.4;
    thickness = 0.16;
    CrossArea = thickness*params.c0;
    Volume = CrossArea*params.R;
    mblade = rho_fc*Volume;
    rho_s = mblade/(params.R*params.c0);

    Iy = (mblade*params.R^2)/4 + (rho_s*params.c0*params.R^3)/4;

end