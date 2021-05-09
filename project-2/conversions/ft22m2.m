function [h_m2] = ft22m2(h_ft2)
% ft2m transforms a distance from feet^2 to meters^2
%
% INPUTS
%                       h_ft2, distance [ft]
%
% OUTPUTS
%                        h_m2, distance [m]
%    
%%
    h_m2 = h_ft2 * 0.3048^2;
    
end
