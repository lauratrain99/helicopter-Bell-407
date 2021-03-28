function [c] = chord(analysis, params)
% chord computes the chord distribution along the radial coordinate
%
% INPUTS
%   analysis, struct with design variables
%         c0: chord at the root, initial chord [m]
%         cF: chord at the tip, final chord [m]
%
%
% OUTPUTS
%          c, chord distribution [m]
%    
%%
        c = analysis.c0 + (analysis.cF - analysis.c0) * params.x;
    
end

