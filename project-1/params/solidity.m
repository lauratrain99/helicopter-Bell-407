function [sigma] = solidity(nb, R, c)
% solidity computes the solidity angle as a function of the chord
% distribution
%
% INPUTS
%         nb, number of blades
%          R, radius of the disk [m]
%          c, chord distribution [m]. Scalar if the chord = const, vector if
%             the distribution varies along the radial coordinate
%
% OUTPUTS
%      sigma, solidity angle [rad]
%    
%%
    sigma = nb*c / (pi*R);
    
end

